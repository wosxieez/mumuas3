package com.xiaomu.view.room
{
	import com.xiaomu.component.CardUI;
	import com.xiaomu.event.ApiEvent;
	import com.xiaomu.event.SelectEvent;
	import com.xiaomu.util.Actions;
	import com.xiaomu.util.Api;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.Assets;
	import com.xiaomu.util.Audio;
	import com.xiaomu.util.CardUtil;
	import com.xiaomu.util.Notifications;
	import com.xiaomu.view.MainView;
	import com.xiaomu.view.group.GroupView;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import coco.component.Button;
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
		
		private var bgLayer: UIComponent
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
		private var cardsCarrUI:Image
		private var cardsLabel:Label
		private var dealCardUI: CardUI
		private var dealCardUI2: CardUI
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
		private var roominfo:Object = {}
		private var oldPoint:Point
		private var thisCanPengCards:Array
		private var thisCanChiCards:Array
		private var thisCanHuDatas:Array
		
		private var zhunbeiButton:Button
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
				
			bgLayer = new UIComponent()
			addChild(bgLayer)
			
			cardsCarrUI = new Image()
			cardsCarrUI.width = 30
			cardsCarrUI.height = 80
			cardsCarrUI.rotation = 90
			cardsCarrUI.source = Assets.getInstane().getAssets('fight_full_card.png')
			cardsCarrUI.visible = false
			bgLayer.addChild(cardsCarrUI)
			
			cardsLabel = new Label()
			cardsLabel.width = 80
			cardsLabel.height = 30
			cardsLabel.color = 0xFFFFFF
			cardsLabel.visible = false
			bgLayer.addChild(cardsLabel)
				
				
			// 增加三个图像
			preUserLine = new Image()
			preUserLine.width = 80
			preUserLine.height = 30
			preUserLine.source = Assets.getInstane().getAssets('fight_userinfo_bg2.png')
			bgLayer.addChild(preUserLine)
			preUserBG = new Image()
			preUserBG.width = preUserBG.height = 30
			preUserBG.source = Assets.getInstane().getAssets('fight_userinfo_circle_bg.png')
			bgLayer.addChild(preUserBG)
			preUserIcon = new Image()
			preUserIcon.width = preUserIcon.height = 20
			preUserIcon.source = Assets.getInstane().getAssets('avatar1.png')
			bgLayer.addChild(preUserIcon)
			preUserNameLabel = new Label()
			preUserNameLabel.color = 0xFFFFFF
			preUserNameLabel.height = 30
			preUserNameLabel.height = 30
			bgLayer.addChild(preUserNameLabel)
			
			myUserLine = new Image()
			myUserLine.width = 80
			myUserLine.height = 30
			myUserLine.source = Assets.getInstane().getAssets('fight_userinfo_bg2.png')
			bgLayer.addChild(myUserLine)
			myUserBG = new Image()
			myUserBG.width = myUserBG.height = 30
			myUserBG.source = Assets.getInstane().getAssets('fight_userinfo_circle_bg.png')
			bgLayer.addChild(myUserBG)
			myUserIcon = new Image()
			myUserIcon.width = myUserIcon.height = 20
			myUserIcon.source = Assets.getInstane().getAssets('avatar2.png')
			bgLayer.addChild(myUserIcon)
			myUserNameLabel = new Label()
			myUserNameLabel.color = 0xFFFFFF
			myUserNameLabel.height = 30
			myUserNameLabel.height = 30
			bgLayer.addChild(myUserNameLabel)
			
			nextUserLine = new Image()
			nextUserLine.width = 80
			nextUserLine.height = 30
			nextUserLine.source = Assets.getInstane().getAssets('fight_userinfo_bg2.png')
			bgLayer.addChild(nextUserLine)
			nextUserBG = new Image()
			nextUserBG.width = nextUserBG.height = 30
			nextUserBG.source = Assets.getInstane().getAssets('fight_userinfo_circle_bg.png')
			bgLayer.addChild(nextUserBG)
			nextUserIcon = new Image()
			nextUserIcon.width = nextUserIcon.height = 20
			nextUserIcon.source = Assets.getInstane().getAssets('avatar3.png')
			bgLayer.addChild(nextUserIcon)
			nextUserNameLabel = new Label()
			nextUserNameLabel.color = 0xFFFFFF
			nextUserNameLabel.height = 30
			nextUserNameLabel.height = 30
			nextUserNameLabel.height = 30
			bgLayer.addChild(nextUserNameLabel)
				
			checkWaitTip = new Image()
			checkWaitTip.width = 16
			checkWaitTip.height = 16
			checkWaitTip.visible = false
			checkWaitTip.source = Assets.getInstane().getAssets('wait.png')
			bgLayer.addChild(checkWaitTip)
				
			newCardTip = new Image()
			newCardTip.width = 100
			newCardTip.height = 16
			newCardTip.visible = false
			newCardTip.source = Assets.getInstane().getAssets('fight_txt_finger_tips.png')
			bgLayer.addChild(newCardTip)
			
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
			
			dealCardUI2 = new CardUI()
			dealCardUI2.border = 2
			dealCardUI2.visible = false
			dealCardUI2.width = 30
			dealCardUI2.height = 70
			dealCardUI2.card = 10
			cardLayer.addChild(dealCardUI2)
			
			// 图标层
			iconLayer = new UIComponent()
			addChild(iconLayer)
			
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
			
			zhunbeiButton = new Button()
			zhunbeiButton.label = '准备'
			zhunbeiButton.width = 50
			zhunbeiButton.height = 20
			zhunbeiButton.addEventListener(MouseEvent.CLICK, zhunbeiButton_clickHandler)
			iconLayer.addChild(zhunbeiButton)
			
			backBtn = new Image()
			backBtn.source = 'assets/club_btn_back.png';
			backBtn.width = 71*0.35;
			backBtn.height = 86*0.35;
			backBtn.addEventListener(MouseEvent.CLICK, back_clickHandler)
			addChild(backBtn)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			//			this.preUser = {username: 'wosxieez0', 
			//				handCards: [1, 3, 5, 4, 4, 3, 11, 15, 18, 19, 11, 10, 9, 9, 8, 16, 17, 18, 9, 10, 8],
			//				groupCards: [{name: 'ti', cards: [1, 1, 1, 1]}],
			//				passCards:[2, 4, 9]}
			//			this.nextUser = {username: 'wosxieez2', 
			//				handCards: [1, 3, 5, 4, 4, 3, 11, 15, 18, 19, 11, 10, 9, 9, 8, 16, 17, 18, 9, 10, 8],
			//				groupCards: [{name: 'ti', cards: [1, 1, 1, 1]}],
			//				passCards:[2, 4, 9]}
			//			this.myUser = {username: 'wosxieez1', 
			//				handCards: [1, 3, 5, 4, 4, 4, 4, 3, 11, 15, 18, 19, 11, 10, 9, 9, 8, 16, 17, 18, 9, 10, 8],
			//				groupCards: [{name: 'ti', cards: [1, 1, 1, 1]}],
			//				passCards:[2, 4, 9]}
			
			if (preUser) {
				preUserNameLabel.text = preUser.username
				updatePreGroupCardUIs()
				updatePrePassCardUIs()
			}
			
			if (myUser) {
				myUserNameLabel.text = myUser.username
				updateMyHandCardUIs()
				updateMyGroupCardUIs()
				updateMyPassCardUIs()
			}
			
			if (nextUser) {
				nextUserNameLabel.text = nextUser.username
				updateNextGroupCardUIs()
				updateNextPassCardUIs()
			}
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
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
			
			cardsCarrUI.x = (width + cardsCarrUI.height)  / 2
			cardsCarrUI.y = 20
			cardsLabel.x = (width - cardsLabel.width)  / 2
			cardsLabel.y = 20
			
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
			
			backBtn.x = width - backBtn.width - 5
			backBtn.y = height - backBtn.height - 5
			
			zhunbeiButton.x = (width - zhunbeiButton.width) / 2
			zhunbeiButton.y = (height - zhunbeiButton.height) / 2
		}
		
		override protected function drawSkin():void {
			super.drawSkin()
		}
		
		private function updateRoomInfo(room:Object):void {
			if (room) {
				this.roominfo.users = room.users
				this.roominfo.zc = room.zc ? room.zc : 0
				this.roominfo.zn = room.zn ? room.zn : ''
				this.roominfo.pc = room.pc ? room.pc : 0
				this.roominfo.pn = room.pn ? room.pn : ''
				this.roominfo.cc = room.cc ? room.cc : 0
				
				this.myUser = this.preUser = this.nextUser = null
				for (var i:int = 0; i < roominfo.users.length; i++) {
					if (roominfo.users[i].username == AppData.getInstane().user.username) {
						var endUsers:Array = roominfo.users.slice(i)
						var startUsers:Array = roominfo.users.slice(0, i)
						var orderUsers:Array = endUsers.concat(startUsers)
						this.myUser = orderUsers.shift()
						if (orderUsers.length > 0) {
							this.nextUser = orderUsers.shift()
						}
						if (orderUsers.length > 0) {
							this.preUser = orderUsers.pop()
						}
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
				
				if (roominfo.cc)
					cardsLabel.text = '剩余' + roominfo.cc + '张牌'
				
				for each(var user:Object in roominfo.users) {
					if (user.username == AppData.getInstane().user.username) {
						zhunbeiButton.label = user.isReady ? '取消准备' : '准备'
					}
				}
			}
		}
		
		private function updateZhuangCard():void {
			if (roominfo) {
				dealCardUI2.visible = true
				dealCardUI2.card = roominfo.zc
				dealCardUI2.x = (width - dealCardUI2.width) / 2
				dealCardUI2.y = (height - dealCardUI2.height) / 2 - 50
			} else {
				dealCardUI2.visible = false
			}
		}
		private function updateNewCard():void {
			if (roominfo) {
				dealCardUI.visible = true
				dealCardUI.card = roominfo.pc
				if (this.preUser && roominfo.pn == this.preUser.username) {
					dealCardUI.y = 50
					dealCardUI.x = 120
				} else if (this.nextUser && roominfo.pn == this.nextUser.username) {
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
			if (preUser && checkUsername == preUser.username) {
				checkWaitTip.visible = true
				checkWaitTip.x = preUserIcon.x + 15
				checkWaitTip.y = preUserIcon.y - 15
			} else if (nextUser && checkUsername == nextUser.username) {
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
				const cardHeight:Number = 34
				const horizontalGap:Number = 0
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
							cardLayer.addChild(newCardUI)
						}
						newCardUI.visible = true
						newCardUI.canDeal = canDeal
						newCardUI.width = cardWidth
						newCardUI.height = cardHeight
						newCardUI.x = startX + i * (newCardUI.width + horizontalGap)
						newCardUI.y = height - newCardUI.height - j * verticalGap - 5
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
				var startX:Number = 5
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
						newCardUI.y = height - newCardUI.height - j * verticalGap - 30
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
				var startX:Number = 5
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
					newCardUI.y = height - newCardUI.height - 5
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
		
		private var draggingCardUI:CardUI
		
		protected function cardUI_mouseDownHandler(event:MouseEvent):void
		{
			trace('cards mouse down')
			const cardUI:CardUI = event.currentTarget as CardUI
			if (cardUI && cardUI.canDeal && this.isCheckNewCard) {
				draggingCardUI = cardUI
				oldPoint = cardLayer.localToGlobal(new Point(draggingCardUI.x, draggingCardUI.y))
				draggingCardUI.startDrag()
				
				this.addEventListener(MouseEvent.MOUSE_UP, this_mouseUpHandler)
			}
		}
		
		protected function this_mouseUpHandler(event:MouseEvent):void {
			this.removeEventListener(MouseEvent.MOUSE_UP, this_mouseUpHandler)
			
			trace('cards mouse up')
			if (draggingCardUI) {
				draggingCardUI.stopDrag()
				if (mouseY <= height / 2) {
					if (isCheckNewCard) {
						const action:Object = { name: Actions.NewCard, data: draggingCardUI.card }
						Api.getInstane().sendAction(action)
						newCardTip.visible = false
						isCheckNewCard = false
					}
				}	
				
				// 恢复开始点
				const thisPoint:Point = cardLayer.globalToLocal(oldPoint)
				draggingCardUI.x = thisPoint.x
				draggingCardUI.y = thisPoint.y
				draggingCardUI = null
			}
		}
		
		protected function onNotificationHandler(event:ApiEvent):void
		{
			isCheckNewCard = isHu = false
			newCardTip.visible = cancelButton.visible = canChiButton.visible = canPengButton.visible = canHuButton.visible = false
			thisCanChiCards = thisCanHuDatas = thisCanPengCards = null
			
			if (ChiSelectView.getInstane().isPopUp) {
				PopUpManager.removePopUp(ChiSelectView.getInstane())
			}
			
			const notification: Object = event.data
			switch(notification.name)
			{
				case Notifications.onReady:
				{
					updateRoomInfo(notification.data)
					break
				}
				case Notifications.onNewRound:
				{
					zhunbeiButton.visible = false
					cardsCarrUI.visible = cardsLabel.visible = true
					
					updateRoomInfo(notification.data)
					updateZhuangCard()
					updateMyHandCardUIs()
					updateMyGroupCardUIs()
					updateMyPassCardUIs()
					updatePreGroupCardUIs()
					updatePrePassCardUIs()
					updateNextGroupCardUIs()
					updateNextPassCardUIs()
					break;
				}
				case Notifications.onGameStart:
				{
					dealCardUI2.visible = false
					updateRoomInfo(notification.data)
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
					trace('检查吃', JSON.stringify(notification.data))
					checkUsername = notification.data.username
					updateWaitTip()
					if (checkUsername == AppData.getInstane().user.username) {
						thisCanPengCards = notification.data.group
						canPengButton.visible = cancelButton.visible = true
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
					trace('检查吃', JSON.stringify(notification.data))
					newCardTip.visible = cancelButton.visible = canChiButton.visible = canPengButton.visible = false
					checkUsername = notification.data.username
					updateWaitTip()
					if (notification.data.username == AppData.getInstane().user.username) {
						thisCanChiCards = notification.data.data
						canChiButton.visible = cancelButton.visible = true
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
					Audio.getInstane().playHandle('hu')
					cardsCarrUI.visible = cardsLabel.visible = false
					RoomResultView.getInstane().data = notification.data
					PopUpManager.centerPopUp(PopUpManager.addPopUp(RoomResultView.getInstane(), null, false, true))
					zhunbeiButton.visible = true
					zhunbeiButton.label = '准备'
					break
				}
				case Notifications.onRoundEnd: {
					cardsCarrUI.visible = cardsLabel.visible = false
					RoomResultView.getInstane().data = notification.data
					PopUpManager.centerPopUp(PopUpManager.addPopUp(RoomResultView.getInstane(), null, false, true))
					zhunbeiButton.visible = true
					zhunbeiButton.label = '准备'
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
			ChiSelectView.getInstane().addEventListener(SelectEvent.SELECTED, chi_selectHandler)
			ChiSelectView.getInstane().open(thisCanChiCards)
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
			zhunbeiButton.label = '准备'
			zhunbeiButton.visible = true
		}
		
		protected function back_clickHandler(event:MouseEvent):void
		{
			Api.getInstane().leaveRoom()
			MainView.getInstane().popView(GroupView)
		}
		
		protected function zhunbeiButton_clickHandler(event:MouseEvent):void
		{
			const action:Object = { name: Actions.Ready, data: zhunbeiButton.label == '准备' ? true : false }
			Api.getInstane().sendAction(action)
		}
		
		protected function chi_selectHandler(event:SelectEvent):void
		{
			trace(JSON.stringify(event.data))
			ChiSelectView.getInstane().close()
			isHu = canHuButton.visible = canPengButton.visible = canChiButton.visible = cancelButton.visible = false
			const action:Object = { name: Actions.Chi, data:  event.data}
			Api.getInstane().sendAction(action)
			
		}
		
	}
}