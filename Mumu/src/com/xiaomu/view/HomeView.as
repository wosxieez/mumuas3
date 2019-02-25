package com.xiaomu.view
{
	import com.xiaomu.component.CardUI;
	import com.xiaomu.event.ApiEvent;
	import com.xiaomu.util.Actions;
	import com.xiaomu.util.Api;
	import com.xiaomu.util.Assets;
	import com.xiaomu.util.Audio;
	import com.xiaomu.util.CardUtil;
	import com.xiaomu.util.Notifications;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import coco.component.Image;
	import coco.core.UIComponent;
	
	public class HomeView extends UIComponent
	{
		public function HomeView()
		{
			super();
			
			Api.getInstane().addEventListener(ApiEvent.Notification, onNotificationHandler)
		}
		
		private var bg:Image
		private var bgline:Image
		private var user1line:Image
		private var user1bg:Image
		private var user1icon:Image
		private var user2line:Image
		private var user2bg:Image
		private var user2icon:Image
		private var user3line:Image
		private var user3bg:Image
		private var user3icon:Image
		private var cardLayer: UIComponent
		private var dealCardUI: CardUI
		private var iconLayer:UIComponent
		private var myUser:Object
		private var preUser:Object
		private var nextUser:Object
		private var myHandCardUIs:Array = []
		private var myGroupCardUIs:Array = []
		private var myPassCardUIs:Array = []
		private var roominfo:Object
		private var oldPoint:Point
		private var isDrag:Boolean = false
		private var isCheckNewCard:Boolean = false // 是否在等待出牌
		private var thisCanPengCards:Array
		private var thisCanChiCards:Array
		
		private var canPengButton:Image
		private var canChiButton:Image
		private var cancelButton:Image
		private var newCardTip:Image
		
		override protected function createChildren():void {
			super.createChildren()
			
			// 背景层
			bg = new Image()
			bg.source = Assets.getInstane().getAssets('fight_bg.png')
			addChild(bg)
			
			bgline = new Image()
			bgline.height = 60
			bgline.source = Assets.getInstane().getAssets('fight_down_bg.png')
			addChild(bgline)
			// 卡牌层
			cardLayer = new UIComponent()
			addChild(cardLayer)
			
			dealCardUI = new CardUI()
			dealCardUI.height = 70
			dealCardUI.card = 10
			cardLayer.addChild(dealCardUI)
			
			// 图标层
			iconLayer = new UIComponent()
			addChild(iconLayer)
			
			// 增加三个图像
			user1line = new Image()
			user1line.width = 80
			user1line.height = 30
			user1line.source = Assets.getInstane().getAssets('fight_userinfo_bg2.png')
			iconLayer.addChild(user1line)
			user1bg = new Image()
			user1bg.width = user1bg.height = 30
			user1bg.source = Assets.getInstane().getAssets('fight_userinfo_circle_bg.png')
			iconLayer.addChild(user1bg)
			user1icon = new Image()
			user1icon.width = user1icon.height = 20
			user1icon.source = Assets.getInstane().getAssets('avatar1.png')
			iconLayer.addChild(user1icon)
			
			user2line = new Image()
			user2line.width = 80
			user2line.height = 30
			user2line.source = Assets.getInstane().getAssets('fight_userinfo_bg2.png')
			iconLayer.addChild(user2line)
			user2bg = new Image()
			user2bg.width = user2bg.height = 30
			user2bg.source = Assets.getInstane().getAssets('fight_userinfo_circle_bg.png')
			iconLayer.addChild(user2bg)
			user2icon = new Image()
			user2icon.width = user2icon.height = 20
			user2icon.source = Assets.getInstane().getAssets('avatar2.png')
			iconLayer.addChild(user2icon)
			
			user3line = new Image()
			user3line.width = 80
			user3line.height = 30
			user3line.source = Assets.getInstane().getAssets('fight_userinfo_bg2.png')
			iconLayer.addChild(user3line)
			user3bg = new Image()
			user3bg.width = user3bg.height = 30
			user3bg.source = Assets.getInstane().getAssets('fight_userinfo_circle_bg.png')
			iconLayer.addChild(user3bg)
			user3icon = new Image()
			user3icon.width = user3icon.height = 20
			user3icon.source = Assets.getInstane().getAssets('avatar3.png')
			iconLayer.addChild(user3icon)
			
			canPengButton = new Image()
			canPengButton.source = Assets.getInstane().getAssets('oprate_peng0.png')
			canPengButton.width = canPengButton.height = 30
			canPengButton.visible = false
			canPengButton.addEventListener(MouseEvent.CLICK, canPengButton_clickHandler)
			iconLayer.addChild(canPengButton)
			
			canChiButton = new Image()
			canChiButton.source = Assets.getInstane().getAssets('oprate_chi0.png')
			canChiButton.width = canChiButton.height = 30
			canChiButton.visible = false
			canChiButton.addEventListener(MouseEvent.CLICK, canChiButton_clickHandler)
			iconLayer.addChild(canChiButton)
			
			cancelButton = new Image()
			cancelButton.source = Assets.getInstane().getAssets('oprate_close0.png')
			cancelButton.width = cancelButton.height = 30
			cancelButton.visible = false
			cancelButton.addEventListener(MouseEvent.CLICK, cancelButton_clickHandler)
			iconLayer.addChild(cancelButton)
			
			newCardTip = new Image()
			newCardTip.width = 100
			newCardTip.height = 16
			newCardTip.visible = false
			newCardTip.source = Assets.getInstane().getAssets('fight_txt_finger_tips.png')
			iconLayer.addChild(newCardTip)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			this.myUser = {username: 'wosxieez', handCards: [1, 3, 5, 4, 4, 3, 11, 15, 18, 19, 11, 10, 9, 9, 8, 16, 17, 18, 9, 10, 8]}
			updateMyHandCardUIs()
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			bg.width = width
			bg.height = height
			
			bgline.width = width
			bgline.y = height - 60
			
			dealCardUI.x = (width - dealCardUI.width) / 2
			dealCardUI.y = (height - dealCardUI.height) / 2 - 50
			
			user1line.x = 20
			user1line.y = 10
			user1bg.x = user1line.x - 15
			user1bg.y = user1line.y
			user1icon.x = user1bg.x + 5
			user1icon.y = user1bg.y + 5
			
			user2line.x = width / 2 - 40
			user2line.y = height - 35
			user2bg.x = user2line.x - 5
			user2bg.y = user2line.y
			user2icon.x = user2bg.x + 5
			user2icon.y = user2bg.y + 5
			
			user3line.x = width - 80
			user3line.y = 10
			user3bg.x = user3line.x - 15
			user3bg.y = user3line.y
			user3icon.x = user3bg.x + 5
			user3icon.y = user3bg.y + 5
			
			canPengButton.x = width - canPengButton.width - 20
			canPengButton.y = (height - canChiButton.height) / 2 - 20
			
			canChiButton.x = width - canChiButton.width - 20
			canChiButton.y = (height - canChiButton.height) / 2 - 20
			
			cancelButton.x = width - cancelButton.width - 20
			cancelButton.y = (height - cancelButton.height) / 2 + 20
			
			newCardTip.x = (width - newCardTip.width) / 2
			newCardTip.y = (height - newCardTip.height) / 2
		}
		
		override protected function drawSkin():void {
			super.drawSkin()
		}
		
		private function initRoomInfo(roominfo:Object):void {
			if (roominfo) {
				this.roominfo = roominfo
				for (var i:int = 0; i < roominfo.users.length; i++) {
					if (roominfo.users[i].username == Api.getInstane().username) {
						var endUsers:Array = roominfo.users.slice(i)
						var startUsers:Array = roominfo.users.slice(0, i)
						var orderUsers:Array = endUsers.concat(startUsers)
						this.myUser = orderUsers[0]
						this.nextUser = orderUsers[1]
						this.preUser = orderUsers.pop()
						break
					}
				}
			}
		}
		
		/**
		 *  更新我的牌视图
		 */		
		private function updateMyHandCardUIs():void {
			if (myUser) {
				const riffleCards:Array = CardUtil.getInstane().riffle(myUser.handCards)
				var oldMyHandCardUIs:Array = []
				for each(var cardUI: CardUI in myHandCardUIs) {
					cardUI.visible = false
					oldMyHandCardUIs.push(cardUI)
				}
				myHandCardUIs = []
				const cardWidth:Number = 35
				const cardHeight:Number = 50
				const horizontalGap:Number = 2
				const verticalGap:Number = 30
				var newCardUI:CardUI
				var startX:Number = (width - riffleCards.length * (cardWidth + horizontalGap)) / 2
				for (var i:int = 0; i < riffleCards.length; i++) {
					var groupCards:Array = riffleCards[i]
					for (var j:int = 0; j < groupCards.length; j++) {
						newCardUI = oldMyHandCardUIs.pop()
						if (!newCardUI) {
							newCardUI = new CardUI()
							newCardUI.addEventListener(MouseEvent.MOUSE_DOWN, cardUI_mouseDownHandler)
							newCardUI.addEventListener(MouseEvent.MOUSE_UP, cardUI_mouseUpHandler)
							cardLayer.addChild(newCardUI)
						}
						newCardUI.visible = true
						newCardUI.width = cardWidth
						newCardUI.height = cardHeight
						newCardUI.x = startX + i * (newCardUI.width + horizontalGap)
						newCardUI.y = height - newCardUI.height - j * verticalGap - 25
						newCardUI.card = riffleCards[i][j]
						newCardUI.type = CardUI.TYPE_BIG_CARD
						cardLayer.setChildIndex(newCardUI, 0)
						myHandCardUIs.push(newCardUI)
					}
				}
				
			}
		}
		/**
		 *  更新我的组合牌视图
		 */		
		private function updateMyGroupCardUIs():void {
			if (myUser) {
				const riffleCards:Array = this.myUser.groupCards
				var oldMyGroupCardUIs:Array = []
				for each(var cardUI: CardUI in myGroupCardUIs) {
					cardUI.visible = false
					oldMyGroupCardUIs.push(cardUI)
				}
				myGroupCardUIs = []
				const cardWidth:Number = 20
				const cardHeight:Number = 25
				const horizontalGap:Number = 2
				const verticalGap:Number = 20
				var newCardUI:CardUI
				var startX:Number = 10
				for (var i:int = 0; i < riffleCards.length; i++) {
					var groupCards:Array = riffleCards[i]
					for (var j:int = 0; j < groupCards.length; j++) {
						newCardUI = oldMyGroupCardUIs.pop()
						if (!newCardUI) {
							newCardUI = new CardUI()
							cardLayer.addChild(newCardUI)
						}
						newCardUI.visible = true
						newCardUI.width = cardWidth
						newCardUI.height = cardHeight
						newCardUI.x = startX + i * (newCardUI.width + horizontalGap)
						newCardUI.y = height - newCardUI.height - j * verticalGap - 50
						newCardUI.card = riffleCards[i][j]
						newCardUI.type = CardUI.TYPE_SMALL_CARD
						cardLayer.setChildIndex(newCardUI, 0)
						myGroupCardUIs.push(newCardUI)
					}
				}
				
			}
		}
		/**
		 *  更新我的弃牌视图
		 */		
		private function updateMyPassCardUIs():void {
			if (myUser) {
				const riffleCards:Array = this.myUser.passCards
				var oldMyPassCardUIs:Array = []
				for each(var cardUI: CardUI in myPassCardUIs) {
					cardUI.visible = false
					oldMyPassCardUIs.push(cardUI)
				}
				myPassCardUIs = []
				const cardWidth:Number = 20
				const cardHeight:Number = 25
				const horizontalGap:Number = 2
				var newCardUI:CardUI
				var startX:Number = 10
				for (var i:int = 0; i < riffleCards.length; i++) {
					newCardUI = oldMyPassCardUIs.pop()
					if (!newCardUI) {
						newCardUI = new CardUI()
						cardLayer.addChild(newCardUI)
					}
					newCardUI.visible = true
					newCardUI.width = cardWidth
					newCardUI.height = cardHeight
					newCardUI.x = startX + i * (newCardUI.width + horizontalGap)
					newCardUI.y = height - newCardUI.height - 20
					newCardUI.card = riffleCards[i]
					newCardUI.type = CardUI.TYPE_SMALL_CARD
					cardLayer.setChildIndex(newCardUI, 0)
					myPassCardUIs.push(newCardUI)
				}
				
			}
		}
		
		protected function cardUI_mouseDownHandler(event:MouseEvent):void
		{
			const cardUI:CardUI = event.currentTarget as CardUI
			if (cardUI && this.isCheckNewCard) {
				oldPoint = cardLayer.localToGlobal(new Point(cardUI.x, cardUI.y))
				cardUI.startDrag()
				isDrag = true
			}
		}
		
		protected function cardUI_mouseUpHandler(event:MouseEvent):void
		{
			const cardUI:CardUI = event.currentTarget as CardUI
			if (cardUI) {
				if (isDrag) {
					stopDrag()
					const thisPoint:Point = cardLayer.globalToLocal(oldPoint)
					event.currentTarget.x = thisPoint.x
					event.currentTarget.y = thisPoint.y
					isDrag = false
				}
				
				if (isCheckNewCard) {
					const action:Object = { name: Actions.NewCard, data: cardUI.card }
					Api.getInstane().sendAction(action)
					newCardTip.visible = false
					isCheckNewCard = false
				}
			}
		}
		
		protected function onNotificationHandler(event:ApiEvent):void
		{
			const notification: Object = event.notification
			switch(notification.name)
			{
				case Notifications.onNewRound:
				{
					initRoomInfo(notification.data)
					updateMyHandCardUIs()
					break;
				}
				case Notifications.checkNewCard: {
					// 请出牌
					cancelButton.visible = canChiButton.visible = canPengButton.visible = false
					
					if (notification.data.username == Api.getInstane().username) {
						trace('请出牌')
						newCardTip.visible = true
						isCheckNewCard = true
					}
					break
				}
				case Notifications.onNewCard: {
					trace('新牌')
					cancelButton.visible = canChiButton.visible = canPengButton.visible = false
					dealCardUI.card = notification.data.deal_card
					Audio.getInstane().playCard(notification.data.deal_card)
					initRoomInfo(notification.data)
					updateMyHandCardUIs()
					updateMyGroupCardUIs()
					updateMyPassCardUIs()
					break
				}
				case Notifications.checkPeng: {
					// 检查碰
					trace('检查碰', notification.data)
					cancelButton.visible = canChiButton.visible = canPengButton.visible = false
					if (notification.data.username == Api.getInstane().username) {
						const canPengCards:Array = CardUtil.getInstane().canPeng(this.myUser.handCards, notification.data.card)
						if (canPengCards) {
							thisCanPengCards = canPengCards
							canPengButton.visible = cancelButton.visible = true
						} else {
							trace('不能碰 直接取消')
							const action:Object = { name: Actions.Cancel, data: '' }
							Api.getInstane().sendAction(action)
						}
					}
					break
				}
				case Notifications.onPeng: {
					trace('有人碰')
					Audio.getInstane().playHandle('peng')
					initRoomInfo(notification.data)
					updateMyHandCardUIs()
					updateMyGroupCardUIs()
					updateMyPassCardUIs()
					break
				}
				case Notifications.checkEat: {
					// 检查吃
					trace('检查吃')
					cancelButton.visible = canChiButton.visible = canPengButton.visible = false
					if (notification.data.username == Api.getInstane().username) {
						const canChiCards:Array = CardUtil.getInstane().canChi(this.myUser.handCards, notification.data.card)
						if (canChiCards) {
							thisCanChiCards = canChiCards
							canChiButton.visible = cancelButton.visible = true
						} else {
							trace('不能吃 直接取消')
							const action2:Object = { name: Actions.Cancel, data: '' }
							Api.getInstane().sendAction(action2)
						}
					}
					break
				}
				case Notifications.onEat: {
					trace('有人吃')
					Audio.getInstane().playHandle('chi')
					initRoomInfo(notification.data)
					updateMyHandCardUIs()
					updateMyGroupCardUIs()
					updateMyPassCardUIs()
					break
				}
				default:
				{
					break;
				}
			}
		}
		
		protected function canPengButton_clickHandler(event:MouseEvent):void
		{
			canPengButton.visible = canChiButton.visible = cancelButton.visible = false
			const action:Object = { name: Actions.Peng, data: thisCanPengCards }
			Api.getInstane().sendAction(action)
		}
		
		protected function canChiButton_clickHandler(event:MouseEvent):void
		{
			canPengButton.visible = canChiButton.visible = cancelButton.visible = false
			const action:Object = { name: Actions.Chi, data: thisCanChiCards }
			Api.getInstane().sendAction(action)
		}
		
		protected function cancelButton_clickHandler(event:MouseEvent):void
		{
			canPengButton.visible = canChiButton.visible = cancelButton.visible = false
			const action:Object = { name: Actions.Cancel, data: '' }
			Api.getInstane().sendAction(action)
		}
		
	}
}