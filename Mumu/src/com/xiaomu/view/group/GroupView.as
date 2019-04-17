package com.xiaomu.view.group
{
	import com.xiaomu.component.AppAlert;
	import com.xiaomu.component.AppSmallAlert;
	import com.xiaomu.component.ImageButton;
	import com.xiaomu.component.Loading;
	import com.xiaomu.event.ApiEvent;
	import com.xiaomu.event.AppManagerEvent;
	import com.xiaomu.itemRender.GroupRoomRenderer;
	import com.xiaomu.manager.AppManager;
	import com.xiaomu.util.Api;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	import com.xiaomu.util.Notifications;
	import com.xiaomu.view.MainView;
	import com.xiaomu.view.hall.HallView;
	import com.xiaomu.view.room.RoomView;
	import com.xiaomu.view.userBarView.GoldOrCardShowBar;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Button;
	import coco.component.HGroup;
	import coco.component.HorizontalAlign;
	import coco.component.Image;
	import coco.component.List;
	import coco.component.VerticalAlign;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	import coco.manager.PopUpManager;
	
	
	/**
	 * 群视图---测试
	 */	
	public class GroupView extends UIComponent
	{
		public function GroupView()
		{
			super();
			
			Api.getInstane().addEventListener(ApiEvent.ON_GROUP, onGroupHandler)
			AppManager.getInstance().addEventListener(AppManagerEvent.CHANGE_SELECTED_RULE,changSelectedRuleHandler);
			AppManager.getInstance().addEventListener(AppManagerEvent.UPDATE_MEMBER_INFO_SUCCESS,updateMemberHander);
			AppManager.getInstance().addEventListener(AppManagerEvent.REFRESH_GROUP_DATA,refrshGroupDataHandler);
		}
		
		private var bg:Image
		private var bg1:Image
		private var roomsList:List
		private var goback:ImageButton
		private var refreshButton:ImageButton
		private var userSettingButton:ImageButton
		private var startButton:ImageButton
		private var bottomGroup:HGroup
		private var switchRuleButton:ImageButton;
		private var ruleSettingButton:Button;
		private var createGroupPublic:ImageButton;
		private var createGroupPrivate:ImageButton;
		
		private var roomCardBar : GoldOrCardShowBar;
		private var fenBar:GoldOrCardShowBar;
		
		private var scorehistoryBtn:ImageButton;
		
		private var _roomsData:Array
		
		public function get roomsData():Array
		{
			return _roomsData;
		}
		
		public function set roomsData(value:Array):void
		{
			_roomsData = value;
			invalidateProperties()
		}
		
		private var _isNowGroupHost:Boolean;  ///是不是当前群的群主
		
		public function get isNowGroupHost():Boolean
		{
			return _isNowGroupHost;
		}
		
		public function set isNowGroupHost(value:Boolean):void
		{
			_isNowGroupHost = value;
			invalidateDisplayList();
		}
		
		override protected function createChildren():void {
			super.createChildren()
			
			bg = new Image()
			bg.source = 'assets/group/guild2_bg.png'
			addChild(bg)
			
			roomCardBar = new GoldOrCardShowBar();
			roomCardBar.width = 240;
			roomCardBar.height = 50;
			roomCardBar.iconWidthHeight = [roomCardBar.height,roomCardBar.height];
			roomCardBar.typeSource = 'assets/user/icon_yuanbao_01.png';
			addChild(roomCardBar);
			
			fenBar = new GoldOrCardShowBar();
			fenBar.width = 240;
			fenBar.height = 50;
			fenBar.iconWidthHeight = [fenBar.height,fenBar.height];
			fenBar.typeSource = 'assets/user/zuanshi.png';
			addChild(fenBar);
			
			roomsList = new List()
			roomsList.itemRendererColumnCount = 4
			roomsList.horizontalAlign = HorizontalAlign.JUSTIFY;
			roomsList.itemRendererClass = GroupRoomRenderer
			roomsList.gap = 30;
			roomsList.addEventListener(UIEvent.CHANGE, roomsList_changeHandler)
			roomsList.padding = 10;
			roomsList.paddingTop =100;
			addChild(roomsList)
			
			bg1 = new Image()
			bg1.height = 114
			bg1.source = 'assets/group/guild2_bg2.png'
			addChild(bg1)
			
			addChild(NowSelectedPlayRuleView.getInstance());
			
			addChild(NowJoinGroupInfoView.getInstance());
			
			bottomGroup = new HGroup()
			bottomGroup.verticalAlign = VerticalAlign.MIDDLE
			bottomGroup.horizontalAlign = HorizontalAlign.RIGHT
			bottomGroup.height = 30
			addChild(bottomGroup)
			//			bottomGroup.visible = false;
			
			var addRuleButton:Button = new Button()
			addRuleButton.label = '添加玩法'
			addRuleButton.addEventListener(MouseEvent.CLICK, addRuleButton_clickHandler)
			bottomGroup.addChild(addRuleButton)
			addRuleButton.visible = false;
			
			ruleSettingButton = new Button()
			ruleSettingButton.label = '玩法管理'
			ruleSettingButton.height = 30;
			ruleSettingButton.radius = 5;
			ruleSettingButton.color = 0x845525;
			ruleSettingButton.backgroundColor = 0xeadab0;
			ruleSettingButton.addEventListener(MouseEvent.CLICK, ruleSettingButton_clickHandler)
			bottomGroup.addChild(ruleSettingButton)
			ruleSettingButton.visible= false;
			
			/*switchRuleButton  = new ImageButton()
			switchRuleButton.upImageSource = 'assets/group/btn_guild_floorChoose_n.png';
			switchRuleButton.downImageSource =  'assets/group/btn_guild_floorChoose_p.png';
			switchRuleButton.width = 98;
			switchRuleButton.height = 40;
			switchRuleButton.addEventListener(MouseEvent.CLICK, switchRuleButton_clickHandler)
			bottomGroup.addChild(switchRuleButton)*/
			
			userSettingButton = new ImageButton()///群管理
			userSettingButton.width = 85
			userSettingButton.height = 91
			userSettingButton.upImageSource = 'assets/group/btn_guild2_guildManage_n.png';
			userSettingButton.downImageSource = 'assets/group/btn_guild2_guildManage_p.png';
			userSettingButton.addEventListener(MouseEvent.CLICK, userSettingButton_clickHandler)
			addChild(userSettingButton)
			userSettingButton.visible = false;
			
			refreshButton = new ImageButton()
			refreshButton.width = 85
			refreshButton.height = 91
			refreshButton.upImageSource = 'assets/group/btn_guild2_refresh_n.png';
			refreshButton.downImageSource = 'assets/group/btn_guild2_refresh_p.png';
			refreshButton.addEventListener(MouseEvent.CLICK, refreshButton_clickHandler)
			addChild(refreshButton)
			
			goback= new ImageButton()
			goback.upImageSource = 'assets/group/btn_guild2_return_n.png';
			goback.downImageSource = 'assets/group/btn_guild2_return_p.png';
			goback.x = 20
			goback.y = 10
			goback.width = 85;
			goback.height = 91;
			goback.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
				Api.getInstane().leaveGroup()	
				AppData.getInstane().group = null
				MainView.getInstane().popView(HallView)
			})
			addChild(goback)
			
			startButton = new ImageButton()
			startButton.width = 133
			startButton.height = 133
			startButton.upImageSource = 'assets/group/btn_guild2_quick_n.png';
			startButton.downImageSource = 'assets/group/btn_guild2_quick_p.png';
			startButton.addEventListener(MouseEvent.CLICK, startButton_clickHandler)//快速开始
			addChild(startButton)
			
			createGroupPrivate = new ImageButton();//创建私密
			createGroupPrivate.width = 89
			createGroupPrivate.height = 89
			createGroupPrivate.upImageSource = 'assets/guild/btn_guild2_create_group_n.png';
			createGroupPrivate.downImageSource = 'assets/guild/btn_guild2_create_group_p.png';
			createGroupPrivate.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
				if(!AppData.getInstane().rule){
					AppSmallAlert.show("请先选择玩法");
					return
				}
				if(AppData.getInstane().rule.plz&&fenBar.count<AppData.getInstane().rule.plz){
					AppAlert.show("很遗憾，您的疲劳值不够开始此玩法")
					return
				}
				Loading.getInstance().open() 
				AppData.getInstane().rule.pub = false // 私密房间
				Api.getInstane().createRoom(AppData.getInstane().rule, function (response:Object):void {
					Loading.getInstance().close() 
					if (response.code == 0) {
						RoomView(MainView.getInstane().pushView(RoomView)).init(response.data)
					} else {
						AppAlert.show(JSON.stringify(response.data))
					}
				})
			})
			addChild(createGroupPrivate);
			
			createGroupPublic = new ImageButton();//创建公共
			createGroupPublic.width = 89
			createGroupPublic.height = 89
			createGroupPublic.upImageSource = 'assets/guild/btn_guild2_create_public_n.png';
			createGroupPublic.downImageSource = 'assets/guild/btn_guild2_create_public_p.png';
			createGroupPublic.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
				if(!AppData.getInstane().rule){
					AppSmallAlert.show("请先选择玩法");
					return
				}
				if(AppData.getInstane().rule.plz&&fenBar.count<AppData.getInstane().rule.plz){
					AppAlert.show("很遗憾，您的疲劳值不够开始此玩法")
					return
				}
				
				if (AppData.getInstane().rule) {
					Loading.getInstance().open() 
					AppData.getInstane().rule.pub = true // 公共房间
					Api.getInstane().createRoom(AppData.getInstane().rule, function (response:Object):void {
						Loading.getInstance().close() 
						if (response.code == 0) {
							RoomView(MainView.getInstane().pushView(RoomView)).init(response.data)
						} else {
							AppAlert.show(JSON.stringify(response.data))
						}
					})
				} else {
					AppAlert.show('请选择玩法')
				}
			})
			addChild(createGroupPublic);
			
			scorehistoryBtn = new ImageButton();
			scorehistoryBtn.width = 80
			scorehistoryBtn.height = 80
			scorehistoryBtn.upImageSource = 'assets/group/scorehistory_n.png';
			scorehistoryBtn.downImageSource = 'assets/group/scorehistory_p.png';
			scorehistoryBtn.addEventListener(MouseEvent.CLICK, scorehistoryBtn_clickHandler)
			addChild(scorehistoryBtn)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			if (!roomsData) {
				roomsList.dataProvider = null
				return 
			}
			roomsList.dataProvider = roomsData.filter(function (item:*, index:int, array:Array):Boolean {
				if (item.pub) {
					return true
				} else {
					return false
				}
			})
			
			roomCardBar.count = AppData.getInstane().user.fc?AppData.getInstane().user.fc:"0";
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			bg.width = width
			bg.height = height
			
			bg1.width = width
			bg1.y = height - bg1.height
			
			roomCardBar.x = 150;
			roomCardBar.y = 20;
			roomCardBar.visible = isNowGroupHost;
			
			fenBar.x = isNowGroupHost?roomCardBar.x+roomCardBar.width+60:roomCardBar.x
			fenBar.y = roomCardBar.y;
			
			roomsList.y = roomsList.paddingTop;
			roomsList.height = height - roomsList.y-bg1.height;
			roomsList.width = width
			roomsList.itemRendererHeight = (roomsList.width- roomsList.padding * 2 - roomsList.gap*3) / 4
			
			userSettingButton.x = width - userSettingButton.width - 20
			userSettingButton.y = 10
			
			refreshButton.x = userSettingButton.x - 20 - refreshButton.width
			refreshButton.y  = 10
			
			scorehistoryBtn.x = refreshButton.x - scorehistoryBtn.width - 30;
			scorehistoryBtn.y = refreshButton.y;
			
			startButton.x = width - startButton.width
			startButton.y = height - startButton.height
			
			NowSelectedPlayRuleView.getInstance().x = startButton.x-NowSelectedPlayRuleView.getInstance().width+20;
			NowSelectedPlayRuleView.getInstance().y = height-NowSelectedPlayRuleView.getInstance().height-5;
			
			NowJoinGroupInfoView.getInstance().x = 20;
			NowJoinGroupInfoView.getInstance().y = NowSelectedPlayRuleView.getInstance().y;
			
			createGroupPrivate.x = NowJoinGroupInfoView.getInstance().x+NowJoinGroupInfoView.getInstance().width+20;
			createGroupPrivate.y = NowJoinGroupInfoView.getInstance().y;
			
			createGroupPublic.x = createGroupPrivate.x+createGroupPrivate.width+20;
			createGroupPublic.y = createGroupPrivate.y;
			
			bottomGroup.width = 300
			bottomGroup.y = startButton.y;
			bottomGroup.x = startButton.x-bottomGroup.width;
		}
		
		public function init(rooms:Array): void {
			//			trace('init rooms', JSON.stringify(rooms))
			//			trace("当前群：",JSON.stringify(AppData.getInstane().group));
			//			trace("当前群群主：",AppData.getInstane().group.adminName);
			NowSelectedPlayRuleView.getInstance().data = null; //先重置当前选中的玩法界面
			NowJoinGroupInfoView.getInstance().data = AppData.getInstane().group;
			ruleSettingButton.visible = AppData.getInstane().group.adminName==AppData.getInstane().username
			HttpApi.getInstane().getRule({gid: AppData.getInstane().group.id}, function (e:Event):void {
				try
				{
					var response:Object = JSON.parse(e.currentTarget.data)
					if (response.code == 0 && response.data.length > 0) {
						AppData.getInstane().rule = response.data[0]
						AppData.getInstane().allRules = response.data
						roomsData = rooms
						NowSelectedPlayRuleView.getInstance().data = response.data[0];
						// 用户自己在不在房间数据中 在的话恢复游戏
						for each(var room:Object in roomsData) {
							for each(var username:String in room.users) {
								if (username == AppData.getInstane().user.username) {
									// 用户已经在游戏中了
									Loading.getInstance().open()
									Loading.getInstance().text = '游戏恢复中...'
									Api.getInstane().joinRoom(room.name, function (response:Object):void {
										Loading.getInstance().close()
										if (response.code == 0) {
											RoomView(MainView.getInstane().pushView(RoomView)).init(response.data)
										}
									})
								}
							}
						}
					}
				} 
				catch(error:Error) 
				{
				}
			})
			getNowGroupUsersInfo();
		}
		
		/**
		 * 获取当前群中的所有用户信息,
		 */
		private function getNowGroupUsersInfo():void
		{
			HttpApi.getInstane().getGroupUser({gid: AppData.getInstane().group.id}, function (e:Event):void {
				try
				{
					var response:Object = JSON.parse(e.currentTarget.data)
					if (response.code == 0) {
						var groupusers:Array = response.data
						var uids:Array = []
						for each(var groupuser:Object in groupusers) {
							uids.push(groupuser.uid)
						}
						HttpApi.getInstane().getUser({id: {'$in': uids}}, function (ee:Event):void {
							var response2:Object = JSON.parse(ee.currentTarget.data)
							if (response2.code == 0) {
								var users:Array = response2.data
								
								function getUser(id:int):Object {
									for each(var user:Object in users) {
										if (user.id == id) {
											return user
										} 
									}
									return null
								}
								
								for each(var groupuser:Object in groupusers) {
									var guser:Object = getUser(groupuser.uid)
									if (guser) {
										groupuser.username = guser.username
									}
								}
								AppData.getInstane().groupUsers = groupusers;
								//trace("当前群中的所有用户信息:",JSON.stringify(groupusers));
								actionHandler();
							}
						})
					} else {
					}
				} 
				catch(error:Error) 
				{
				}
			})
		}
		
		/**
		 * 对当前群中的所有用户信息进行操作处理
		 */
		private function actionHandler():void
		{
			for each (var user:Object in AppData.getInstane().groupUsers) 
			{
				if(user.username==AppData.getInstane().username){
					//trace("我在这个群里的资料：",JSON.stringify(user));
					isNowGroupHost = user.ll==4 ///是不是当前群的群主
					userSettingButton.visible = user.ll>0; ///只有是管理人员才能有群管理的入口
					AppData.getInstane().groupLL = user.ll;
					fenBar.count = user.fs;
					//					trace("这个群中你的分数：",user.fs);
				}
			}
		}
		
		protected function onGroupHandler(event:ApiEvent):void
		{
			//			trace('收到消息', JSON.stringify(event.data))
			var notification:Object = event.data
			switch(notification.name)
			{
				case Notifications.onGroupStatus:
				{
					roomsData = notification.data
					break;
				}
				default:
				{
					break;
				}
			}
		}
		
		protected function addRuleButton_clickHandler(event:MouseEvent):void
		{
			new AddRulePanel().open()
		}
		
		/*protected function switchRuleButton_clickHandler(event:MouseEvent):void
		{
		new SwitchRulePanel().open()
		}*/
		
		protected function userSettingButton_clickHandler(event:MouseEvent):void
		{
			new GroupUsersPanel().open()
		}
		
		protected function ruleSettingButton_clickHandler(event:MouseEvent):void
		{
			new GroupRulesPanel().open()
		}
		
		protected function startButton_clickHandler(event:MouseEvent):void
		{
			//			trace("allRules,",JSON.stringify(AppData.getInstane().allRules));
			if(!AppData.getInstane().rule){
				AppSmallAlert.show("请先选择玩法");
				return
			}
			if(AppData.getInstane().rule.plz&&fenBar.count<AppData.getInstane().rule.plz){
				AppAlert.show("很遗憾，您的疲劳值不够开始此玩法")
				return
			}
			PopUpManager.centerPopUp(PopUpManager.addPopUp(new KeyboardPanel(),null,true,true,0,0.2));
		}
		
		protected function roomsList_changeHandler(event:UIEvent):void
		{
			for each (var itemRule:Object in AppData.getInstane().allRules) 
			{
				if(itemRule.id==roomsList.selectedItem.rid){
					if(fenBar.count<itemRule.plz){
						AppAlert.show("很遗憾，您的疲劳值不够进入此桌的玩法")
						roomsList.selectedIndex = -1
						return
					}else{
						Loading.getInstance().open()
						Api.getInstane().joinRoom(roomsList.selectedItem.name, function (response:Object):void {
							Loading.getInstance().close()
							if (response.code == 0) {
								RoomView(MainView.getInstane().pushView(RoomView)).init(response.data)
							} else {
								AppAlert.show(JSON.stringify(response.data))
							}
						})
					}
				}
			}
			roomsList.selectedIndex = -1
		}
		
		protected function refreshButton_clickHandler(event:MouseEvent):void
		{
			Api.getInstane().queryGroupStatus(function (response:Object):void {
				if (response.code == 0) {
					roomsData = response.data
				}
			})
			this.getNowGroupUsersInfo()
		}
		
		
		protected function refrshGroupDataHandler(event:AppManagerEvent):void
		{
			trace('刷新数据')
			refreshButton_clickHandler(null)
		}
		
		protected function updateMemberHander(event:AppManagerEvent):void
		{
			trace("更新了会员信息，刷新顶部的分显示");///这里要刷新顶部的分显示
			getNowGroupUsersInfo();
		}
		
		protected function changSelectedRuleHandler(event:AppManagerEvent):void
		{
			trace("改变的玩法：",JSON.stringify(AppData.getInstane().rule));
			NowSelectedPlayRuleView.getInstance().data = AppData.getInstane().rule;
		}
		
		/**
		 * 查询积分变动情况界面
		 */
		protected function scorehistoryBtn_clickHandler(event:MouseEvent):void
		{
			new ScoreHistoryPanel().open();
			//			new GroupRulesPanel().open();
		}
	}
}