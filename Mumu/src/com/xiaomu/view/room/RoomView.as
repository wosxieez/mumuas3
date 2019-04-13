package com.xiaomu.view.room
{
	import com.xiaomu.component.AppAlert;
	import com.xiaomu.component.BigCardUI;
	import com.xiaomu.component.CardUI;
	import com.xiaomu.component.ImageButton;
	import com.xiaomu.event.ApiEvent;
	import com.xiaomu.event.AppManagerEvent;
	import com.xiaomu.event.SelectEvent;
	import com.xiaomu.manager.AppManager;
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
	import com.xiaomu.view.home.HomeView;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import coco.component.Alert;
	import coco.component.Image;
	import coco.component.Label;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	import coco.manager.PopUpManager;
	
	public class RoomView extends UIComponent
	{
		public function RoomView()
		{
			super();
			AppManager.getInstance().addEventListener(AppManagerEvent.CHANGE_ROOM_TABLE_IMG,changeRoomTableImgHandler);
			AppManager.getInstance().addEventListener(AppManagerEvent.LEAVE_GROUP_ROOM,leaveGroupRoomHandler);
			AppManager.getInstance().addEventListener(AppManagerEvent.FIX_ROOM,fixRoomHandler);
			AppManager.getInstance().addEventListener(AppManagerEvent.FORCE_LEAVE,forceLeaveHandler);
		}
		
		protected function leaveGroupRoomHandler(event:AppManagerEvent):void
		{
			if (roomData && roomData.og) {
				AppAlert.show('确定要申请退出吗?', '',Alert.OK|Alert.CANCEL, function (e:UIEvent):void {
					if (e.detail == Alert.OK) {
						var action:Object = { name: Actions.Ae, data: ''  }
						Api.getInstane().sendAction(action)
					} else {
						
					}
				})
			} else {
				close()
			}
		}
		
		protected function changeRoomTableImgHandler(event:AppManagerEvent):void
		{
			bg.source = 'assets/room/'+AppData.getInstane().roomTableImgsArr[parseInt(AppData.getInstane().roomTableIndex)];
		}
		
		private var bg:Image;
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
		private var canHuButton:ImageButton
		private var canPengButton:ImageButton
		private var canChiButton:ImageButton
		private var cancelButton:ImageButton
		private var newCardTip:Image
		private var checkWaitTip:Image
		private var chatButton:ImageButton
		private var tingCardsView:TingCardsView
		private var goback:ImageButton
		private var refreshButton:ImageButton
		private var myActionUser:Object
		private var preActionUser:Object
		private var nextActionUser:Object
		
		private var showSettingPanelBtn:ImageButton;
		
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
			
			bg = new Image();
			bg.source = 'assets/room/'+AppData.getInstane().roomTableImgsArr[parseInt(AppData.getInstane().roomTableIndex)];
			addChild(bg);
			
			bgLayer = new UIComponent()
			addChild(bgLayer)
			
			roomnameDisplay = new Label()
			roomnameDisplay.height = 50
			roomnameDisplay.color = 0xFFFFFF
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
			tingCardsView.visible = false
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
			
			canPengButton = new ImageButton()
			canPengButton.upImageSource = 'assets/room/Z_peng_light.png'
			canPengButton.downImageSource = 'assets/room/Z_peng.png'
			canPengButton.width = 154
			canPengButton.height = 159
			canPengButton.visible = false
			canPengButton.addEventListener(MouseEvent.CLICK, canPengButton_clickHandler)
			iconLayer.addChild(canPengButton)
			
			canChiButton = new ImageButton()
			canChiButton.upImageSource = 'assets/room/chi_light.png'
			canChiButton.downImageSource = 'assets/room/chi.png'
			canChiButton.width = 154
			canChiButton.height = 159
			canChiButton.visible = false
			canChiButton.addEventListener(MouseEvent.CLICK, canChiButton_clickHandler)
			iconLayer.addChild(canChiButton)
			
			cancelButton = new ImageButton()
			cancelButton.upImageSource = 'assets/room/Z_guo_light.png'
			cancelButton.downImageSource = 'assets/room/Z_guo.png'
			cancelButton.width = 100
			cancelButton.height = 103
			cancelButton.visible = false
			cancelButton.addEventListener(MouseEvent.CLICK, cancelButton_clickHandler)
			iconLayer.addChild(cancelButton)
			
			canHuButton = new ImageButton()
			canHuButton.upImageSource = 'assets/room/Z_hu_light.png'
			canHuButton.downImageSource = 'assets/room/Z_hu.png'
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
			
			///设置按钮--点击
			showSettingPanelBtn = new ImageButton();
			showSettingPanelBtn.upImageSource='assets/room/btn_zk_normal.png';
			showSettingPanelBtn.downImageSource='assets/room/btn_zk_press.png';
			showSettingPanelBtn.width = 69;
			showSettingPanelBtn.height = 68;
			showSettingPanelBtn.addEventListener(MouseEvent.CLICK,showSettingPanelBtnHandler);
			addChild(showSettingPanelBtn);
			
			goback= new ImageButton()
			goback.upImageSource = 'assets/group/btn_guild2_return_n.png';
			goback.downImageSource = 'assets/group/btn_guild2_return_p.png';
			goback.width = 85;
			goback.height = 91;
			goback.visible = false
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
				roomnameDisplay.text = '房间号:' + roomname.substr(4)
			} 
			catch(error:Error) 
			{
				
			}
			
			if (!roomData) return
			
			if (roomData.ic && roomData.ic > 0) {
				roomnameDisplay.text = roomnameDisplay.text + '	第' + roomData.ic + '盘'
			}
			
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
				if (myUser) {
					invalidateMyHandCardUIs()
					updateMyGroupCardUIs()
					updateMyPassCardUIs()
				}
				
				if (preUser) {
					callLater(updatePreGroupCardUIs)
					callLater(updatePrePassCardUIs)
				}
				if (nextUser) {
					callLater(updateNextGroupCardUIs)
					callLater(updateNextPassCardUIs)
				} 
				
				updateNewCard()
				updateWaitTip()
				updateCardsCount()
				
				if (myActionUser) {
					if (myActionUser.nd) {
						newCardTip.visible = true
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
					invalidateDisplayList()
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
				
				if (newCardTip.visible) {
					tingCardsView.tingCards = null
					invalidateMyHandCardUIsCanOutTing(true)
					Audio.getInstane().playTimeout()
				}
				
			} else {
				updateReadyUI()
			}
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			bg.width = width;
			bg.height = height;
			
			roomnameDisplay.width = width
			
			showSettingPanelBtn.x = width-showSettingPanelBtn.width-20;
			showSettingPanelBtn..y = 10;
			
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
			
			canPengButton.x = cancelButton.x - canPengButton.width - 10 - 
				(canChiButton.visible ? (canChiButton.width + 10) : 0)
			canPengButton.y = canChiButton.y
			
			canHuButton.x = cancelButton.x - canPengButton.width - 10 - 
				(canChiButton.visible ? (canChiButton.width + 10) : 0) -
				(canPengButton.visible ? (canPengButton.width + 10) : 0)
			canHuButton.y = canPengButton.y
			
			newCardTip.x = (width - newCardTip.width) / 2
			newCardTip.y = (height - newCardTip.height) / 2 + 50
			
			zhunbeiButton.x = (width - zhunbeiButton.width) / 2
			zhunbeiButton.y = (height - zhunbeiButton.height) / 2
			zhunbeiButton2.x = (width - zhunbeiButton2.width) / 2
			zhunbeiButton2.y = (height - zhunbeiButton2.height) / 2
			
			tingCardsView.x = 30
			tingCardsView.y = (height - tingCardsView.height) / 2
			
			goback.x = width - goback.width - 200
			goback.y = 10
		}
		
		public function init(room:Object): void {
			this.roomname = room.rn
			this.roomrule = room.ru
			Api.getInstane().addEventListener(ApiEvent.ON_ROOM, onNotificationHandler)
			Api.getInstane().addEventListener(ApiEvent.JOIN_ROOM, onJoinRoomHandler)
			invalidateProperties()
			Api.getInstane().queryRoomStatus(function (response:Object):void {
				if (response.code == 0) {
					roomData = response.data
					needRiffleCard = true
					if (room.ru && room.ru.id > 0 && room.ru.hasOwnProperty('nf') && room.ru.nf > 0 && !roomData.og) {
						new DaNiaoNoticePanel().open()
					}
				} else {
					AppAlert.show('房间数据加载失败')
					close()
				}
			}) 
		}
		
		protected function onJoinRoomHandler(event:ApiEvent):void
		{
			// 正在恢复房间数据
			trace('正在恢复房间数据')
			Api.getInstane().queryRoomStatus(function (response:Object):void {
				if (response.code == 0) {
					trace('恢复成功')
					needRiffleCard = true
					roomData = response.data
				} else {
					trace('恢复失败')
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
			} else {
				zhunbeiButton.visible = true
				zhunbeiButton2.visible = false
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
		
		
		
		//------------------------------------------------------------------------------------------------------------------------
		//
		//	失效出听的牌
		//
		//------------------------------------------------------------------------------------------------------------------------
		
		private var invalidateMyHandCardUIsFlag:Boolean = false; // 失效手里的牌
		
		private function invalidateMyHandCardUIs():void
		{
			if (!invalidateMyHandCardUIsFlag)
			{
				invalidateMyHandCardUIsFlag = true;
				callLater(validateMyHandCardUIs)
			}
		}
		
		private function validateMyHandCardUIs():void
		{
			if (invalidateMyHandCardUIsFlag)
			{
				invalidateMyHandCardUIsFlag = false;
				updateMyHandCardUIs();
			}
		}
		
		/**
		 *  更新我的牌视图
		 */		
		private function updateMyHandCardUIs():void {
			if (myUser) {
				if (draggingCardUI) {
					draggingCardUI.stopDrag()
					this.removeEventListener(MouseEvent.MOUSE_UP, this_mouseUpHandler)
					this.removeEventListener(MouseEvent.MOUSE_MOVE, this_mouseMoveHandler)
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
		
		
		//------------------------------------------------------------------------------------------------------------------------
		//
		//	失效出听的牌
		//
		//------------------------------------------------------------------------------------------------------------------------
		
		private var invalidateMyHandCardUIsCanOutTingFlag:Boolean = false; // 出听牌失效
		private var outTingData:Array
		private var needRecheck:Boolean = false
		
		private function invalidateMyHandCardUIsCanOutTing(recheck:Boolean = false):void
		{
			needRecheck = recheck
			if (!invalidateMyHandCardUIsCanOutTingFlag)
			{
				invalidateMyHandCardUIsCanOutTingFlag = true;
				callLater(validateMyHandCardUIsCanOutTing)
			}
		}
		
		private function validateMyHandCardUIsCanOutTing():void
		{
			if (invalidateMyHandCardUIsCanOutTingFlag)
			{
				invalidateMyHandCardUIsCanOutTingFlag = false;
				updateMyHandCardUIsCanOutTing();
			}
		}
		
		private function updateMyHandCardUIsCanOutTing():void {
			if (myUser) {
				if (needRecheck) {
					outTingData = CardUtil.getInstane().canOutCardTing(myUser.groupCards, myUser.handCards, this.roomrule.hx)
				}
				if (outTingData) {
					for each(var item:Object in outTingData) {
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
		
		//------------------------------------------------------------------------------------------------------------------------
		//
		//	失效听的牌
		//
		//------------------------------------------------------------------------------------------------------------------------
		
		//		private var invalidateMyHandCardUIsCanTingFlag:Boolean = false; // 听牌失效
		//		
		//		private function invalidateMyHandCardUIsCanTing():void
		//		{
		//			if (!invalidateMyHandCardUIsCanTingFlag)
		//			{
		//				invalidateMyHandCardUIsCanTingFlag = true;
		//				callLater(validateMyHandCardUIsCanTing)
		//			}
		//		}
		//		
		//		private function validateMyHandCardUIsCanTing():void
		//		{
		//			if (invalidateMyHandCardUIsCanTingFlag)
		//			{
		//				invalidateMyHandCardUIsCanTingFlag = false;
		//				updateMyHandCardUIsCanTing();
		//			}
		//		}
		//		
		//		private function updateMyHandCardUIsCanTing():void {
		//			if (myUser) {
		//				tingCardsView.tingCards = CardUtil.getInstane().canTing(myUser.groupCards, myUser.handCards, this.roomrule.hx)
		//			}
		//		}
		
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
				tingCardsView.tingCards = draggingCardUI.tingCards
				this.addEventListener(MouseEvent.MOUSE_UP, this_mouseUpHandler)
				this.addEventListener(MouseEvent.MOUSE_MOVE, this_mouseMoveHandler)
			}
		}
		
		protected function this_mouseMoveHandler(event:MouseEvent):void
		{
			event.updateAfterEvent()
		}
		
		protected function this_mouseUpHandler(event:MouseEvent):void {
			this.removeEventListener(MouseEvent.MOUSE_UP, this_mouseUpHandler)
			this.removeEventListener(MouseEvent.MOUSE_MOVE, this_mouseMoveHandler)
			if (draggingCardUI) {
				draggingCardUI.stopDrag()
				if (myActionUser && myActionUser.nd) {
					// 在需要我出牌的情况下
					if (this.mouseY <= height / 2) { 
						myActionUser.nd.dt = draggingCardUI.card
						myActionUser.nd.ac = 1
						var action:Object = { name: Actions.NewCard, data: myActionUser  }
						Api.getInstane().sendAction(action)
						draggingCardUI.visible = false
						Audio.getInstane().stopTimeout()
						meNewCard(draggingCardUI.card)
					} else {
						riffleCard()
						invalidateMyHandCardUIs()
						invalidateMyHandCardUIsCanOutTing()
					}
				} else {
					// 如果不是我出牌的 整理牌
					riffleCard()
					invalidateMyHandCardUIs()
				}
			}
		}
		
		private function riffleCard():void {
			// 整理牌
			ei = getMyHandCardsIndex(this.mouseX)
			if (si >= 0 && si != ei) {
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
						} else if (ei >= 0) {
							myHandCards[si].splice(index, 1) // 删除这个元素
							myHandCards.push([draggingCardUI.card])
						} else {
							myHandCards[si].splice(index, 1) // 删除这个元素
							myHandCards.unshift([draggingCardUI.card])
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
				case Notifications.onAskExit: 
				{
					if (notification.data.an != AppData.getInstane().user.username) {
						AppAlert.show(notification.data.an + '玩家申请退出，是否同意退出', '',Alert.OK|Alert.CANCEL, function (e:UIEvent):void {
							if (e.detail == Alert.OK) {
								var action:Object = { name: Actions.Dae, data: 1  }
								Api.getInstane().sendAction(action)
							} else {
								var action2:Object = { name: Actions.Dae, data: 0  }
								Api.getInstane().sendAction(action2)
							}
						})
					}
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
					tingCardsView.tingCards = null
					Audio.getInstane().playHandle('hu')
					roomData = notification.data
					trace("roomView一把玩家赢牌1:",JSON.stringify(roomData));
					var winView1:WinView = new WinView();
					winView1.data = roomData;
					PopUpManager.centerPopUp(PopUpManager.addPopUp(winView1,null,true,false));
					break
				}
				case Notifications.onRoundEnd://荒庄
				{
					tingCardsView.tingCards = null
					Audio.getInstane().playHandle('hz')
					roomData = notification.data
					trace("roomView一把荒庄1:",JSON.stringify(roomData));
					var winView2:WinView = new WinView();
					winView2.data = roomData;
					PopUpManager.centerPopUp(PopUpManager.addPopUp(winView2,null,true,false));
					break
				}
				case Notifications.onGameOver: 
				{
					tingCardsView.tingCards = null
					roomData = notification.data
					if (roomData.hn) {
						Audio.getInstane().playHandle('hu')
					}
					trace("roomView一局游戏结束:",JSON.stringify(roomData));
					var endView:EndResultView = new EndResultView();
					endView.data = roomData;
					endView.ruleData = this.roomrule;
					PopUpManager.centerPopUp(PopUpManager.addPopUp(endView,null,true,false,0,0.8));
					var winView3:WinView = new WinView();
					winView3.data = roomData;
					winView3.allOver = true;
					PopUpManager.centerPopUp(PopUpManager.addPopUp(winView3,null,true,false));
					close()
					break
				}
				case Notifications.onNewCard: 
				{
					roomData = notification.data
					if (roomData.io && roomData.pc > 0 && roomData.pn == AppData.getInstane().user.username) {
						// // 如果是自己出的牌 就不播报了
					} else {
						Audio.getInstane().playCard(roomData.pc)
					}
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
				//				mePeng(myActionUser.pd.dt)
			}
		}
		
		protected function canChiButton_clickHandler(event:MouseEvent):void
		{
			if (myActionUser) {
				if (myActionUser.cd.dt.length == 1) {
					undoActionUser()
					myActionUser.cd.dt = [myActionUser.cd.dt[0]]
					myActionUser.cd.ac = 1
					var action:Object = { name: Actions.Chi, data: myActionUser}
					Api.getInstane().sendAction(action)
				} else {
					ChiSelectView.getInstane().addEventListener(SelectEvent.SELECTED, chi_selectHandler)
					ChiSelectView.getInstane().y = 50
					ChiSelectView.getInstane().width = width
					ChiSelectView.getInstane().open(myActionUser.cd.dt)
				}
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
			}
		}
		
		protected function cancelButton_clickHandler(event:MouseEvent):void
		{
			if (ChiSelectView.getInstane().isPopUp) {
				ChiSelectView.getInstane().close()
			}
			canHuButton.visible = canPengButton.visible = canChiButton.visible = cancelButton.visible = false
			Audio.getInstane().playHandle('pass')
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
			Api.getInstane().removeEventListener(ApiEvent.JOIN_ROOM, onJoinRoomHandler)
			Api.getInstane().leaveRoom(function (response:Object):void {})
			hideAllUI()
			Audio.getInstane().stopTimeout()
			
			if (this.roomrule.id > 0) {
				MainView.getInstane().popView(GroupView)
			} else {
				Api.getInstane().leaveGroup()
				MainView.getInstane().popView(HomeView)
			}
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
				Audio.getInstane().playCard(card)
				roomData.pn = myUser.username
				roomData.pc = card
				roomData.io = true
				roomData.aus = []
				CardUtil.getInstane().deleteCard(myUser.handCards, card)
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
		
		/**
		 * 显示设置选项界面
		 */
		protected function showSettingPanelBtnHandler(event:MouseEvent):void
		{
			var roomSettingPanel:RoomSettingPanel = new RoomSettingPanel();
			PopUpManager.centerPopUp(PopUpManager.addPopUp(new RoomSettingPanel(),null,true,true));
		}
		
		protected function fixRoomHandler(event:AppManagerEvent):void
		{
			Api.getInstane().reconnect()
		}
		
		protected function forceLeaveHandler(event:AppManagerEvent):void
		{
			close();
		}
		
	}
} 