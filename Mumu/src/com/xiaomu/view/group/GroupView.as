package com.xiaomu.view.group
{
	import com.xiaomu.component.ImageButton;
	import com.xiaomu.component.Loading;
	import com.xiaomu.event.ApiEvent;
	import com.xiaomu.itemRender.GroupRoomRenderer;
	import com.xiaomu.util.Api;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	import com.xiaomu.util.Notifications;
	import com.xiaomu.view.MainView;
	import com.xiaomu.view.hall.HallView;
	import com.xiaomu.view.room.RoomView;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Alert;
	import coco.component.Button;
	import coco.component.HGroup;
	import coco.component.HorizontalAlign;
	import coco.component.Image;
	import coco.component.List;
	import coco.component.VerticalAlign;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	
	
	/**
	 * 群视图---测试
	 */	
	public class GroupView extends UIComponent
	{
		public function GroupView()
		{
			super();
			
			Api.getInstane().addEventListener(ApiEvent.ON_GROUP, onGroupHandler)
		}
		
		private var bg:Image
		private var bg1:Image
		private var roomsList:List
		private var goback:ImageButton
		private var refreshButton:ImageButton
		private var userSettingButton:ImageButton
		private var startButton:ImageButton
		private var bottomGroup:HGroup
		
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
		
		override protected function createChildren():void {
			super.createChildren()
			
			bg = new Image()
			bg.source = 'assets/group/guild2_bg.png'
			addChild(bg)
			
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
			
			bottomGroup = new HGroup()
			bottomGroup.verticalAlign = VerticalAlign.MIDDLE
			bottomGroup.horizontalAlign = HorizontalAlign.CENTER
			bottomGroup.height = 114
			addChild(bottomGroup)
			
			var addRuleButton:Button = new Button()
			addRuleButton.label = '添加玩法'
			addRuleButton.addEventListener(MouseEvent.CLICK, addRuleButton_clickHandler)
			bottomGroup.addChild(addRuleButton)
			
			var switchRuleButton:Button = new Button()
			switchRuleButton.label = '切换玩法'
			switchRuleButton.addEventListener(MouseEvent.CLICK, switchRuleButton_clickHandler)
			bottomGroup.addChild(switchRuleButton)
			
			var ruleSettingButton:Button = new Button()
			ruleSettingButton.label = '玩法管理'
			ruleSettingButton.addEventListener(MouseEvent.CLICK, ruleSettingButton_clickHandler)
			bottomGroup.addChild(ruleSettingButton)
			
			userSettingButton = new ImageButton()
			userSettingButton.width = 85
			userSettingButton.height = 91
			userSettingButton.upImageSource = 'assets/group/btn_guild2_guildManage_n.png';
			userSettingButton.downImageSource = 'assets/group/btn_guild2_guildManage_p.png';
			userSettingButton.addEventListener(MouseEvent.CLICK, userSettingButton_clickHandler)
			addChild(userSettingButton)
			
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
				MainView.getInstane().popView(HallView)
			})
			addChild(goback)
			
			startButton = new ImageButton()
			startButton.width = 133
			startButton.height = 133
			startButton.upImageSource = 'assets/group/btn_guild2_quick_n.png';
			startButton.downImageSource = 'assets/group/btn_guild2_quick_p.png';
			startButton.addEventListener(MouseEvent.CLICK, startButton_clickHandler)
			addChild(startButton)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			roomsList.dataProvider = roomsData
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			bg.width = width
			bg.height = height
			
			bg1.width = width
			bg1.y = height - bg1.height
			
			roomsList.y = roomsList.paddingTop;
			roomsList.height = height - roomsList.y-bg1.height;
			roomsList.width = width
			roomsList.itemRendererHeight = (roomsList.width- roomsList.padding * 2 - roomsList.gap*3) / 4
			
			bottomGroup.width = width
			bottomGroup.y = height - bottomGroup.height
			
			userSettingButton.x = width - userSettingButton.width - 20
			userSettingButton.y = 10
			
			refreshButton.x = userSettingButton.x - 20 - refreshButton.width
			refreshButton.y  = 10
			
			startButton.x = width - startButton.width
			startButton.y = height - startButton.height
		}
		
		public function init(rooms:Array): void {
			roomsData = rooms
			HttpApi.getInstane().getRule({gid: AppData.getInstane().group.id}, function (e:Event):void {
				try
				{
					var response:Object = JSON.parse(e.currentTarget.data)
					if (response.code == 0 && response.data.length > 0) {
						AppData.getInstane().rule = response.data[0]
						AppData.getInstane().allRules = response.data
						roomsData = rooms
						// 用户自己在不在房间数据中 在的话恢复游戏
						for each(var room:Object in roomsData) {
							for each(var username:String in room.users) {
								if (username == AppData.getInstane().user.username) {
									// 用户已经在游戏中了
									Loading.getInstance().open()
									Loading.getInstance().text = '游戏恢复中...'
									Api.getInstane().joinRoom({roomname: room.name}, function (response:Object):void {
										Loading.getInstance().close()
										if (response.code == 0) {
											RoomView(MainView.getInstane().pushView(RoomView)).init(response.data)
										}
									})
								}
							}
						}
					} else {
					}
				} 
				catch(error:Error) 
				{
				}
			})
		}
		
		protected function onGroupHandler(event:ApiEvent):void
		{
			trace('收到消息', JSON.stringify(event.data))
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
		
		protected function switchRuleButton_clickHandler(event:MouseEvent):void
		{
			new SwitchRulePanel().open()
		}
		
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
			Loading.getInstance().open() 
			Api.getInstane().createRoom(AppData.getInstane().rule, function (response:Object):void {
				Loading.getInstance().close() 
				if (response.code == 0) {
					RoomView(MainView.getInstane().pushView(RoomView)).init(response.data)
				} else {
					Alert.show(JSON.stringify(response.data))
				}
			})
		}
		
		protected function roomsList_changeHandler(event:UIEvent):void
		{
			Loading.getInstance().open()
			Api.getInstane().joinRoom({roomname: roomsList.selectedItem.name}, function (response:Object):void {
				Loading.getInstance().close()
				if (response.code == 0) {
					RoomView(MainView.getInstane().pushView(RoomView)).init(response.data)
				} else {
					Alert.show(JSON.stringify(response.data))
				}
			})
			
			roomsList.selectedIndex = -1
		}
		
		protected function refreshButton_clickHandler(event:MouseEvent):void
		{
			Api.getInstane().queryGroupStatus(function (response:Object):void {
				if (response.code == 0) {
					roomsData = response.data
				}
			})
		}
		
	}
}