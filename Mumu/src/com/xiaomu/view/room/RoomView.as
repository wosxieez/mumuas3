package com.xiaomu.view.room
{
	import com.xiaomu.component.BigCardUI;
	import com.xiaomu.component.CardUI;
	import com.xiaomu.component.ImageBtnWithUpAndDown;
	import com.xiaomu.event.ApiEvent;
	import com.xiaomu.event.SelectEvent;
	import com.xiaomu.util.Actions;
	import com.xiaomu.util.Api;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.Assets;
	import com.xiaomu.util.Audio;
	import com.xiaomu.util.CardUtil;
	import com.xiaomu.util.Notifications;
	import com.xiaomu.util.Size;
	import com.xiaomu.view.MainView;
	import com.xiaomu.view.group.GroupView;
	
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
		
		private var huxi:int = 0
		
		private var isGaming:Boolean = false
		private var bgLayer: UIComponent
		private var g1Image:Image
		private var g2Image:Image
		private var preUserHead:RoomUserHead
		private var myUserHead:RoomUserHead
		private var nextUserHead:RoomUserHead
		
		private var cardLayer: UIComponent
		private var cardsCarrUI:Image
		private var cardsLabel:Label
		/**
		 * 当前的桌牌 
		 */		
		private var dealCardUI: BigCardUI
		/**
		 * 庄家牌显示 
		 */		
		private var dealCardUI2: BigCardUI
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
		
		private var zhunbeiButton:ImageBtnWithUpAndDown
		private var zhunbeiButton2:ImageBtnWithUpAndDown
		private var canHuButton:Image
		private var canPengButton:Image
		private var canChiButton:Image
		private var cancelButton:Image
		private var newCardTip:Image
		private var checkWaitTip:Image
		private var checkUsername: String
		private var isCheckNewCard:Boolean = false // 是否在等待出牌
		private var isHu:Boolean = false
		private var chatButton:Image
		private var tingCardsView:TingCardsView
		
		private var backBtn:Image
		
		override protected function createChildren():void {
			super.createChildren()
			
			bgLayer = new UIComponent()
			addChild(bgLayer)
			
			g1Image = new Image()
			g1Image.width = 330
			g1Image.height = 32
			g1Image.source = 'assets/room/g1.png'
			addChild(g1Image)
			
			g2Image = new Image()
			g2Image.width = 208
			g2Image.height = 48
			g2Image.source = 'assets/room/g2.png'
			addChild(g2Image)
			
			cardsCarrUI = new Image()
			cardsCarrUI.width = Size.BIG_CARD_WIDTH - 20
			cardsCarrUI.height = Size.BIG_CARD_HEIGHT - 50
			cardsCarrUI.rotation = 90
			cardsCarrUI.y = 50
			cardsCarrUI.source = Assets.getInstane().getAssets('fight_full_card.png')
			cardsCarrUI.visible = false
			bgLayer.addChild(cardsCarrUI)
			
			cardsLabel = new Label()
			cardsLabel.y = cardsCarrUI.y
			cardsLabel.fontSize = 25
			cardsLabel.width = Size.BIG_CARD_HEIGHT - 50
			cardsLabel.height = Size.BIG_CARD_WIDTH - 20
			cardsLabel.bold = true
			cardsLabel.visible = false
			bgLayer.addChild(cardsLabel)
			
			preUserHead = new RoomUserHead()
			preUserHead.visible = false
			bgLayer.addChild(preUserHead)
			myUserHead = new RoomUserHead()
			myUserHead.visible = false
			bgLayer.addChild(myUserHead)
			nextUserHead = new RoomUserHead()
			nextUserHead.visible = false
			bgLayer.addChild(nextUserHead)
			
			checkWaitTip = new Image()
			checkWaitTip.width = 16
			checkWaitTip.height = 16
			checkWaitTip.visible = false
			checkWaitTip.source = Assets.getInstane().getAssets('wait.png')
			bgLayer.addChild(checkWaitTip)
			
			newCardTip = new Image()
			newCardTip.width = 245
			newCardTip.height = 40
			newCardTip.visible = false
			newCardTip.source = Assets.getInstane().getAssets('fight_txt_finger_tips.png')
			bgLayer.addChild(newCardTip)
			
			tingCardsView = new TingCardsView()
			bgLayer.addChild(tingCardsView)
			
			// 卡牌层
			cardLayer = new UIComponent()
			addChild(cardLayer)
			
			dealCardUI = new BigCardUI()
			dealCardUI.visible = false
			dealCardUI.card = 10
			cardLayer.addChild(dealCardUI)
			
			dealCardUI2 = new BigCardUI()
			dealCardUI2.isOut = false
			dealCardUI2.visible = false
			dealCardUI2.card = 10
			cardLayer.addChild(dealCardUI2)
			
			// 图标层
			iconLayer = new UIComponent()
			addChild(iconLayer)
			
			canPengButton = new Image()
			canPengButton.source = Assets.getInstane().getAssets('oprate_peng0.png')
			canPengButton.width = 154
			canPengButton.height = 159
			canPengButton.visible = false
			canPengButton.addEventListener(MouseEvent.CLICK, canPengButton_clickHandler)
			iconLayer.addChild(canPengButton)
			
			canChiButton = new Image()
			canChiButton.source = Assets.getInstane().getAssets('oprate_chi0.png')
			canChiButton.width = 154
			canChiButton.height = 159
			canChiButton.visible = false
			canChiButton.addEventListener(MouseEvent.CLICK, canChiButton_clickHandler)
			iconLayer.addChild(canChiButton)
			
			cancelButton = new Image()
			cancelButton.source = Assets.getInstane().getAssets('oprate_close0.png')
			cancelButton.width = 100
			cancelButton.height = 103
			cancelButton.visible = false
			cancelButton.addEventListener(MouseEvent.CLICK, cancelButton_clickHandler)
			iconLayer.addChild(cancelButton)
			
			canHuButton = new Image()
			canHuButton.source = Assets.getInstane().getAssets('oprate_hu0.png')
			canHuButton.width = 154
			canHuButton.height = 159
			canHuButton.visible = false
			canHuButton.addEventListener(MouseEvent.CLICK,canHuButton_clickHandler)
			iconLayer.addChild(canHuButton)
			
			zhunbeiButton = new ImageBtnWithUpAndDown()
			zhunbeiButton.upImageSource = 'assets/room/zhunbeih_up.png'
			zhunbeiButton.width = 191
			zhunbeiButton.height = 68
			zhunbeiButton.addEventListener(MouseEvent.CLICK, zhunbeiButton_clickHandler)
			iconLayer.addChild(zhunbeiButton)
			
			zhunbeiButton2 = new ImageBtnWithUpAndDown()
			zhunbeiButton2.upImageSource = 'assets/room/jbc_cancle_p.png'
			zhunbeiButton2.width = 191
			zhunbeiButton2.height = 68
			zhunbeiButton2.addEventListener(MouseEvent.CLICK, zhunbeiButton2_clickHandler)
			iconLayer.addChild(zhunbeiButton2)
			
			chatButton = new Image()
			chatButton.width = 84
			chatButton.height = 81
			chatButton.source = 'assets/room/btn_chat.png'
			chatButton.addEventListener(MouseEvent.CLICK, chatButton_clickHandler)
			iconLayer.addChild(chatButton)
			
			backBtn = new Image()
			backBtn.source = 'assets/club_btn_back.png';
			backBtn.width = 71;
			backBtn.height = 86;
			backBtn.addEventListener(MouseEvent.CLICK, back_clickHandler)
			iconLayer.addChild(backBtn)
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
				updatePreGroupCardUIs()
				updatePrePassCardUIs()
			}
			
			if (myUser) {
				updateMyHandCardUIs()
				updateMyGroupCardUIs()
				updateMyPassCardUIs()
			}
			
			if (nextUser) {
				updateNextGroupCardUIs()
				updateNextPassCardUIs()
			}
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			g1Image.x = (width - g1Image.width) / 2
			g1Image.y = height / 2 - g1Image.height - 40
			
			g2Image.x = (width - g2Image.width) / 2
			g2Image.y = g1Image.y + g1Image.height + 20
			
			preUserHead.x = 30
			preUserHead.y = 30
			
			myUserHead.x = 30
			myUserHead.y = height - myUserHead.height - 30
			
			nextUserHead.x = width - nextUserHead.width - 30
			nextUserHead.y = 30
			
			cardsCarrUI.x = (width + cardsCarrUI.height)  / 2
			cardsLabel.x = (width - cardsLabel.width)  / 2
			
			chatButton.x = width - 10 - chatButton.width
			chatButton.y = (height - chatButton.height) / 2
			
			cancelButton.x = chatButton.x - cancelButton.width - 30
			cancelButton.y = (height - cancelButton.height) / 2
			
			canPengButton.x = cancelButton.x - canPengButton.width - 10
			canPengButton.y = (height - canChiButton.height) / 2
			
			canHuButton.x = canPengButton.x
			canHuButton.y = canPengButton.y
			
			canChiButton.x = canHuButton.x
			canChiButton.y = canHuButton.y
			
			newCardTip.x = (width - newCardTip.width) / 2
			newCardTip.y = (height - newCardTip.height) / 2 + 60
			
			backBtn.x = width - backBtn.width
			zhunbeiButton.x = (width - zhunbeiButton.width) / 2
			zhunbeiButton.y = (height - zhunbeiButton.height) / 2
			zhunbeiButton2.x = (width - zhunbeiButton2.width) / 2
			zhunbeiButton2.y = (height - zhunbeiButton2.height) / 2
			
			tingCardsView.x = 30
			tingCardsView.y = (height - tingCardsView.height) / 2
		}
		
		override protected function drawSkin():void {
			super.drawSkin()
		}
		
		private function updateRoomInfo(room:Object):void {
			if (room) {
				this.roominfo.users = room.users
				if (room.zc) { this.roominfo.zc = room.zc }
				if (room.zn) { this.roominfo.zn = room.zn }
				if (room.pc) { this.roominfo.pc = room.pc }
				if (room.pn) { this.roominfo.pn = room.pn }
				if (room.hasOwnProperty('cc')) { this.roominfo.cc = room.cc }
				if (room.io) { this.roominfo.io = room.io } else { this.roominfo.io = false }
				
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
					preUserHead.visible = true
					preUserHead.username = preUser.username
				}  else {
					preUserHead.visible = false
				}
				
				if (myUser) {
					myUserHead.visible = true
					myUserHead.username = myUser.username
				}  else {
					myUserHead.visible = false
				}
				
				if (nextUser) {
					nextUserHead.visible = true
					nextUserHead.username = nextUser.username
				}  else {
					nextUserHead.visible = false
				}
				
				if (roominfo.cc)
					cardsLabel.text = '剩余' + roominfo.cc + '张牌'
				
				if (isGaming) {
					zhunbeiButton2.visible = zhunbeiButton.visible = false
				} else {
					for each(var user:Object in roominfo.users) {
						if (user.username == AppData.getInstane().user.username) {
							zhunbeiButton2.visible = user.isReady
							zhunbeiButton.visible = !zhunbeiButton2.visible
						}
					}
				}
			}
		}
		
		private function updateZhuangCard():void {
			if (roominfo) {
				dealCardUI2.visible = true
				dealCardUI2.card = roominfo.zc
				dealCardUI2.x = (width - dealCardUI2.width) / 2
				dealCardUI2.y =  110
			} else {
				dealCardUI2.visible = false
			}
		}
		private function updateNewCard():void {
			if (roominfo) {
				dealCardUI.visible = true
				dealCardUI.card = roominfo.pc
				dealCardUI.isOut = roominfo.io
				if (this.preUser && roominfo.pn == this.preUser.username) {
					dealCardUI.y = 30
					dealCardUI.x = 270
				} else if (this.nextUser && roominfo.pn == this.nextUser.username) {
					dealCardUI.y = 30
					dealCardUI.x = width - 270 - dealCardUI.width
				} else {
					dealCardUI.x = (width - dealCardUI.width) / 2
					dealCardUI.y = 110
				}
				Audio.getInstane().playCard(dealCardUI.card)
			} else {
				dealCardUI.visible = false
			}
		}
		private function updateWaitTip():void {
			if (preUser && checkUsername == preUser.username) {
				checkWaitTip.visible = true
				checkWaitTip.x = preUserHead.x + 15
				checkWaitTip.y = preUserHead.y - 15
			} else if (nextUser && checkUsername == nextUser.username) {
				checkWaitTip.visible = true
				checkWaitTip.x = nextUserHead.x + 15
				checkWaitTip.y = nextUserHead.y - 15
			} else {
				checkWaitTip.visible = false
			}
		}
		
		private var myHandCards:Array = null
		private var myHandCardWidth:Number = 0
		private var myHandCardStartX:Number = 0
		private var myHandCardHorizontalGap:Number = 1
		
		
		private function getMyHandCardsIndex(mouseX:Number):int {
			for (var i:int = 0; i < 20; i++) {
				var sx:Number = myHandCardStartX + i * (myHandCardWidth + myHandCardHorizontalGap)
				var ex:Number = myHandCardStartX + (i + 1) * (myHandCardWidth + myHandCardHorizontalGap)
				
				if (sx <= mouseX && ex > mouseX) {
					return i
				}
			}
			
			return -1
		}
		
		/**
		 *  更新我的牌视图
		 */		
		private function updateMyHandCardUIs():void {
			if (myUser) {
				
				if (draggingCardUI) {
					draggingCardUI.stopDrag()
				}
				
				if (!myHandCards) {
					myHandCards = CardUtil.getInstane().riffle(myUser.handCards)
				} else {
					// myHandlers 已经存在了 匹配 增减就可以了
					var oldCards:Array = []
					var newCards:Array = []
					for each(var newCard:int in myUser.handCards) {
						newCards.push(newCard)
					}
					
					for each(var group:Array in myHandCards) {
						oldCards = oldCards.concat(group)
					}
					
					function deleteNewCard(card):Boolean {
						for (var i:int = newCards.length - 1; i >= 0; i--){
							if (newCards[i] == card) {
								newCards.splice(i, 1)
								return true
							}
						} 
						return false
					}
					
					for (var j:int = oldCards.length - 1; j >= 0; j--) {
						if (deleteNewCard(oldCards[j])) {
							oldCards.splice(j, 1)
						}
					}
					
					function deleteMyHandCard(card):void {
						for (var yi:int = myHandCards.length - 1; yi >= 0; yi--) {
							for (var xi:int = 0; xi < myHandCards[yi].length; xi++) {
								if (myHandCards[yi][xi] == card) {
									myHandCards[yi].splice(xi, 1)
									return 
								}
							}
						}
					}
					
					if (oldCards)
						for each(var oldCard:int in oldCards) {
						deleteMyHandCard(oldCard)
					}
				}
				
				for (var ii:int = myHandCards.length - 1; ii >= 0; ii--) {
					if (myHandCards[ii].length == 0) {
						myHandCards.splice(ii, 1)
					}
				}
				
				// 回收CardUIs
				var oldMyHandCardUIs:Array = []
				for each(var cardUI: CardUI in myHandCardUIs) {
					cardUI.visible = false
					cardUI.tingCards = null
					oldMyHandCardUIs.push(cardUI)
				}
				myHandCardUIs = []
				
				myHandCardWidth = Size.MIDDLE_CARD_WIDTH
				var cardHeight:Number = Size.MIDDLE_CARD_HEIGHT
				myHandCardHorizontalGap = 1
				var verticalGap:Number = cardHeight * 3 / 4
				var newCardUI:CardUI
				myHandCardStartX = (width - myHandCards.length * (myHandCardWidth + myHandCardHorizontalGap)) / 2
				for (var i:int = 0; i < myHandCards.length; i++) {
					var groupCards:Array = myHandCards[i]
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
					for (var jj:int = 0; jj < groupCards.length; jj++) {
						newCardUI = oldMyHandCardUIs.pop()
						if (!newCardUI) {
							newCardUI = new CardUI()
							newCardUI.addEventListener(MouseEvent.MOUSE_DOWN, cardUI_mouseDownHandler)
							cardLayer.addChild(newCardUI)
						}
						newCardUI.visible = true
						newCardUI.canDeal = canDeal
						newCardUI.width = myHandCardWidth
						newCardUI.height = cardHeight
						newCardUI.x = myHandCardStartX + i * (newCardUI.width + myHandCardHorizontalGap)
						newCardUI.y = height - newCardUI.height - jj * verticalGap - 5
						newCardUI.card = myHandCards[i][jj]
						newCardUI.type = CardUI.TYPE_BIG_CARD
						cardLayer.setChildIndex(newCardUI, 0)
						myHandCardUIs.push(newCardUI)
					}
				}
			}
		}
		
		private function updateMyHandCardUIsCanOutTing():void {
			if (myUser) {
				var outTings:Array = CardUtil.getInstane().outCardCanTing(myUser.groupCards, myUser.handCards, huxi)
				if (outTings) {
					for each(var item:Object in outTings) {
						for each(var cardUI:CardUI in myHandCardUIs) {
							if (cardUI.card == item.card && !cardUI.tingCards) {
								cardUI.tingCards = item.tingCards
								break
							}
						}
					}
				}
			}
		}
		
		private function clearMyHandCardUIsCanOutTing():void {
			for each(var cardUI:CardUI in myHandCardUIs) {
				cardUI.tingCards = null
			}
		}
		
		private function updateMyHandCardUIsCanTing():void {
			if (myUser) {
				tingCardsView.tingCards = CardUtil.getInstane().canTing(myUser.groupCards, myUser.handCards, huxi)
			}
		}
		
		/**
		 *  更新我的组合牌视图
		 */		
		private function updateMyGroupCardUIs():void {
			if (myUser) {
				var riffleCards:Array = this.myUser.groupCards
				var oldMyGroupCardUIs:Array = []
				for each(var cardUI: CardUI in myGroupCardUIs) {
					cardUI.visible = false
					oldMyGroupCardUIs.push(cardUI)
				}
				myGroupCardUIs = []
				var cardWidth:Number = Size.SMALL_CARD_WIDTH
				var cardHeight:Number = Size.SMALL_CARD_HEIGHT
				var horizontalGap:Number = 1
				var verticalGap:Number = cardHeight * 3 / 4
				var newCardUI:CardUI
				var startX:Number = width / 2 - cardWidth * 4
				for (var i:int = 0; i < riffleCards.length; i++) {
					var group:Object = riffleCards[i]
					var groupCards:Array = group.cards
					groupCards.sort()
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
						newCardUI.y = height / 2 - newCardUI.height - j * verticalGap - 100
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
				var riffleCards:Array = this.myUser.passCards
				var oldMyPassCardUIs:Array = []
				for each(var cardUI: CardUI in myPassCardUIs) {
					cardUI.visible = false
					oldMyPassCardUIs.push(cardUI)
				}
				myPassCardUIs = []
				var cardWidth:Number = Size.SMALL_CARD_WIDTH
				var cardHeight:Number = Size.SMALL_CARD_HEIGHT
				var horizontalGap:Number = 1
				var newCardUI:CardUI
				var startX:Number = width - cardWidth - 10
				for (var i:int = 0; i < riffleCards.length; i++) {
					newCardUI = oldMyPassCardUIs.pop()
					if (!newCardUI) {
						newCardUI = new CardUI()
						cardLayer.addChild(newCardUI)
					}
					newCardUI.visible = true
					newCardUI.width = cardWidth
					newCardUI.height = cardHeight
					newCardUI.x = startX - (i % 6) * (newCardUI.width + horizontalGap)
					newCardUI.y = height - 5 - (Math.floor(i / 6) + 1)  * (newCardUI.height + 1)
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
				var riffleCards:Array = this.preUser.groupCards
				var oldPreGroupCardUIs:Array = []
				for each(var cardUI: CardUI in preGroupCardUIs) {
					cardUI.visible = false
					oldPreGroupCardUIs.push(cardUI)
				}
				preGroupCardUIs = []
				var cardWidth:Number = Size.SMALL_CARD_WIDTH
				var cardHeight:Number = Size.SMALL_CARD_HEIGHT
				var horizontalGap:Number = 1
				var verticalGap:Number = Size.SMALL_CARD_HEIGHT * Size.GAP_RADIO
				var newCardUI:CardUI
				var startX:Number = 120
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
						newCardUI.y = 185 - cardHeight - newCardUI.height - j * verticalGap
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
				var riffleCards:Array = this.preUser.passCards
				var oldPrePassCardUIs:Array = []
				for each(var cardUI: CardUI in prePassCardUIs) {
					cardUI.visible = false
					oldPrePassCardUIs.push(cardUI)
				}
				prePassCardUIs = []
				var cardWidth:Number = Size.SMALL_CARD_WIDTH
				var cardHeight:Number = Size.SMALL_CARD_HEIGHT
				var horizontalGap:Number = 1
				var newCardUI:CardUI
				var startX:Number = 120
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
					newCardUI.y = 190 - cardHeight
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
				var riffleCards:Array = this.nextUser.groupCards
				var oldNextGroupCardUIs:Array = []
				for each(var cardUI: CardUI in nextGroupCardUIs) {
					cardUI.visible = false
					oldNextGroupCardUIs.push(cardUI)
				}
				nextGroupCardUIs = []
				var cardWidth:Number = Size.SMALL_CARD_WIDTH
				var cardHeight:Number = Size.SMALL_CARD_HEIGHT
				var horizontalGap:Number = 1
				var verticalGap:Number = Size.SMALL_CARD_HEIGHT * Size.GAP_RADIO
				var newCardUI:CardUI
				var startX:Number = width - cardWidth - 120
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
						newCardUI.y = 185 - cardHeight - newCardUI.height - j * verticalGap
						newCardUI.card = groupCards[j]
						newCardUI.type = CardUI.TYPE_SMALL_CARD
						cardLayer.setChildIndex(newCardUI, 0)
						nextGroupCardUIs.push(newCardUI)
					}
				}
				
			}
		}
		
		/**
		 *  更新下家的弃牌视图
		 */		
		private function updateNextPassCardUIs():void {
			if (nextUser) {
				var riffleCards:Array = this.nextUser.passCards
				var oldNextPassCardUIs:Array = []
				for each(var cardUI: CardUI in nextPassCardUIs) {
					cardUI.visible = false
					oldNextPassCardUIs.push(cardUI)
				}
				nextPassCardUIs = []
				var cardWidth:Number = Size.SMALL_CARD_WIDTH
				var cardHeight:Number = Size.SMALL_CARD_HEIGHT
				var horizontalGap:Number = 1
				var newCardUI:CardUI
				var startX:Number = width - cardWidth - 120
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
					newCardUI.y = 190 - cardHeight
					newCardUI.card = riffleCards[i]
					newCardUI.type = CardUI.TYPE_SMALL_CARD
					cardLayer.setChildIndex(newCardUI, 0)
					nextPassCardUIs.push(newCardUI)
				}
				
			}
		}
		
		private var draggingCardUI:CardUI
		private var si:int = -1
		private var ei:int = -1
		
		protected function cardUI_mouseDownHandler(event:MouseEvent):void
		{
			var cardUI:CardUI = event.currentTarget as CardUI
			if (cardUI && cardUI.canDeal) {
				si = getMyHandCardsIndex(this.mouseX)
				draggingCardUI = cardUI
				draggingCardUI.parent.setChildIndex(draggingCardUI, draggingCardUI.parent.numChildren - 1)
				oldPoint = cardLayer.localToGlobal(new Point(draggingCardUI.x, draggingCardUI.y))
				draggingCardUI.startDrag()
				
				if (draggingCardUI.tingCards) {
					tingCardsView.tingCards = draggingCardUI.tingCards
				}
				
				this.addEventListener(MouseEvent.MOUSE_UP, this_mouseUpHandler)
			}
		}
		
		protected function this_mouseUpHandler(event:MouseEvent):void {
			this.removeEventListener(MouseEvent.MOUSE_UP, this_mouseUpHandler)
			if (draggingCardUI) {
				draggingCardUI.stopDrag()
				if (isCheckNewCard && mouseY <= height * 2 / 3) {
					var action:Object = { name: Actions.NewCard, data: draggingCardUI.card }
					Api.getInstane().sendAction(action)
					newCardTip.visible = false
					isCheckNewCard = false
					// 出牌之后清理出听提示
					clearMyHandCardUIsCanOutTing()
				}
			} else {
				ei = getMyHandCardsIndex(this.mouseX)
				if (si >= 0 && ei >= 0) {
					//  调整牌位置
					if (myHandCards[si]) {
						var index:int = (myHandCards[si] as Array).indexOf(draggingCardUI.card)
						if (index >= 0) {
							if (myHandCards[ei]) {
								if (myHandCards[ei].length < 3) {
									myHandCards[si].splice(index, 1) // 删除这个元素
									myHandCards[ei].push(draggingCardUI.card)
								} else if (myHandCards[ei].length == 3) {
									if (myHandCards[ei][0] == myHandCards[ei][1] && myHandCards[ei][1] == myHandCards[ei][2]) {
										// 坎元素不能堆积
										trace('这是坎 不能堆积')
									} else {
										myHandCards[si].splice(index, 1) // 删除这个元素
										myHandCards[ei].push(draggingCardUI.card)
									}
								}
							} else {
								myHandCards[si].splice(index, 1) // 删除这个元素
								myHandCards.push([draggingCardUI.card])
							}
						}
					}
				}
			}
			
			updateMyHandCardUIs()
			if (isCheckNewCard) { // 出牌状态才会刷新
				tingCardsView.tingCards = null
				updateMyHandCardUIsCanOutTing()
			} else {
				updateMyHandCardUIsCanTing()
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
			var notification: Object = event.data
			switch(notification.name)
			{
				case Notifications.onReady:
				{
					updateRoomInfo(notification.data)
					break
				}
				case Notifications.onNewRound:
				{
					isGaming = true
					myHandCards = null
					tingCardsView.tingCards = null
					zhunbeiButton.visible = zhunbeiButton2.visible = false
					cardsCarrUI.visible = cardsLabel.visible = true
					dealCardUI.visible = false
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
					myHandCards = null
					dealCardUI2.visible = false // zhuangka
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
						tingCardsView.tingCards = null
						updateMyHandCardUIsCanOutTing()
					}
					
					break
				}
				case Notifications.onNewCard: {
					trace('有玩家发新牌', JSON.stringify(notification.data))
					checkUsername = null
					updateRoomInfo(notification.data)
					updateNewCard()
					updateWaitTip()
					updateMyHandCardUIs()
					updateMyHandCardUIsCanTing()
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
					trace('检查碰', JSON.stringify(notification.data))
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
				case Notifications.onBi: {
					trace('有人比')
					dealCardUI.visible = false
					Audio.getInstane().playHandle('bi')
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
					isGaming = false
					trace('胡牌', JSON.stringify(notification.data))
					Audio.getInstane().playHandle('hu')
					cardsCarrUI.visible = cardsLabel.visible = false
					WinView.getInstane().data = notification.data
					PopUpManager.centerPopUp(PopUpManager.addPopUp(WinView.getInstane()))
					zhunbeiButton.visible = true
					break
				}
				case Notifications.onRoundEnd: {
					isGaming = false
					cardsCarrUI.visible = cardsLabel.visible = false
					WinView.getInstane().data = null // 荒庄
					PopUpManager.centerPopUp(PopUpManager.addPopUp(WinView.getInstane()))
					zhunbeiButton.visible = true
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
			var action:Object = { name: Actions.Peng, data: thisCanPengCards }
			Api.getInstane().sendAction(action)
		}
		
		protected function canChiButton_clickHandler(event:MouseEvent):void
		{
			ChiSelectView.getInstane().addEventListener(SelectEvent.SELECTED, chi_selectHandler)
			ChiSelectView.getInstane().y = 30
			ChiSelectView.getInstane().width = width
			ChiSelectView.getInstane().open(thisCanChiCards)
		}
		
		protected function cancelButton_clickHandler(event:MouseEvent):void
		{
			if (ChiSelectView.getInstane().isPopUp) {
				ChiSelectView.getInstane().close()
			}
			isHu = canHuButton.visible = canPengButton.visible = canChiButton.visible = cancelButton.visible = false
			var action:Object = { name: Actions.Cancel, data: '' }
			Api.getInstane().sendAction(action)
		}
		
		protected function canHuButton_clickHandler(event:MouseEvent):void
		{
			isHu = canHuButton.visible = canPengButton.visible = canChiButton.visible = cancelButton.visible = false
			var action:Object = { name: Actions.Hu, data: thisCanHuDatas }
			Api.getInstane().sendAction(action)
		}
		
		public function init(roominfo:Object): void {
			isGaming = false
			if (roominfo.huxi) {
				huxi = roominfo.huxi
			} else {
				huxi = 15
			}
			zhunbeiButton.visible = true
			zhunbeiButton2.visible = false
			Api.getInstane().addEventListener(ApiEvent.ON_ROOM, onRoomMessageHandler)
		}
		
		protected function back_clickHandler(event:MouseEvent):void
		{
			Api.getInstane().removeEventListener(ApiEvent.ON_ROOM, onRoomMessageHandler)
			Api.getInstane().leaveRoom()
			MainView.getInstane().popView(GroupView)
		}
		
		protected function zhunbeiButton_clickHandler(event:MouseEvent):void
		{
			var action:Object = { name: Actions.Ready, data: true }
			Api.getInstane().sendAction(action)
		}
		
		protected function zhunbeiButton2_clickHandler(event:MouseEvent):void
		{
			var action:Object = { name: Actions.Ready, data: false }
			Api.getInstane().sendAction(action)
		}
		
		protected function chi_selectHandler(event:SelectEvent):void
		{
			ChiSelectView.getInstane().close()
			isHu = canHuButton.visible = canPengButton.visible = canChiButton.visible = cancelButton.visible = false
			var action:Object = { name: Actions.Chi, data:  event.data}
			Api.getInstane().sendAction(action)
		}
		
		protected function onRoomMessageHandler(event:ApiEvent):void
		{
			var message:Object = event.data.data.message
			if (message.cmd == 1) {
				Audio.getInstane().playChat(message.data)
			}
		}
		
		protected function chatButton_clickHandler(event:MouseEvent):void
		{
			RoomChatView.getInstane().open(chatButton.x - RoomChatView.getInstane().width, (height - RoomChatView.getInstane().height) / 2)
		}
		
	}
}