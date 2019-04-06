package com.xiaomu.view.room
{
	import com.xiaomu.component.AppAlert;
	import com.xiaomu.component.BigCardUI;
	import com.xiaomu.component.CardUI;
	import com.xiaomu.component.ImageButton;
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
		}
		
		private var roomname:String
		private var roomrule:Object
		private var oldPoint:Point
		private var bgLayer: UIComponent
		private var g1Image:Image
		private var g2Image:Image
		private var roomnameDisplay:Label
		private var preUserHead:RoomUserHead
		private var myUserHead:RoomUserHead
		private var nextUserHead:RoomUserHead
		private var cardLayer: UIComponent
		private var cardsCarrUI:Image
		private var cardsLabel:Label
		private var dealCardUI: BigCardUI
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
		private var zhunbeiButton:ImageButton
		private var zhunbeiButton2:ImageButton
		private var canHuButton:Image
		private var canPengButton:Image
		private var canChiButton:Image
		private var cancelButton:Image
		private var newCardTip:Image
		private var checkWaitTip:Image
		private var chatButton:ImageButton
		private var tingCardsView:TingCardsView
		private var goback:ImageButton
		private var refreshButton:ImageButton
		private var myActionUser:Object
		private var preActionUser:Object
		private var nextActionUser:Object
		
		private var _roomData:Object
		
		public function get roomData():Object
		{
			return _roomData;
		}
		
		public function set roomData(value:Object):void
		{
			_roomData = value;
			invalidateProperties()
		}
		
		private var _needRiffleCard:Boolean = false
		
		/**
		 * 是否需要整理牌 
		 * @return 
		 */			
		public function get needRiffleCard():Boolean
		{
			return _needRiffleCard;
		}
		
		public function set needRiffleCard(value:Boolean):void
		{
			_needRiffleCard = value;
			invalidateProperties()
		}
		
		override protected function createChildren():void {
			super.createChildren()
			
			bgLayer = new UIComponent()
			addChild(bgLayer)
			
			roomnameDisplay = new Label()
			roomnameDisplay.height = 50
			addChild(roomnameDisplay)
			
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
			
			// 剩余牌显示
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
			
			// 用户头像
			preUserHead = new RoomUserHead()
			preUserHead.visible = false
			bgLayer.addChild(preUserHead)
			myUserHead = new RoomUserHead()
			myUserHead.visible = false
			bgLayer.addChild(myUserHead)
			nextUserHead = new RoomUserHead()
			nextUserHead.visible = false
			bgLayer.addChild(nextUserHead)
			
			// 等待提示
			checkWaitTip = new Image()
			checkWaitTip.width = 16
			checkWaitTip.height = 16
			checkWaitTip.visible = false
			checkWaitTip.source = Assets.getInstane().getAssets('wait.png')
			bgLayer.addChild(checkWaitTip)
			
			// 出牌提示
			newCardTip = new Image()
			newCardTip.width = 245
			newCardTip.height = 40
			newCardTip.visible = false
			newCardTip.source = Assets.getInstane().getAssets('fight_txt_finger_tips.png')
			bgLayer.addChild(newCardTip)
			
			// 听牌显示
			tingCardsView = new TingCardsView()
			bgLayer.addChild(tingCardsView)
			
			// 卡牌层
			cardLayer = new UIComponent()
			addChild(cardLayer)
			
			// 出的牌提示
			dealCardUI = new BigCardUI()
			dealCardUI.visible = false
			dealCardUI.card = 10
			cardLayer.addChild(dealCardUI)
			
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
			
			// 准备按钮
			zhunbeiButton = new ImageButton()
			zhunbeiButton.upImageSource = 'assets/room/zhunbeih_up.png'
			zhunbeiButton.downImageSource = 'assets/room/zhunbeih_down.png'
			zhunbeiButton.width = 191
			zhunbeiButton.height = 68
			zhunbeiButton.addEventListener(MouseEvent.CLICK, zhunbeiButton_clickHandler)
			iconLayer.addChild(zhunbeiButton)
			zhunbeiButton2 = new ImageButton()
			zhunbeiButton2.upImageSource = 'assets/room/jbc_cancle_n.png'
			zhunbeiButton2.downImageSource = 'assets/room/jbc_cancle_p.png'
			zhunbeiButton2.width = 191
			zhunbeiButton2.height = 68
			zhunbeiButton2.addEventListener(MouseEvent.CLICK, zhunbeiButton2_clickHandler)
			iconLayer.addChild(zhunbeiButton2)
			
			// 聊天返回 按钮
			chatButton = new ImageButton()
			chatButton.width = 60
			chatButton.height = 60
			chatButton.upImageSource = 'assets/room/btn_chat.png'
			chatButton.addEventListener(MouseEvent.CLICK, chatButton_clickHandler)
			iconLayer.addChild(chatButton)
			
			goback= new ImageButton()
			goback.upImageSource = 'assets/group/btn_guild2_return_n.png';
			goback.downImageSource = 'assets/group/btn_guild2_return_p.png';
			goback.width = 85;
			goback.height = 91;
			goback.addEventListener(MouseEvent.CLICK, back_clickHandler)
			addChild(goback)
			
			refreshButton = new ImageButton()
			refreshButton.width = 60
			refreshButton.height = 64
			refreshButton.upImageSource = 'assets/group/btn_guild2_refresh_n.png';
			refreshButton.downImageSource = 'assets/group/btn_guild2_refresh_p.png';
			refreshButton.addEventListener(MouseEvent.CLICK, refreshButton_clickHandler)
			addChild(refreshButton)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			try
			{
				roomnameDisplay.text = '房间号: ' + roomname.substr(4)
			} 
			catch(error:Error) 
			{
				
			}
			
			if (!roomData) return
			
			// 隐藏所有
			hideAllUI()
			
			myActionUser = preActionUser = nextActionUser = myUser = preUser = nextUser = null
			// 生成 myUser preUser nextUser
			for (var i:int = 0; i < roomData.us.length; i++) {
				if (roomData.us[i].username == AppData.getInstane().user.username) {
					var endUsers:Array = roomData.us.slice(i)
					var startUsers:Array = roomData.us.slice(0, i)
					var orderUsers:Array = endUsers.concat(startUsers)
					this.myUser = orderUsers.shift()
					if (orderUsers.length > 0) {
						this.preUser = orderUsers.shift()
					}
					if (orderUsers.length > 0) {
						this.nextUser = orderUsers.pop()
					}
					break
				}
			}
			
			if (needRiffleCard) {
				myHandCards = null
				_needRiffleCard = false
			}
			
			if (preUser) {
				preUserHead.visible = true
				preUserHead.username = preUser.username
				preUserHead.isZhuang = preUserHead.username == roomData.zn
				preUserHead.isNiao = preUser.dn
				preUserHead.isFocus = roomData.pc > 0 && preUserHead.username == roomData.pn
				preUserHead.thx = preUser.thx
				preUserHead.huxi = CardUtil.getInstane().getHuXi(preUser.groupCards)
				preActionUser = getActionUser(preUser.username)
			}
			
			if (myUser) {
				myUserHead.visible = true
				refreshButton.visible = true
				myUserHead.username = myUser.username
				myUserHead.isZhuang = myUserHead.username == roomData.zn
				myUserHead.isNiao = myUser.dn
				myUserHead.isFocus = roomData.pc > 0 && myUserHead.username == roomData.pn
				myUserHead.thx = myUser.thx
				myUserHead.huxi = CardUtil.getInstane().getHuXi(myUser.groupCards)
				myActionUser = getActionUser(myUser.username)
			}
			
			if (nextUser) {
				nextUserHead.visible = true
				nextUserHead.username = nextUser.username
				nextUserHead.isZhuang = nextUserHead.username == roomData.zn
				nextUserHead.isNiao = nextUser.dn
				nextUserHead.isFocus = roomData.pc > 0 && nextUserHead.username == roomData.pn
				nextUserHead.huxi = CardUtil.getInstane().getHuXi(nextUser.groupCards)
				nextUserHead.thx = nextUser.thx
				nextActionUser = getActionUser(nextUser.username)
			} 
			
			if (roomData.ig) {
				if (preUser) {
					updatePreGroupCardUIs()
					updatePrePassCardUIs()
				}
				
				if (myUser) {
					updateMyHandCardUIs()
					updateMyGroupCardUIs()
					updateMyPassCardUIs()
					updateMyHandCardUIsCanTing()
				}
				
				if (nextUser) {
					updateNextGroupCardUIs()
					updateNextPassCardUIs()
				} 
				
				updateNewCard()
				updateWaitTip()
				updateCardsCount()
				
				if (myActionUser) {
					if (myActionUser.nd) {
						newCardTip.visible = true
						if (!tingCardsView.tingCards) {
							updateMyHandCardUIsCanOutTing()
						}
						myUserHead.isFocus = true
					}
					if (myActionUser.hd) {
						cancelButton.visible = canHuButton.visible = true
					}
					if (myActionUser.cd) {
						cancelButton.visible = canChiButton.visible = true
					} 
					if (myActionUser.pd) {
						cancelButton.visible = canPengButton.visible = true
					}
				}
				
				if (nextActionUser) {
					if (nextActionUser.nd) {
						nextUserHead.isFocus = true
					}
				}
				
				if (preActionUser) {
					if (preActionUser.nd) {
						preUserHead.isFocus = true
					}
				}
			} else {
				updateReadyUI()
			}
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			roomnameDisplay.width = width
			
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
			
			cancelButton.x = width - cancelButton.width - 10
			cancelButton.y = (height - cancelButton.height) / 2
			
			chatButton.x = width - 10 - chatButton.width
			chatButton.y = cancelButton.y + cancelButton.height + 10
			
			refreshButton.x = chatButton.x
			refreshButton.y = chatButton.y + chatButton.height + 10
			
			canChiButton.x = cancelButton.x - canChiButton.width - 10
			canChiButton.y = (height - canChiButton.height) / 2
			
			canPengButton.x = canChiButton.x - canPengButton.width - 10
			canPengButton.y = canChiButton.y
			
			canHuButton.x = canPengButton.x - canHuButton.width - 10
			canHuButton.y = canPengButton.y
			
			newCardTip.x = (width - newCardTip.width) / 2
			newCardTip.y = (height - newCardTip.height) / 2 + 50
			
			zhunbeiButton.x = (width - zhunbeiButton.width) / 2
			zhunbeiButton.y = (height - zhunbeiButton.height) / 2
			zhunbeiButton2.x = (width - zhunbeiButton2.width) / 2
			zhunbeiButton2.y = (height - zhunbeiButton2.height) / 2
			
			tingCardsView.x = 30
			tingCardsView.y = (height - tingCardsView.height) / 2
			
			goback.x = width - goback.width - 20
			goback.y = 10
		}
		
		public function init(room:Object): void {
			this.roomname = room.rn
			this.roomrule = room.ru
			Api.getInstane().addEventListener(ApiEvent.ON_ROOM, onNotificationHandler)
			Api.getInstane().queryRoomStatus(function (response:Object):void {
				if (response.code == 0) {
					roomData = response.data
					needRiffleCard = true
					if (!roomData.og) {
						new DaNiaoNoticePanel().open()
					}
				} else {
					AppAlert.show('房间数据加载失败')
					close()
				}
			}) 
		}
		
		private function hideAllUI():void {
			var cardUI:CardUI
			for each(cardUI in myHandCardUIs) {
				cardUI.visible = false
				cardUI.tingCards = null
			}
			for each(cardUI in myGroupCardUIs) {
				cardUI.visible = false
			}
			for each(cardUI in myPassCardUIs) {
				cardUI.visible = false
			}
			for each(cardUI in preGroupCardUIs) {
				cardUI.visible = false
			}
			for each(cardUI in prePassCardUIs) {
				cardUI.visible = false
			}
			for each(cardUI in nextGroupCardUIs) {
				cardUI.visible = false
			}
			for each(cardUI in nextPassCardUIs) {
				cardUI.visible = false
			}
			
			tingCardsView.tingCards = null
			refreshButton.visible = false
			myUserHead.isFocus = myUserHead.isNiao = myUserHead.visible = false
			preUserHead.isFocus = preUserHead.isNiao = preUserHead.visible = false
			nextUserHead.isFocus = nextUserHead.isNiao = nextUserHead.visible = false
			zhunbeiButton2.visible = zhunbeiButton.visible = false
			dealCardUI.visible = false
			newCardTip.visible = false
			cardsCarrUI.visible = cardsLabel.visible = false
			checkWaitTip.visible = false
			cancelButton.visible = false
			canChiButton.visible = false
			canPengButton.visible = false
			canHuButton.visible = false
		}
		
		private function updateReadyUI():void {
			if (roomData) {
				for each(var user:Object in roomData.us) {
					if (user.username == AppData.getInstane().user.username) {
						zhunbeiButton2.visible = user.isReady
						zhunbeiButton.visible = !zhunbeiButton2.visible
					}
				}
			}
		}
		
		private function updateNewCard():void {
			if (roomData.pc > 0) {  // 有玩家出牌 或 翻牌
				dealCardUI.visible = true
				dealCardUI.card = roomData.pc
				dealCardUI.isOut = roomData.io
				if (this.preUser && roomData.pn == this.preUser.username) {
					dealCardUI.y = 30
					dealCardUI.x = 270
				} else if (this.nextUser && roomData.pn == this.nextUser.username) {
					dealCardUI.y = 30
					dealCardUI.x = width - 270 - dealCardUI.width
				} else {
					dealCardUI.x = (width - dealCardUI.width) / 2
					dealCardUI.y = 110
				}
			} else if (roomData.zc > 0) {
				dealCardUI.visible = true
				dealCardUI.card = roomData.zc
				dealCardUI.isOut = false
				if (this.preUser && roomData.zn == this.preUser.username) {
					dealCardUI.y = 30
					dealCardUI.x = 270
				} else if (this.nextUser && roomData.zn == this.nextUser.username) {
					dealCardUI.y = 30
					dealCardUI.x = width - 270 - dealCardUI.width
				} else {
					dealCardUI.x = (width - dealCardUI.width) / 2
					dealCardUI.y = 110
				}
			} else {
				dealCardUI.visible = false
			}
		}
		
		private function updateCardsCount():void {
			cardsCarrUI.visible = cardsLabel.visible = true
			if (roomData) {
				cardsLabel.text = '剩余' + roomData.cc + '张牌'
			} else {
				cardsLabel.text = '剩余0张牌'
			}
		}
		
		private function updateWaitTip():void {
			if (preUser && roomData.an == preUser.username) {
				checkWaitTip.visible = true
				checkWaitTip.x = preUserHead.x + 15
				checkWaitTip.y = preUserHead.y - 15
			} else if (nextUser && roomData.an == nextUser.username) {
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
					this.removeEventListener(MouseEvent.MOUSE_UP, this_mouseUpHandler)
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
				var outTings:Array = CardUtil.getInstane().outCardCanTing(myUser.groupCards, myUser.handCards, this.roomrule.hx)
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
		
		private function updateMyHandCardUIsCanTing():void {
			if (myUser) {
				tingCardsView.tingCards = CardUtil.getInstane().canTing(myUser.groupCards, myUser.handCards, this.roomrule.hx)
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
					newCardUI.x = startX + (i % 6) * (newCardUI.width + horizontalGap)
					newCardUI.y = 190 - cardHeight + Math.floor(i / 6) * (cardHeight + 1)
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
					newCardUI.x = startX - (i % 6) * (newCardUI.width + horizontalGap)
					newCardUI.y = 190 - cardHeight + Math.floor(i / 6)  * (cardHeight + 1)
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
				draggingCardUI.visible = false
				
				if (myActionUser && myActionUser.nd) {
					// 在需要我出牌的情况下
					if (this.mouseY <= height / 2) { 
						myActionUser.nd.dt = draggingCardUI.card
						myActionUser.nd.ac = 1
						var action:Object = { name: Actions.NewCard, data: myActionUser  }
						Api.getInstane().sendAction(action)
						meNewCard(draggingCardUI.card)
					} else {
						riffleCard()
						invalidateProperties()
						invalidateDisplayList()
					}
				} else {
					// 如果不是我出牌的 整理牌
					riffleCard()
					invalidateProperties()
					invalidateDisplayList()
				}
			}
		}
		
		private function riffleCard():void {
			// 整理牌
			ei = getMyHandCardsIndex(this.mouseX)
			if (si >= 0 && ei >= 0 && si != ei) {
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
		
		protected function onNotificationHandler(event:ApiEvent):void
		{
			if (ChiSelectView.getInstane().isPopUp) {
				PopUpManager.removePopUp(ChiSelectView.getInstane())
			}
			
			var notification: Object = event.data
			switch(notification.name)
			{
				case Notifications.onRoomMessage: 
				{
					Audio.getInstane().playChat(notification.data.data)
					break
				}
				case Notifications.onNewRound:
				{
					needRiffleCard = true // 需要整理手里牌
					roomData = notification.data
					if (roomData.zc && roomData.zc > 0) {
						Audio.getInstane().playCard(roomData.zc)
					}
					break
				}
				case Notifications.onGameStart: 
				case Notifications.onReady:
				case Notifications.onRoomStatus: 
				{
					needRiffleCard = true // 需要整理手里牌
					roomData = notification.data
					break
				}
				case Notifications.checkNewCard:
				{
					roomData = notification.data
					break
				}
				case Notifications.checkPeng:
				case Notifications.checkEat:
				case Notifications.checkHu:
				{
					roomData = notification.data
					break
				}
				case Notifications.onWin:///赢家界面 //一把
				{
					Audio.getInstane().playHandle('hu')
					AppAlert.show('玩家赢牌')
					roomData = notification.data
					trace("玩家赢牌:",JSON.stringify(roomData));
					break
				}
				case Notifications.onRoundEnd://荒庄
				{
					AppAlert.show('一盘结束') ///一把结束，可以准备下一把
					roomData = notification.data
					trace("一盘结束:",JSON.stringify(roomData));
					//roomData: {"pn":"wosxieez3","us":[{"username":"wosxieez3","groupCards":[{"name":"wei","cards":[17,17,17]},{"name":"wei","cards":[14,14,14]},{"name":"chi","cards":[1,2,3]},{"name":"wei","cards":[15,15,15]}],"dn":false,"isReady":false,"hx":0,"ucCards":[16,12,20,1,10,18,19],"upCards":[16,12,10,18,19],"passCards":[16,9,19,18,19,8,12,20,12,2,16,10,1,1,6,10,16,18,19,12],"handCards":[11,11,13,5,13,13,6,4]}],"ad":null,"zn":"wosxieez3","pc":0,"og":true,"io":false,"ig":false,"an":null,"at":0,"cc":0,"zc":0}
					break
				}
				case Notifications.onGameOver: 
				{
					Audio.getInstane().playHandle('hu')
					roomData = notification.data
					AppAlert.show('一局游戏结束') ///游戏结束房卡消耗。人自动退出到游戏的群界面
					trace("一局游戏结束:",JSON.stringify(roomData));
					close()
					break
				}
				case Notifications.onNewCard: 
				{
					roomData = notification.data
					Audio.getInstane().playCard(roomData.pc)
					break
				}
				case Notifications.onTi : 
				{
					Audio.getInstane().playHandle('ti')
					roomData = notification.data
					break
				}
				case Notifications.onPao: 
				{
					Audio.getInstane().playHandle('pao')
					roomData = notification.data
					break
				}
				case Notifications.onWei: 
				{
					Audio.getInstane().playHandle('wei')
					roomData = notification.data
					break
				}	
				case Notifications.onPeng: 
				{
					Audio.getInstane().playHandle('peng')
					roomData = notification.data
					break
				}
				case Notifications.onEat: 
				{
					Audio.getInstane().playHandle('chi')
					roomData = notification.data
					break
				}
				case Notifications.onBi: 
				{
					Audio.getInstane().playHandle('bi')
					roomData = notification.data
					break
				}
				case Notifications.onAction: 
				{
					roomData = notification.data
					break;
				}
				default:
				{
					break;
				}
			}
		}
		
		protected function canPengButton_clickHandler(event:MouseEvent):void
		{
			if (myActionUser) {
				undoActionUser()
				myActionUser.pd.ac = 1
				var action:Object = { name: Actions.Peng, data: myActionUser }
				Api.getInstane().sendAction(action)
				mePeng(myActionUser.pd.dt)
			}
		}
		
		protected function canChiButton_clickHandler(event:MouseEvent):void
		{
			if (myActionUser) {
				ChiSelectView.getInstane().addEventListener(SelectEvent.SELECTED, chi_selectHandler)
				ChiSelectView.getInstane().y = 50
				ChiSelectView.getInstane().width = width
				ChiSelectView.getInstane().open(myActionUser.cd.dt)
			}
		}
		
		protected function chi_selectHandler(event:SelectEvent):void
		{
			ChiSelectView.getInstane().close()
			if (myActionUser) {
				undoActionUser()
				myActionUser.cd.dt = event.data
				myActionUser.cd.ac = 1
				var action:Object = { name: Actions.Chi, data: myActionUser}
				Api.getInstane().sendAction(action)
				meChi(event.data as Array)
			}
		}
		
		protected function cancelButton_clickHandler(event:MouseEvent):void
		{
			if (ChiSelectView.getInstane().isPopUp) {
				ChiSelectView.getInstane().close()
			}
			canHuButton.visible = canPengButton.visible = canChiButton.visible = cancelButton.visible = false
			if (myActionUser) {
				undoActionUser()
				var action:Object = { name: Actions.Cancel, data: myActionUser }
				Api.getInstane().sendAction(action)
			}
		}
		
		private function undoActionUser():void {
			if (myActionUser) {
				if (myActionUser.hd) myActionUser.hd.ac = 0
				if (myActionUser.pd) myActionUser.pd.ac = 0
				if (myActionUser.cd) myActionUser.cd.ac = 0
				if (myActionUser.nd) myActionUser.nd.ac = 0
			}
		}
		
		protected function canHuButton_clickHandler(event:MouseEvent):void
		{
			canHuButton.visible = cancelButton.visible = false
			if (myActionUser) {
				undoActionUser()
				myActionUser.hd.ac = 1
				var action:Object = { name: Actions.Hu, data: myActionUser }
				Api.getInstane().sendAction(action)
			}
		}
		
		protected function back_clickHandler(event:MouseEvent):void
		{
			close()
		}
		
		public function close():void {
			Api.getInstane().removeEventListener(ApiEvent.ON_ROOM, onNotificationHandler)
			Api.getInstane().leaveRoom(function (response:Object):void {})
			hideAllUI()
			MainView.getInstane().popView(GroupView)
		}
		
		protected function refreshButton_clickHandler(event:MouseEvent):void
		{
			needRiffleCard = true
			invalidateProperties()
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
		
		protected function chatButton_clickHandler(event:MouseEvent):void
		{
			RoomChatView.getInstane().open(chatButton.x - RoomChatView.getInstane().width, (height - RoomChatView.getInstane().height) / 2)
		}
		
		private function meNewCard(card:int):void {
			if (myUser) {
				Audio.getInstane().playCard(card, true)
				roomData.pn = myUser.username
				roomData.pc = card
				roomData.io = true
				roomData.aus = []
				CardUtil.getInstane().deleteCard(myUser.handCards, card)
				invalidateProperties()
			}
		}
		
		private function meChi(groups:Array):void {
			return
			if (myUser) {
				myUser.handCards.push(roomData.pc)
				roomData.pc = 0
				var group:Object
				for (var i:int = 0; i < groups.length; i++) {
					group = groups[i]
					for (var j:int = 0; j < group.cards.length; j++) {
						CardUtil.getInstane().deleteCard(myUser.handCards, group.cards[j])
					}
					myUser.groupCards.push(group)
				}
				if (groups.length > 1) {
					Audio.getInstane().playHandle('bi', true)
				} else {
					Audio.getInstane().playHandle('chi', true)
				}
				invalidateProperties()
			}
		}
		
		private function mePeng(cards:Array):void {
			return
			if (myUser) {
				for (var i:int = 0; i < cards.length; i++) {
					CardUtil.getInstane().deleteCard(myUser.handCards, cards[i])
				}
				cards.push(roomData.pc)
				roomData.pc = 0
				myUser.groupCards.push({name: Actions.Peng, cards: cards})
				Audio.getInstane().playHandle('peng', true)
				invalidateProperties()
			}
		}
		
		private function getActionUser(username:String):Object {
			if (roomData.aus) {
				for (var n:int = 0; n < roomData.aus.length; n++) {
					if (roomData.aus[n] && roomData.aus[n].un == username) {
						return roomData.aus[n]
					}
				}
			} 
			return null
		}
		
	}
}