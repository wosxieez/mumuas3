package com.xiaomu.view
{
	import com.xiaomu.component.CardUI;
	import com.xiaomu.event.ApiEvent;
	import com.xiaomu.util.Actions;
	import com.xiaomu.util.Api;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.Assets;
	import com.xiaomu.util.Audio;
	import com.xiaomu.util.CardUtil;
	import com.xiaomu.util.Notifications;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import coco.component.Image;
	import coco.component.Label;
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	
	public class RoomView extends UIComponent
	{
		public function RoomView()
		{
			super();
			
			Api.getInstane().addEventListener(ApiEvent.Notification, onNotificationHandler)
		}
		
		private var bg:Image
		private var bgline:Image
		
		private var preUserLine:Image
		private var preUserBG:Image
		private var preUserIcon:Image
		private var preUserNameLabel:Label
		
		private var myUserLine:Image
		private var myUserBG:Image
		private var myUserIcon:Image
		private var myUserNameLabel:Label
		
		private var nextUserLine:Image
		private var nextUserBG:Image
		private var nextUserIcon:Image
		private var nextUserNameLabel:Label
		
		private var cardLayer: UIComponent
		private var dealCardUI: CardUI
		private var iconLayer:UIComponent
		private var myUser:Object
		private var preUser:Object
		private var nextUser:Object
		private var myHandCardUIs:Array = []
		private var myGroupCardUIs:Array = []
		private var myPassCardUIs:Array = []
		private var preGroupCardUIs:Array = []
		private var prePassCardUIs:Array = []
		private var nextGroupCardUIs:Array = []
		private var nextPassCardUIs:Array = []
		private var roominfo:Object
		private var oldPoint:Point
		private var isDrag:Boolean = false
		private var thisCanPengCards:Array
		private var thisCanChiCards:Array
		private var thisCanHuDatas:Array
		
		private var canHuButton:Image
		private var canPengButton:Image
		private var canChiButton:Image
		private var cancelButton:Image
		private var newCardTip:Image
		private var checkWaitTip:Image
		private var checkUsername: String
		private var isCheckNewCard:Boolean = false // 是否在等待出牌
		private var isHu:Boolean = false
			
		private var backBtn:Image
		
		override protected function createChildren():void {
			super.createChildren()
			
			// 背景层
			bg = new Image()
			bg.source = 'assets/room_bg.png'
			addChild(bg)
			
			bgline = new Image()
			bgline.height = 60
			bgline.source = Assets.getInstane().getAssets('fight_down_bg.png')
			addChild(bgline)
			// 卡牌层
			cardLayer = new UIComponent()
			addChild(cardLayer)
			
			dealCardUI = new CardUI()
			dealCardUI.border = 2
			dealCardUI.visible = false
			dealCardUI.width = 30
			dealCardUI.height = 70
			dealCardUI.card = 10
			cardLayer.addChild(dealCardUI)
			
			// 图标层
			iconLayer = new UIComponent()
			addChild(iconLayer)
			
			// 增加三个图像
			preUserLine = new Image()
			preUserLine.width = 80
			preUserLine.height = 30
			preUserLine.source = Assets.getInstane().getAssets('fight_userinfo_bg2.png')
			iconLayer.addChild(preUserLine)
			preUserBG = new Image()
			preUserBG.width = preUserBG.height = 30
			preUserBG.source = Assets.getInstane().getAssets('fight_userinfo_circle_bg.png')
			iconLayer.addChild(preUserBG)
			preUserIcon = new Image()
			preUserIcon.width = preUserIcon.height = 20
			preUserIcon.source = Assets.getInstane().getAssets('avatar1.png')
			iconLayer.addChild(preUserIcon)
			preUserNameLabel = new Label()
			preUserNameLabel.color = 0xFFFFFF
			preUserNameLabel.height = 30
			preUserNameLabel.height = 30
			iconLayer.addChild(preUserNameLabel)
			
			myUserLine = new Image()
			myUserLine.width = 80
			myUserLine.height = 30
			myUserLine.source = Assets.getInstane().getAssets('fight_userinfo_bg2.png')
			iconLayer.addChild(myUserLine)
			myUserBG = new Image()
			myUserBG.width = myUserBG.height = 30
			myUserBG.source = Assets.getInstane().getAssets('fight_userinfo_circle_bg.png')
			iconLayer.addChild(myUserBG)
			myUserIcon = new Image()
			myUserIcon.width = myUserIcon.height = 20
			myUserIcon.source = Assets.getInstane().getAssets('avatar2.png')
			iconLayer.addChild(myUserIcon)
			myUserNameLabel = new Label()
			myUserNameLabel.color = 0xFFFFFF
			myUserNameLabel.height = 30
			myUserNameLabel.height = 30
			iconLayer.addChild(myUserNameLabel)
			
			nextUserLine = new Image()
			nextUserLine.width = 80
			nextUserLine.height = 30
			nextUserLine.source = Assets.getInstane().getAssets('fight_userinfo_bg2.png')
			iconLayer.addChild(nextUserLine)
			nextUserBG = new Image()
			nextUserBG.width = nextUserBG.height = 30
			nextUserBG.source = Assets.getInstane().getAssets('fight_userinfo_circle_bg.png')
			iconLayer.addChild(nextUserBG)
			nextUserIcon = new Image()
			nextUserIcon.width = nextUserIcon.height = 20
			nextUserIcon.source = Assets.getInstane().getAssets('avatar3.png')
			iconLayer.addChild(nextUserIcon)
			nextUserNameLabel = new Label()
			nextUserNameLabel.color = 0xFFFFFF
			nextUserNameLabel.height = 30
			nextUserNameLabel.height = 30
			nextUserNameLabel.height = 30
			addChild(nextUserNameLabel)
			
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
			
			canHuButton = new Image()
			canHuButton.source = Assets.getInstane().getAssets('oprate_hu0.png')
			canHuButton.width = canHuButton.height = 30
			canHuButton.visible = false
			canHuButton.addEventListener(MouseEvent.CLICK,canHuButton_clickHandler)
			iconLayer.addChild(canHuButton)
			
			newCardTip = new Image()
			newCardTip.width = 100
			newCardTip.height = 16
			newCardTip.visible = false
			newCardTip.source = Assets.getInstane().getAssets('fight_txt_finger_tips.png')
			iconLayer.addChild(newCardTip)
			
			checkWaitTip = new Image()
			checkWaitTip.width = 16
			checkWaitTip.height = 16
			checkWaitTip.visible = false
			checkWaitTip.source = Assets.getInstane().getAssets('wait.png')
			iconLayer.addChild(checkWaitTip)
				
			backBtn = new Image()
			backBtn.source = 'assets/backbtn.png'
			backBtn.addEventListener(MouseEvent.CLICK, back_clickHandler)
			backBtn.width = backBtn.height = 20
			addChild(backBtn)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			this.preUser = {username: 'wosxieez0', 
				handCards: [1, 3, 5, 4, 4, 3, 11, 15, 18, 19, 11, 10, 9, 9, 8, 16, 17, 18, 9, 10, 8],
				groupCards: [{name: 'ti', cards: [1, 1, 1, 1]}],
				passCards:[2, 4, 9]}
			this.nextUser = {username: 'wosxieez2', 
				handCards: [1, 3, 5, 4, 4, 3, 11, 15, 18, 19, 11, 10, 9, 9, 8, 16, 17, 18, 9, 10, 8],
				groupCards: [{name: 'ti', cards: [1, 1, 1, 1]}],
				passCards:[2, 4, 9]}
			this.myUser = {username: 'wosxieez1', 
				handCards: [1, 3, 5, 4, 4, 4, 4, 3, 11, 15, 18, 19, 11, 10, 9, 9, 8, 16, 17, 18, 9, 10, 8],
				groupCards: [{name: 'ti', cards: [1, 1, 1, 1]}],
				passCards:[2, 4, 9]}
			
			preUserNameLabel.text = preUser.username
			myUserNameLabel.text = myUser.username
			nextUserNameLabel.text = nextUser.username
			
			updateMyHandCardUIs()
			updateMyGroupCardUIs()
			updateMyPassCardUIs()
			
			updatePreGroupCardUIs()
			updatePrePassCardUIs()
			
			updateNextGroupCardUIs()
			updateNextPassCardUIs()
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			bg.width = width
			bg.height = height
			
			bgline.width = width
			bgline.y = height - 60
			
			preUserLine.x = 20
			preUserLine.y = 10
			preUserBG.x = preUserLine.x - 15
			preUserBG.y = preUserLine.y
			preUserIcon.x = preUserBG.x + 5
			preUserIcon.y = preUserBG.y + 5
			preUserNameLabel.y = preUserLine.y
			preUserNameLabel.x = preUserBG.x + 30
			
			myUserLine.x = width / 2 - 40
			myUserLine.y = height - 35
			myUserBG.x = myUserLine.x - 5
			myUserBG.y = myUserLine.y
			myUserIcon.x = myUserBG.x + 5
			myUserIcon.y = myUserBG.y + 5
			myUserNameLabel.y = myUserLine.y
			myUserNameLabel.x = myUserBG.x + 30
			
			nextUserLine.x = width - 80
			nextUserLine.y = 10
			nextUserBG.x = nextUserLine.x - 15
			nextUserBG.y = nextUserLine.y
			nextUserIcon.x = nextUserBG.x + 5
			nextUserIcon.y = nextUserBG.y + 5
			nextUserNameLabel.y = nextUserLine.y 
			nextUserNameLabel.x = nextUserBG.x + 30
			
			canPengButton.x = width - canPengButton.width - 20
			canPengButton.y = (height - canChiButton.height) / 2 - 10
			
			canHuButton.x = canPengButton.x
			canHuButton.y = canPengButton.y
			
			canChiButton.x = width - canChiButton.width - 20
			canChiButton.y = (height - canChiButton.height) / 2 - 10
			
			cancelButton.x = width - cancelButton.width - 20
			cancelButton.y = (height - cancelButton.height) / 2 + 30
			
			newCardTip.x = (width - newCardTip.width) / 2
			newCardTip.y = (height - newCardTip.height) / 2
				
			backBtn.x = width - backBtn.width - 2
			backBtn.y = height - backBtn.height - 20
		}
		
		override protected function drawSkin():void {
			super.drawSkin()
		}
		
		private function updateRoomInfo(room:Object):void {
			if (room) {
				this.roominfo = room
				for (var i:int = 0; i < roominfo.users.length; i++) {
					if (roominfo.users[i].username == AppData.getInstane().user.username) {
						var endUsers:Array = roominfo.users.slice(i)
						var startUsers:Array = roominfo.users.slice(0, i)
						var orderUsers:Array = endUsers.concat(startUsers)
						this.myUser = orderUsers[0]
						this.nextUser = orderUsers[1]
						this.preUser = orderUsers.pop()
						break
					}
				}
				
				if (preUser) {
					preUserNameLabel.text = preUser.username
				} 
				
				if (myUser) {
					myUserNameLabel.text = myUser.username
				} 
				
				if (nextUser) {
					nextUserNameLabel.text = nextUser.username
				} 
			}
		}
		private function updateNewCard():void {
			if (roominfo) {
				dealCardUI.visible = true
				dealCardUI.card = roominfo.deal_card
				if (roominfo.deal_username == this.preUser.username) {
					dealCardUI.y = 50
					dealCardUI.x = 120
				} else if (roominfo.deal_username == this.nextUser.username) {
					dealCardUI.y = 50
					dealCardUI.x = width - 150
				} else {
					dealCardUI.x = (width - dealCardUI.width) / 2
					dealCardUI.y = (height - dealCardUI.height) / 2 - 20
				}
				Audio.getInstane().playCard(dealCardUI.card)
			} else {
				dealCardUI.visible = false
			}
		}
		private function updateWaitTip():void {
			if (checkUsername == preUser.username) {
				checkWaitTip.visible = true
				checkWaitTip.x = preUserIcon.x + 15
				checkWaitTip.y = preUserIcon.y - 15
			} else if (checkUsername == nextUser.username) {
				checkWaitTip.visible = true
				checkWaitTip.x = nextUserIcon.x + 15
				checkWaitTip.y = nextUserIcon.y - 15
			} else {
				checkWaitTip.visible = false
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
				const cardWidth:Number = 30
				const cardHeight:Number = 45
				const horizontalGap:Number = 2
				const verticalGap:Number = 30
				var newCardUI:CardUI
				var startX:Number = (width - riffleCards.length * (cardWidth + horizontalGap)) / 2
				for (var i:int = 0; i < riffleCards.length; i++) {
					var groupCards:Array = riffleCards[i]
					var canDeal:Boolean = true
					if (groupCards && groupCards.length >= 3) {
						canDeal = false
						var compareCard:int = 0
						for each(var item:int in groupCards) {
							if (compareCard > 0) {
								if (compareCard != item) {
									canDeal = true
									break
								}
							} else {
								compareCard = item
							}
						}
					}
					for (var j:int = 0; j < groupCards.length; j++) {
						newCardUI = oldMyHandCardUIs.pop()
						if (!newCardUI) {
							newCardUI = new CardUI()
							newCardUI.addEventListener(MouseEvent.MOUSE_DOWN, cardUI_mouseDownHandler)
							newCardUI.addEventListener(MouseEvent.MOUSE_UP, cardUI_mouseUpHandler)
							cardLayer.addChild(newCardUI)
						}
						newCardUI.visible = true
						newCardUI.canDeal = canDeal
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
				const cardWidth:Number = 16
				const cardHeight:Number = 20
				const horizontalGap:Number = 1
				const verticalGap:Number = 14
				var newCardUI:CardUI
				var startX:Number = 10
				for (var i:int = 0; i < riffleCards.length; i++) {
					var group:Object = riffleCards[i]
					var groupCards:Array = group.cards
					var cardsLength:int = groupCards.length
					for (var j:int = 0; j < cardsLength; j++) {
						newCardUI = oldMyGroupCardUIs.pop()
						if (!newCardUI) {
							newCardUI = new CardUI()
							cardLayer.addChild(newCardUI)
						}
						newCardUI.isReverse = false
						if (group.name == 'ti' || group.name == 'wei') newCardUI.isReverse = true
						if (j == (cardsLength - 1)) newCardUI.isReverse = false
						newCardUI.visible = true
						newCardUI.width = cardWidth
						newCardUI.height = cardHeight
						newCardUI.x = startX + i * (newCardUI.width + horizontalGap)
						newCardUI.y = height - newCardUI.height - j * verticalGap - 45
						newCardUI.card = groupCards[j]
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
				const cardWidth:Number = 16
				const cardHeight:Number = 20
				const horizontalGap:Number = 1
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
		
		
		/**
		 *  更新上家的组合牌视图
		 */		
		private function updatePreGroupCardUIs():void {
			if (preUser) {
				const riffleCards:Array = this.preUser.groupCards
				var oldPreGroupCardUIs:Array = []
				for each(var cardUI: CardUI in preGroupCardUIs) {
					cardUI.visible = false
					oldPreGroupCardUIs.push(cardUI)
				}
				preGroupCardUIs = []
				const cardWidth:Number = 16
				const cardHeight:Number = 20
				const horizontalGap:Number = 1
				const verticalGap:Number = 14
				var newCardUI:CardUI
				var startX:Number = 10
				for (var i:int = 0; i < riffleCards.length; i++) {
					var group:Object = riffleCards[i]
					var groupCards:Array = group.cards
					var cardsLength:int = groupCards.length
					for (var j:int = 0; j < cardsLength; j++) {
						newCardUI = oldPreGroupCardUIs.pop()
						if (!newCardUI) {
							newCardUI = new CardUI()
							cardLayer.addChild(newCardUI)
						}
						newCardUI.isReverse = false
						if (group.name == 'ti' || group.name == 'wei') newCardUI.isReverse = true
						if (j == (cardsLength - 1)) newCardUI.isReverse = false
						newCardUI.visible = true
						newCardUI.width = cardWidth
						newCardUI.height = cardHeight
						newCardUI.x = startX + i * (newCardUI.width + horizontalGap)
						newCardUI.y = newCardUI.height - j * verticalGap + 60
						newCardUI.card = groupCards[j]
						newCardUI.type = CardUI.TYPE_SMALL_CARD
						cardLayer.setChildIndex(newCardUI, 0)
						preGroupCardUIs.push(newCardUI)
					}
				}
				
			}
		}
		
		/**
		 *  更新上家的弃牌视图
		 */		
		private function updatePrePassCardUIs():void {
			if (preUser) {
				const riffleCards:Array = this.preUser.passCards
				var oldPrePassCardUIs:Array = []
				for each(var cardUI: CardUI in prePassCardUIs) {
					cardUI.visible = false
					oldPrePassCardUIs.push(cardUI)
				}
				prePassCardUIs = []
				const cardWidth:Number = 16
				const cardHeight:Number = 20
				const horizontalGap:Number = 1
				var newCardUI:CardUI
				var startX:Number = 10
				for (var i:int = 0; i < riffleCards.length; i++) {
					newCardUI = oldPrePassCardUIs.pop()
					if (!newCardUI) {
						newCardUI = new CardUI()
						cardLayer.addChild(newCardUI)
					}
					newCardUI.visible = true
					newCardUI.width = cardWidth
					newCardUI.height = cardHeight
					newCardUI.x = startX + i * (newCardUI.width + horizontalGap)
					newCardUI.y = newCardUI.height + 85
					newCardUI.card = riffleCards[i]
					newCardUI.type = CardUI.TYPE_SMALL_CARD
					cardLayer.setChildIndex(newCardUI, 0)
					prePassCardUIs.push(newCardUI)
				}
				
			}
		}
		
		
		/**
		 *  更新上家的组合牌视图
		 */		
		private function updateNextGroupCardUIs():void {
			if (nextUser) {
				const riffleCards:Array = this.nextUser.groupCards
				var oldNextGroupCardUIs:Array = []
				for each(var cardUI: CardUI in nextGroupCardUIs) {
					cardUI.visible = false
					oldNextGroupCardUIs.push(cardUI)
				}
				nextGroupCardUIs = []
				const cardWidth:Number = 16
				const cardHeight:Number = 20
				const horizontalGap:Number = 1
				const verticalGap:Number = 14
				var newCardUI:CardUI
				var startX:Number = width - cardWidth - 10
				for (var i:int = 0; i < riffleCards.length; i++) {
					var group:Object = riffleCards[i]
					var groupCards:Array = group.cards
					var cardsLength:int = groupCards.length
					for (var j:int = 0; j < cardsLength; j++) {
						newCardUI = oldNextGroupCardUIs.pop()
						if (!newCardUI) {
							newCardUI = new CardUI()
							cardLayer.addChild(newCardUI)
						}
						newCardUI.isReverse = false
						if (group.name == 'ti' || group.name == 'wei') newCardUI.isReverse = true
						if (j == (cardsLength - 1)) newCardUI.isReverse = false
						newCardUI.visible = true
						newCardUI.width = cardWidth
						newCardUI.height = cardHeight
						newCardUI.x = startX - i * (newCardUI.width + horizontalGap)
						newCardUI.y = newCardUI.height - j * verticalGap + 60
						newCardUI.card = groupCards[j]
						newCardUI.type = CardUI.TYPE_SMALL_CARD
						cardLayer.setChildIndex(newCardUI, 0)
						nextGroupCardUIs.push(newCardUI)
					}
				}
				
			}
		}
		
		/**
		 *  更新上家的弃牌视图
		 */		
		private function updateNextPassCardUIs():void {
			if (nextUser) {
				const riffleCards:Array = this.nextUser.passCards
				var oldNextPassCardUIs:Array = []
				for each(var cardUI: CardUI in nextPassCardUIs) {
					cardUI.visible = false
					oldNextPassCardUIs.push(cardUI)
				}
				nextPassCardUIs = []
				const cardWidth:Number = 16
				const cardHeight:Number = 20
				const horizontalGap:Number = 1
				var newCardUI:CardUI
				var startX:Number = width - cardWidth - 10
				for (var i:int = 0; i < riffleCards.length; i++) {
					newCardUI = oldNextPassCardUIs.pop()
					if (!newCardUI) {
						newCardUI = new CardUI()
						cardLayer.addChild(newCardUI)
					}
					newCardUI.visible = true
					newCardUI.width = cardWidth
					newCardUI.height = cardHeight
					newCardUI.x = startX - i * (newCardUI.width + horizontalGap)
					newCardUI.y = newCardUI.height + 85
					newCardUI.card = riffleCards[i]
					newCardUI.type = CardUI.TYPE_SMALL_CARD
					cardLayer.setChildIndex(newCardUI, 0)
					nextPassCardUIs.push(newCardUI)
				}
				
			}
		}
		
		protected function cardUI_mouseDownHandler(event:MouseEvent):void
		{
			const cardUI:CardUI = event.currentTarget as CardUI
			if (cardUI && cardUI.canDeal && this.isCheckNewCard) {
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
			isCheckNewCard = isHu = false
			newCardTip.visible = cancelButton.visible = canChiButton.visible = canPengButton.visible = canHuButton.visible = false
			
			const notification: Object = event.data
			switch(notification.name)
			{
				case Notifications.onNewRound:
				{
					updateRoomInfo(notification.data)
					// 如果自己是庄家不显示翻开的牌
					if (roominfo.banker_username == AppData.getInstane().user.username) {
						dealCardUI.visible = false
					} else {
						updateNewCard()
					}
					updateMyHandCardUIs()
					updateMyGroupCardUIs()
					updateMyPassCardUIs()
					updatePreGroupCardUIs()
					updatePrePassCardUIs()
					updateNextGroupCardUIs()
					updateNextPassCardUIs()
					break;
				}
				case Notifications.onTi : {
					trace('有玩家提牌')
					dealCardUI.visible = false
					Audio.getInstane().playHandle('ti')
					updateRoomInfo(notification.data)
					updateMyHandCardUIs()
					updateMyGroupCardUIs()
					updateMyPassCardUIs()
					updatePreGroupCardUIs()
					updatePrePassCardUIs()
					updateNextGroupCardUIs()
					updateNextPassCardUIs()
					break
				}
				case Notifications.onPao: {
					trace('有玩家跑牌')
					dealCardUI.visible = false
					Audio.getInstane().playHandle('pao')
					updateRoomInfo(notification.data)
					updateMyHandCardUIs()
					updateMyGroupCardUIs()
					updateMyPassCardUIs()
					updatePreGroupCardUIs()
					updatePrePassCardUIs()
					updateNextGroupCardUIs()
					updateNextPassCardUIs()
					break
				}
				case Notifications.onWei: {
					trace('有玩家偎牌')
					dealCardUI.visible = false
					Audio.getInstane().playHandle('wei')
					updateRoomInfo(notification.data)
					updateMyHandCardUIs()
					updateMyGroupCardUIs()
					updateMyPassCardUIs()
					updatePreGroupCardUIs()
					updatePrePassCardUIs()
					updateNextGroupCardUIs()
					updateNextPassCardUIs()
					break
				}	
				case Notifications.checkNewCard: {
					// 请出牌
					checkUsername = notification.data.username
					updateWaitTip()
					if (checkUsername == AppData.getInstane().user.username) {
						trace('请出牌')
						newCardTip.visible = true
						isCheckNewCard = true
					}
					break
				}
				case Notifications.onNewCard: {
					trace('有玩家发新牌')
					checkUsername = null
					updateRoomInfo(notification.data)
					updateNewCard()
					updateWaitTip()
					updateMyHandCardUIs()
					updateMyGroupCardUIs()
					updateMyPassCardUIs()
					updatePreGroupCardUIs()
					updatePrePassCardUIs()
					updateNextGroupCardUIs()
					updateNextPassCardUIs()
					break
				}
				case Notifications.checkPeng: {
					// 检查碰
					trace('检查碰', notification.data)
					checkUsername = notification.data.username
					updateWaitTip()
					if (checkUsername == AppData.getInstane().user.username) {
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
					dealCardUI.visible = false
					Audio.getInstane().playHandle('peng')
					checkUsername = null
					updateWaitTip()
					updateRoomInfo(notification.data)
					updateMyHandCardUIs()
					updateMyGroupCardUIs()
					updateMyPassCardUIs()
					updatePreGroupCardUIs()
					updatePrePassCardUIs()
					updateNextGroupCardUIs()
					updateNextPassCardUIs()
					break
				}
				case Notifications.checkEat: {
					// 检查吃
					trace('检查吃')
					newCardTip.visible = cancelButton.visible = canChiButton.visible = canPengButton.visible = false
					checkUsername = notification.data.username
					updateWaitTip()
					if (notification.data.username == AppData.getInstane().user.username) {
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
					dealCardUI.visible = false
					Audio.getInstane().playHandle('chi')
					checkUsername = null
					updateWaitTip()
					updateRoomInfo(notification.data)
					updateMyHandCardUIs()
					updateMyGroupCardUIs()
					updateMyPassCardUIs()
					updatePreGroupCardUIs()
					updatePrePassCardUIs()
					updateNextGroupCardUIs()
					updateNextPassCardUIs()
					break
				}
				case Notifications.checkHu: {
					trace('检查胡', notification.data)
					if (notification.data.username == AppData.getInstane().user.username) {
						isHu = canHuButton.visible = cancelButton.visible = true
						thisCanHuDatas = notification.data.data
					}
					break
				}
				case Notifications.onWin: {
					trace(notification.data)
					var room:Object = notification.data
					Audio.getInstane().playHandle('hu')
					for each(var user:Object in room.users) {
						if (user.username == room.win_username) {
							WinPanel.getInstane().title = user.username + '胡牌'
							WinPanel.getInstane().winGroupCards = user.groupCards
							PopUpManager.centerPopUp(PopUpManager.addPopUp(WinPanel.getInstane()))
							break
						}
					}
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
			isHu = canHuButton.visible = canPengButton.visible = canChiButton.visible = cancelButton.visible = false
			const action:Object = { name: Actions.Peng, data: thisCanPengCards }
			Api.getInstane().sendAction(action)
		}
		
		protected function canChiButton_clickHandler(event:MouseEvent):void
		{
			isHu = canHuButton.visible = canPengButton.visible = canChiButton.visible = cancelButton.visible = false
			const action:Object = { name: Actions.Chi, data: thisCanChiCards }
			Api.getInstane().sendAction(action)
		}
		
		protected function cancelButton_clickHandler(event:MouseEvent):void
		{
			isHu = canHuButton.visible = canPengButton.visible = canChiButton.visible = cancelButton.visible = false
			const action:Object = { name: Actions.Cancel, data: '' }
			Api.getInstane().sendAction(action)
		}
		
		protected function canHuButton_clickHandler(event:MouseEvent):void
		{
			isHu = canHuButton.visible = canPengButton.visible = canChiButton.visible = cancelButton.visible = false
			const action:Object = { name: Actions.Hu, data: thisCanHuDatas }
			Api.getInstane().sendAction(action)
		}
		
		public function init(roominfo:Object): void {
			Api.getInstane().joinRoom(roominfo)
		}
		
		protected function back_clickHandler(event:MouseEvent):void
		{
			Api.getInstane().leaveRoom()
			MainView.getInstane().popView()
		}
		
	}
}