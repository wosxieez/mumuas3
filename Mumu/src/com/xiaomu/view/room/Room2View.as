package com.xiaomu.view.room
{
	import com.xiaomu.component.AppAlert;
	import com.xiaomu.component.AppAlertSmall;
	import com.xiaomu.component.ImageButton;
	import com.xiaomu.component.PdkCardUI;
	import com.xiaomu.component.Recording;
	import com.xiaomu.event.ApiEvent;
	import com.xiaomu.event.AppManagerEvent;
	import com.xiaomu.manager.AppManager;
	import com.xiaomu.util.Actions;
	import com.xiaomu.util.Api;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.Audio;
	import com.xiaomu.util.CardUtil;
	import com.xiaomu.util.Notifications;
	import com.xiaomu.util.PdkCardType;
	import com.xiaomu.util.PdkCardUtil;
	import com.xiaomu.util.Size;
	import com.xiaomu.view.MainView;
	import com.xiaomu.view.group.GroupView;
	import com.xiaomu.view.home.HomeView;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import coco.component.Alert;
	import coco.component.Image;
	import coco.component.Label;
	import coco.core.UIComponent;
	import coco.event.TalkEvent;
	import coco.event.UIEvent;
	import coco.manager.PopUpManager;
	import coco.manager.TalkManager;
	
	public class Room2View extends UIComponent
	{
		public function Room2View()
		{
			super();
			AppManager.getInstance().addEventListener(AppManagerEvent.CHANGE_ROOM_TABLE_IMG,changeRoomTableImgHandler);
			//			AppManager.getInstance().addEventListener(AppManagerEvent.LEAVE_GROUP_ROOM,leaveGroupRoomHandler);
			//			AppManager.getInstance().addEventListener(AppManagerEvent.FIX_ROOM,fixRoomHandler);
			AppManager.getInstance().addEventListener(AppManagerEvent.FORCE_LEAVE,forceLeaveHandler);
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, this_mouseDownHandler)
			this.addEventListener(MouseEvent.MOUSE_UP, this_mouseUpHandler)
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
		private var roomnameDisplay:Label
		private var preUserHead:RoomUserHead
		private var myUserHead:RoomUserHead
		private var nextUserHead:RoomUserHead
		private var cardLayer: UIComponent
		private var iconLayer:UIComponent
		private var myUser:Object
		private var preUser:Object
		private var nextUser:Object
		private var myHandCardUIs:Array = []
		private var myGroupCardUIs:Array = []
		private var newCardUIs:Array = []
		private var myPassCardUIs:Array = []
		private var preGroupCardUIs:Array = []
		private var prePassCardUIs:Array = []
		private var nextGroupCardUIs:Array = []
		private var nextPassCardUIs:Array = []
		private var zhunbeiButton:ImageButton
		private var zhunbeiButton2:ImageButton
		private var canOutButton:ImageButton
		private var canChiButton:ImageButton
		private var cancelButton:ImageButton
		private var chatButton:ImageButton
		private var talkButton:ImageButton
		private var goback:ImageButton
		private var refreshButton:ImageButton
		private var myActionUser:Object
		private var preActionUser:Object
		private var nextActionUser:Object
		
		private var showSettingPanelBtn:ImageButton;
		private var showRuleNamePanelBtn:ImageButton;
		
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
			
			// 卡牌层
			cardLayer = new UIComponent()
			addChild(cardLayer)
			
			// 图标层
			iconLayer = new UIComponent()
			addChild(iconLayer)
			
			canChiButton = new ImageButton()
			canChiButton.upImageSource = 'assets/pdk/btn_cp_up.png'
			canChiButton.downImageSource = 'assets/pdk/btn_cp_down.png'
			canChiButton.width = 148
			canChiButton.height = 74
			canChiButton.visible = false
			canChiButton.addEventListener(MouseEvent.CLICK, canChiButton_clickHandler)
			iconLayer.addChild(canChiButton)
			
			canOutButton = new ImageButton()
			canOutButton.upImageSource = 'assets/pdk/btn_co_up.png'
			canOutButton.downImageSource = 'assets/pdk/btn_co_down.png'
			canOutButton.width = 148
			canOutButton.height = 74
			canOutButton.visible = false
			canOutButton.addEventListener(MouseEvent.CLICK, canOutButton_clickHandler)
			iconLayer.addChild(canOutButton)
			
			cancelButton = new ImageButton()
			cancelButton.upImageSource = 'assets/pdk/btn_bp_up.png'
			cancelButton.downImageSource = 'assets/pdk/btn_bp_down.png'
			cancelButton.width = 148
			cancelButton.height = 74
			cancelButton.visible = false
			cancelButton.addEventListener(MouseEvent.CLICK, cancelButton_clickHandler)
			iconLayer.addChild(cancelButton)
			
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
			chatButton.downImageSource = 'assets/room/btn_chat_press.png'
			chatButton.addEventListener(MouseEvent.CLICK, chatButton_clickHandler)
			iconLayer.addChild(chatButton)
			
			talkButton = new ImageButton()
			talkButton.width = 60
			talkButton.height = 60
			talkButton.upImageSource = 'assets/room/btn_mic.png'
			talkButton.downImageSource = 'assets/room/btn_mic_press.png'
			talkButton.addEventListener(MouseEvent.MOUSE_OUT, talkButton_outHandler)
			talkButton.addEventListener(MouseEvent.MOUSE_DOWN, talkButton_downHandler)
			talkButton.addEventListener(MouseEvent.MOUSE_UP, talkButton_upkHandler)
			iconLayer.addChild(talkButton)
			
			///设置按钮--点击
			showSettingPanelBtn = new ImageButton();
			showSettingPanelBtn.upImageSource='assets/room/btn_zk_normal.png';
			showSettingPanelBtn.downImageSource='assets/room/btn_zk_press.png';
			showSettingPanelBtn.width = 69;
			showSettingPanelBtn.height = 68;
			showSettingPanelBtn.addEventListener(MouseEvent.CLICK,showSettingPanelBtnHandler);
			addChild(showSettingPanelBtn);
			
			//显示玩法按钮
			showRuleNamePanelBtn = new ImageButton();
			showRuleNamePanelBtn.upImageSource='assets/room/btn_wanfa_up.png';
			showRuleNamePanelBtn.downImageSource='assets/room/btn_wanfa_down.png';
			showRuleNamePanelBtn.width = 69;
			showRuleNamePanelBtn.height = 68;
			showRuleNamePanelBtn.addEventListener(MouseEvent.CLICK,showRuleNamePanelBtnHandler);
			addChild(showRuleNamePanelBtn);
			
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
		
		protected function canOutButton_clickHandler(event:MouseEvent):void
		{
			event.preventDefault()
			event.stopImmediatePropagation()
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
				preUserHead.thx = preUser.thx
				preUserHead.huxi = CardUtil.getInstane().getHuXi(preUser.groupCards)
				preActionUser = getActionUser(preUser.username)
			}
			
			if (myUser) {
				myUserHead.visible = true
				refreshButton.visible = true
				myUserHead.username = myUser.username
				myUserHead.isZhuang = myUserHead.username == roomData.zn
				myUserHead.thx = myUser.thx
				myUserHead.huxi = CardUtil.getInstane().getHuXi(myUser.groupCards)
				myActionUser = getActionUser(myUser.username)
			}
			
			if (nextUser) {
				nextUserHead.visible = true
				nextUserHead.username = nextUser.username
				nextUserHead.isZhuang = nextUserHead.username == roomData.zn
				nextUserHead.huxi = CardUtil.getInstane().getHuXi(nextUser.groupCards)
				nextUserHead.thx = nextUser.thx
				nextActionUser = getActionUser(nextUser.username)
			} 
			
			if (roomData.ig) {
				if (myUser) {
					invalidateMyHandCardUIs()
					updateMyGroupCardUIs()
				}
				
				if (preUser) {
					callLater(updatePreHandCardUIs)
				}
				if (nextUser) {
					callLater(updateNextGroupCardUIs)
				} 
				
				updateNewCard()
				
				if (myActionUser) {
					if (myActionUser.nd) {
						myUserHead.isFocus = true
						canOutButton.visible = canChiButton.visible = true
					} else if (myActionUser.cd) {
						myUserHead.isFocus = true
						canOutButton.visible = canChiButton.visible = cancelButton.visible = true
					}
					invalidateDisplayList()
				}
				
				if (nextActionUser) {
					if (nextActionUser.nd || nextActionUser.cd) {
						nextUserHead.isFocus = true
					}
				}
				
				if (preActionUser) {
					if (preActionUser.nd || preActionUser.cd) {
						preUserHead.isFocus = true
					}
				}
				
				if (canChiButton.visible) {
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
			
			preUserHead.x = 30
			preUserHead.y = 30
			
			myUserHead.x = 30
			myUserHead.y = height - myUserHead.height - 30
			
			nextUserHead.x = width - nextUserHead.width - 30
			nextUserHead.y = 30
			
			chatButton.x = width - 10 - chatButton.width
			chatButton.y = height / 2 + cancelButton.height + 10
			
			talkButton.x = chatButton.x
			talkButton.y = chatButton.y + chatButton.height + 10
			
			refreshButton.x = talkButton.x
			refreshButton.y = talkButton.y + talkButton.height + 10
			
			if (cancelButton.visible) {
				canOutButton.x = (width - cancelButton.width - canChiButton.width - 30 - canOutButton.width) / 2
				canChiButton.x = canOutButton.x + canOutButton.width + 15
				cancelButton.x = canChiButton.x + canChiButton.width + 15
				canOutButton.y = canChiButton.y = cancelButton.y = height - 270
			} else {
				canOutButton.x = (width - canChiButton.width - 15 - canOutButton.width) / 2
				canChiButton.x = canOutButton.x + canOutButton.width + 15
				canOutButton.y = canChiButton.y = height - 270
			}
			
			zhunbeiButton.x = (width - zhunbeiButton.width) / 2
			zhunbeiButton.y = (height - zhunbeiButton.height) / 2
			zhunbeiButton2.x = (width - zhunbeiButton2.width) / 2
			zhunbeiButton2.y = (height - zhunbeiButton2.height) / 2
			
			goback.x = width - goback.width - 200
			goback.y = 10
			
			showRuleNamePanelBtn.x = width-200;
			showRuleNamePanelBtn.y = 10;
		}
		
		override protected function drawSkin():void {
			iconLayer.graphics.clear()
			iconLayer.graphics.beginFill(0x000000, 0.2)
			iconLayer.graphics.drawRect(mouseDownPoint.x, mouseDownPoint.y, mouseUpPoint.x - mouseDownPoint.x, mouseUpPoint.y - mouseDownPoint.y)
			iconLayer.graphics.endFill()
			var minx:Number = Math.min(mouseDownPoint.x, mouseUpPoint.x)
			var miny:Number = Math.min(mouseDownPoint.y, mouseUpPoint.y)
			var maxx:Number = Math.max(mouseDownPoint.x, mouseUpPoint.x)
			var maxy:Number = Math.max(mouseDownPoint.y, mouseUpPoint.y)
			if ((maxx - minx) > 20) {
				for each(var cardUI:PdkCardUI in myHandCardUIs) {
					if (minx <= cardUI.x + 60 && cardUI.x <= maxx &&
						miny <= cardUI.y + cardUI.height && cardUI.y <= maxy) {
						cardUI.selected = true
					} else {
						cardUI.selected = false
					}
				}
			}
		}
		
		public function init(room:Object): void {
			this.roomname = room.rn
			this.roomrule = room.ru
			Api.getInstane().addEventListener(ApiEvent.ON_ROOM, onNotificationHandler)
			Api.getInstane().addEventListener(ApiEvent.JOIN_ROOM, onJoinRoomHandler)
			Api.getInstane().queryRoomStatus(function (response:Object):void {
				if (response.code == 0) {
					roomData = response.data
					needRiffleCard = true
					if (room.ru && room.ru.id > 0 && room.ru.hasOwnProperty('nf') && room.ru.nf > 0 && !roomData.og) {
					} else {
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
			var cardUI:PdkCardUI
			for each(cardUI in myHandCardUIs) {
				cardUI.visible = false
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
			cancelButton.visible = false
			canOutButton.visible = false
			canChiButton.visible = false
			
			PopUpManager.removePopUp(ChiSelectView.getInstane())
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
			if (roomData.pc) {
				var oldNewCardUIs:Array = []
				for each(var cardUI: PdkCardUI in newCardUIs) {
					cardUI.visible = false
					oldNewCardUIs.push(cardUI)
				}
				newCardUIs = []
				var cardWidth:Number = Size.MIDDLE_CARD_WIDTH
				var cardHeight:Number = Size.MIDDLE_CARD_HEIGHT
				var horizontalGap:Number = 60
				var verticalGap:Number = cardHeight * 3 / 4
				var newCardUI:PdkCardUI
				var startX:Number = (width - horizontalGap * (roomData.pc.length - 1) - cardWidth) / 2
				roomData.pc.sort(function (a:int, b:int):Number {
					if (a%100 < b%100) return -1
					else return 1
				})
				for (var i:int = 0; i < roomData.pc.length; i++) {
					newCardUI = oldNewCardUIs.pop()
					if (!newCardUI) {
						newCardUI = new PdkCardUI()
						cardLayer.addChild(newCardUI)
					}
					newCardUI.visible = true
					newCardUI.width = cardWidth
					newCardUI.height = cardHeight
					newCardUI.x = startX + i * horizontalGap
					newCardUI.y = (height - cardHeight) / 2
					newCardUI.card = roomData.pc[i]
					cardLayer.setChildIndex(newCardUI, cardLayer.numChildren - 1)
					myGroupCardUIs.push(newCardUI)
				}
			}
		}
		
		private var myHandCards:Array = null
		private var myHandCardWidth:Number = 0
		private var myHandCardStartX:Number = 0
		private var myHandCardHorizontalGap:Number = 0
		
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
				var cardsChanged:Boolean = false
				if (!myHandCards) {
					myHandCards = PdkCardUtil.getInstane().riffle(myUser.handCards)
					cardsChanged = true
				} else {
					// myHandlers 已经存在了 匹配 增减就可以了
					var oldCards:Array = []
					var newCards:Array = []
					for each(var newCard:int in myUser.handCards) {
						newCards.push(newCard)
					}
					for each(var oldCard:int in myHandCards) {
						oldCards.push(oldCard)
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
							if (myHandCards[yi] == card) {
								myHandCards.splice(yi, 1)
								return 
							}
						}
					}
					
					if (oldCards && oldCards.length > 0) {
						for each(var oldCard2:int in oldCards) {
							deleteMyHandCard(oldCard2)
						}
						cardsChanged = true
					}
				}
				
				if (!cardsChanged) {
					for each(cardUI in myHandCardUIs) {
						cardUI.visible = true
					}
					return
				}
				
				// 回收CardUIs
				var oldMyHandCardUIs:Array = []
				for each(var cardUI: PdkCardUI in myHandCardUIs) {
					cardUI.visible = false
					cardUI.selected = false
					oldMyHandCardUIs.push(cardUI)
				}
				myHandCardUIs = []
				
				myHandCardWidth = Size.PDK_MIDDLE_CARD_WIDTH
				var cardHeight:Number = Size.PDK_MIDDLE_CARD_HEIGHT
				myHandCardHorizontalGap = 60
				var verticalGap:Number = cardHeight * 3 / 4
				var newCardUI:PdkCardUI
				myHandCardStartX = (width - (myHandCards.length - 1) * myHandCardHorizontalGap - myHandCardWidth) / 2
				for (var i:int = 0; i < myHandCards.length; i++) {
					newCardUI = oldMyHandCardUIs.pop()
					if (!newCardUI) {
						newCardUI = new PdkCardUI()
						newCardUI.addEventListener(MouseEvent.CLICK, cardUI_clickHandler)
						cardLayer.addChild(newCardUI)
					}
					newCardUI.visible = true
					newCardUI.width = myHandCardWidth
					newCardUI.height = cardHeight
					newCardUI.x = myHandCardStartX + i * myHandCardHorizontalGap
					newCardUI.y = height - newCardUI.height
					newCardUI.card = myHandCards[i]
					cardLayer.setChildIndex(newCardUI, cardLayer.numChildren - 1)
					myHandCardUIs.push(newCardUI)
				}
			}
		}
		
		/**
		 *  更新我的组合牌视图
		 */		
		private function updateMyGroupCardUIs():void {
			if (myUser) {
				var riffleCards:Array = this.myUser.groupCards
				var oldMyGroupCardUIs:Array = []
				for each(var cardUI: PdkCardUI in myGroupCardUIs) {
					cardUI.visible = false
					oldMyGroupCardUIs.push(cardUI)
				}
				myGroupCardUIs = []
				var cardWidth:Number = Size.SMALL_CARD_WIDTH
				var cardHeight:Number = Size.SMALL_CARD_HEIGHT
				var horizontalGap:Number = 1
				var verticalGap:Number = cardHeight * 3 / 4
				var newCardUI:PdkCardUI
				var startX:Number = width / 2 - cardWidth * 4
				for (var i:int = 0; i < riffleCards.length; i++) {
					var group:Object = riffleCards[i]
					var groupCards:Array = group.cards
					var cardsLength:int = groupCards.length
					for (var j:int = 0; j < cardsLength; j++) {
						newCardUI = oldMyGroupCardUIs.pop()
						if (!newCardUI) {
							newCardUI = new PdkCardUI()
							cardLayer.addChild(newCardUI)
						}
						newCardUI.visible = true
						newCardUI.width = cardWidth
						newCardUI.height = cardHeight
						newCardUI.x = startX + i * (newCardUI.width + horizontalGap)
						newCardUI.y = height / 2 - newCardUI.height - j * verticalGap - 100
						newCardUI.card = groupCards[j]
						cardLayer.setChildIndex(newCardUI, 0)
						myGroupCardUIs.push(newCardUI)
					}
				}
			}
		}
		
		/**
		 *  更新上家的牌视图
		 */		
		private function updatePreHandCardUIs():void {
			if (preUser) {
				var riffleCards:Array = this.preUser.handCards
				var oldPreGroupCardUIs:Array = []
				for each(var cardUI: PdkCardUI in preGroupCardUIs) {
					cardUI.visible = false
					oldPreGroupCardUIs.push(cardUI)
				}
				preGroupCardUIs = []
				var cardWidth:Number = Size.SMALL_CARD_WIDTH
				var cardHeight:Number = Size.SMALL_CARD_HEIGHT
				var horizontalGap:Number = 5
				var newCardUI:PdkCardUI
				var startX:Number = 120
				for (var i:int = 0; i < riffleCards.length; i++) {
					newCardUI = oldPreGroupCardUIs.pop()
					if (!newCardUI) {
						newCardUI = new PdkCardUI()
						cardLayer.addChild(newCardUI)
					}
					newCardUI.visible = true
					newCardUI.width = cardWidth
					newCardUI.height = cardHeight
					newCardUI.isReverse = true
					newCardUI.x = startX
					newCardUI.y = 185 - cardHeight - i * horizontalGap
					newCardUI.card = riffleCards[i]
					cardLayer.setChildIndex(newCardUI, 0)
					preGroupCardUIs.push(newCardUI)
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
				for each(var cardUI: PdkCardUI in nextGroupCardUIs) {
					cardUI.visible = false
					oldNextGroupCardUIs.push(cardUI)
				}
				nextGroupCardUIs = []
				var cardWidth:Number = Size.SMALL_CARD_WIDTH
				var cardHeight:Number = Size.SMALL_CARD_HEIGHT
				var horizontalGap:Number = 1
				var verticalGap:Number = Size.SMALL_CARD_HEIGHT * Size.GAP_RADIO
				var newCardUI:PdkCardUI
				var startX:Number = width - cardWidth - 120
				for (var i:int = 0; i < riffleCards.length; i++) {
					var group:Object = riffleCards[i]
					var groupCards:Array = group.cards
					var cardsLength:int = groupCards.length
					for (var j:int = 0; j < cardsLength; j++) {
						newCardUI = oldNextGroupCardUIs.pop()
						if (!newCardUI) {
							newCardUI = new PdkCardUI()
							cardLayer.addChild(newCardUI)
						}
						newCardUI.visible = true
						newCardUI.width = cardWidth
						newCardUI.height = cardHeight
						newCardUI.x = startX - i * (newCardUI.width + horizontalGap)
						newCardUI.y = 185 - cardHeight - newCardUI.height - j * verticalGap
						newCardUI.card = groupCards[j]
						cardLayer.setChildIndex(newCardUI, 0)
						nextGroupCardUIs.push(newCardUI)
					}
				}
				
			}
		}
		
		protected function cardUI_clickHandler(event:MouseEvent):void
		{
			var cardUI:PdkCardUI = event.currentTarget as PdkCardUI
			if (cardUI) {
				cardUI.selected = !cardUI.selected
			}
		}
		
		protected function onNotificationHandler(event:ApiEvent):void
		{
			var notification: Object = event.data
			switch(notification.name)
			{
				case Notifications.onRoomMessage: 
				{
					var message:Object = notification.data
					if (message.sn != AppData.getInstane().user.username) {
						if (message.at == 0) {
							// 模版消息
							Audio.getInstane().playChat(message.data)
						} else if (message.at == 1) {
							// 对讲消息
							TalkManager.getInstane().play(message.data)
						}
					}
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
				{
					roomData = notification.data
					break
				}
				case Notifications.onWin:///赢家界面 //一把
				{
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
					roomData = notification.data
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
					var validCard:Object = PdkCardUtil.getInstane().isValidCards(roomData.pc)
					if (validCard) {
						switch(validCard.type)
						{
							case PdkCardType.ONE:
							{
								Audio.getInstane().playPdkCard(validCard.card)
								break;
							}
							case PdkCardType.TWO_ONE:
							{
								Audio.getInstane().playPdkCard('dui' + validCard.card)
								break;
							}
							case PdkCardType.TWO_TWO:
							case PdkCardType.TWO_THREE:
							case PdkCardType.TWO_FOUR:
							case PdkCardType.TWO_FIVE:
							case PdkCardType.TWO_SIX:
							case PdkCardType.TWO_SEVEN:
							case PdkCardType.TWO_EIGHT:
							{
								Audio.getInstane().playPdkCard('duilian')
								break;
							}
							case PdkCardType.THREE_ZERO:
							{
								Audio.getInstane().playPdkCard('three' + validCard.card)
								break;
							}
							case PdkCardType.THREE_ONE:
							{
								Audio.getInstane().playPdkCard('three_with_one')
								break;
							}
							case PdkCardType.THREE_TWO:
							{
								Audio.getInstane().playPdkCard('three_with_two')
								break;
							}
							case PdkCardType.THREE_DUI:
							{
								Audio.getInstane().playPdkCard('three_with_dui')
								break;
							}
							case PdkCardType.SHUN_FIVE:
							case PdkCardType.SHUN_SIX:
							case PdkCardType.SHUN_SEVEN:
							case PdkCardType.SHUN_EIGHT:
							case PdkCardType.SHUN_NINE:
							case PdkCardType.SHUN_TEN:
							case PdkCardType.SHUN_ELEVEN:
							case PdkCardType.SHUN_TWELVE:
							{
								Audio.getInstane().playPdkCard('shunzi')
								break;
							}
							case PdkCardType.FEIJI_TWO:
							case PdkCardType.FEIJI_THREE:
							case PdkCardType.FEIJI_FOUR:
							case PdkCardType.FEIJI_FIVE:
							{
								Audio.getInstane().playPdkCard('feiji')
								break;
							}
							case PdkCardType.BOMB:
							{
								Audio.getInstane().playPdkCard('bomb')
								break;
							}
							default:
							{
								break;
							}
						}
					}
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
		
		protected function canChiButton_clickHandler(event:MouseEvent):void
		{
			if (myActionUser) {
				var selectedCards:Array = []
				for each(var cardUI:PdkCardUI in myHandCardUIs) {
					if (cardUI.selected) {
						selectedCards.push(cardUI.card)
					}
				}
				if (myActionUser.nd) { // 出牌
					if (PdkCardUtil.getInstane().isValidCards(selectedCards)) {
						myActionUser.nd.dt = selectedCards.sort()
						myActionUser.nd.ac = 1
						var action:Object = { name: Actions.NewCard, data: myActionUser}
						Api.getInstane().sendAction(action)
					} else {
						AppAlertSmall.show('出牌不符合规则')
					}
				} else if (myActionUser.cd) { 
					// 吃牌需要看符合规则不
					var outCards:Object = PdkCardUtil.getInstane().isValidCards(selectedCards)
					if (outCards) {
						var curCards:Object = PdkCardUtil.getInstane().isValidCards(roomData.pc)
						if  (curCards.type != PdkCardType.BOMB) {
							// 当前牌不是炸弹 那么出的牌是同类型大的牌 或者是炸弹 就可以
							if ((outCards.type == curCards.type && outCards.card > curCards.card) || outCards.type == PdkCardType.BOMB) {
								myActionUser.cd.dt = selectedCards.sort()
								myActionUser.cd.ac = 1
								var action2:Object = { name: Actions.Chi, data: myActionUser}
								Api.getInstane().sendAction(action2)		
							} else {
								AppAlertSmall.show('出牌不符合规则')
							}
						} else {
							// 当前牌是炸弹 那么必须是比他大的炸弹
							if ((outCards.type == curCards.type && outCards.card > curCards.card)) {
								myActionUser.cd.dt = selectedCards.sort()
								myActionUser.cd.ac = 1
								var action3:Object = { name: Actions.Chi, data: myActionUser}
								Api.getInstane().sendAction(action3)		
							} else {
								AppAlertSmall.show('出牌不符合规则')
							}
						}
					} else {
						AppAlertSmall.show('出牌不符合规则')
					}
				}
			}
		}
		
		protected function cancelButton_clickHandler(event:MouseEvent):void
		{
			canOutButton.visible = canChiButton.visible = cancelButton.visible = false
			Audio.getInstane().playPdkCard('no')
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
			myHandCards = null
			invalidateMyHandCardUIs()
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
		
		
		private var talkTimeID:uint
		private var isTalking:Boolean = false
		
		protected function talkButton_downHandler(event:MouseEvent):void
		{
			if (isTalking) return 
			Recording.getInstance().open()
			Audio.getInstane().pauseBGM()
			clearTimeout(talkTimeID)
			talkTimeID = setTimeout(function ():void {
				isTalking = true
				TalkManager.getInstane().webServer = AppData.getInstane().webUrl
				TalkManager.getInstane().addEventListener(TalkEvent.SUCCESS, talkSuccessHandler)
				TalkManager.getInstane().start()
			}, 500)
		}
		
		protected function talkButton_outHandler(event:MouseEvent):void
		{
			Recording.getInstance().close()
			Audio.getInstane().resumeBGM()
			clearTimeout(talkTimeID)
			if (isTalking) {
				TalkManager.getInstane().cancel()
				isTalking = false
			}
		}
		
		protected function talkButton_upkHandler(event:MouseEvent):void
		{
			Recording.getInstance().close()
			Audio.getInstane().resumeBGM()
			clearTimeout(talkTimeID)
			if (isTalking) {
				TalkManager.getInstane().stop()
				isTalking = false
			}
		}
		
		protected function talkSuccessHandler(event:TalkEvent):void
		{
			Api.getInstane().sendRoomMessage({at: 1, sn: AppData.getInstane().user.username, data: event.data}, 
				function (response):void {
				})
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
		
		private var rulePanel:RulePanelOnRoom;
		/**
		 * 显示当前玩法小弹窗
		 */
		protected function showRuleNamePanelBtnHandler(event:MouseEvent):void
		{
			if(!rulePanel){
				rulePanel = new RulePanelOnRoom();
			}
			//			trace("roomrule:",JSON.stringify(roomrule));
			var tempRoomRule:Object = {"rulename":"金币休闲场","nf":0,"fd":200,"xf":10,"hx":15,"cc":2}
			rulePanel.data = roomrule.id!=0?roomrule:tempRoomRule;
			rulePanel.x =-rulePanel.width/2+showRuleNamePanelBtn.width/2;
			rulePanel.y = showRuleNamePanelBtn.height;
			if(!rulePanel.isPopUp){
				PopUpManager.addPopUp(rulePanel,showRuleNamePanelBtn,true,true,0,0);
			}else{
				PopUpManager.removePopUp(rulePanel);
			}
		}
		
		private var mouseDownPoint:Point = new Point(0, 0)
		private var mouseUpPoint:Point = new Point(0, 0)
		
		protected function this_mouseDownHandler(event:MouseEvent):void
		{
			mouseDownPoint.x = this.mouseX 
			mouseDownPoint.y = this.mouseY
			trace('mousedown')
			this.addEventListener(MouseEvent.MOUSE_MOVE, this_mouseMoveHandler)
		}
		
		protected function this_mouseMoveHandler(event:MouseEvent):void
		{
			mouseUpPoint.x = this.mouseX 
			mouseUpPoint.y = this.mouseY
			invalidateSkin()
			trace('mousemove')
		}
		
		protected function this_mouseUpHandler(event:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.MOUSE_MOVE, this_mouseMoveHandler)
			mouseUpPoint.x = this.mouseX 
			mouseUpPoint.y = this.mouseY
			
			if (mouseDownPoint.equals(mouseUpPoint) && !(event.target is PdkCardUI) && event.target != canChiButton) {
				for each(var cardUI:PdkCardUI in myHandCardUIs) {
					cardUI.selected = false
				}
			}
			
			mouseUpPoint.x = 0
			mouseUpPoint.y = 0
			mouseDownPoint.x = 0
			mouseDownPoint.y = 0
			invalidateSkin()
			
		}
		
	}
} 