package com.xiaomu.view.group
{
	import com.xiaomu.component.Loading;
	import com.xiaomu.event.ApiEvent;
	import com.xiaomu.renderer.RoomRenderer;
	import com.xiaomu.util.Api;
	import com.xiaomu.util.Notifications;
	import com.xiaomu.view.MainView;
	import com.xiaomu.view.hall.HallView;
	import com.xiaomu.view.room.RoomView;
	import com.xiaomu.view.userBarView.UserInfoView2;
	
	import flash.events.MouseEvent;
	
	import coco.component.Alert;
	import coco.component.Button;
	import coco.component.HGroup;
	import coco.component.HorizontalAlign;
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.List;
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
			
			Api.getInstane().addEventListener(ApiEvent.JOIN_ROOM_SUCCESS, joinRoomSuccessHandler)
			Api.getInstane().addEventListener(ApiEvent.JOIN_ROOM_FAULT, joinRoomFaultHandler)
			Api.getInstane().addEventListener(ApiEvent.ON_GROUP, onGroupHandler)
		}
		
		private var groupInfoView:GroupInfoView
		private var userInfoView : UserInfoView2
		private var userIcon:Image
		private var userLabel:Label
		private var roomsList:List
		private var goback:Image;
		private var _roomsData:Array
		private var selectedRoom:Object
		
		public function get roomsData():Array
		{
			return _roomsData;
		}
		
		public function set roomsData(value:Array):void
		{
			_roomsData = value;
			invalidateProperties()
		}
		
		private var onlineUsernames:Array
		private var bottomGroup:HGroup
		
		override protected function createChildren():void {
			super.createChildren()
			
			userInfoView = new UserInfoView2();
			addChild(userInfoView);
			
			groupInfoView = new GroupInfoView();
			addChild(groupInfoView);
			
			roomsList = new List()
			roomsList.itemRendererClass = RoomRenderer
			roomsList.itemRendererColumnCount = 4
			roomsList.horizontalAlign = HorizontalAlign.JUSTIFY;
			roomsList.gap = 10;
			roomsList.padding = 10;
			roomsList.paddingTop = 0;
			roomsList.addEventListener(UIEvent.CHANGE, roomsList_changeHandler)
			addChild(roomsList)
			
			bottomGroup = new HGroup()
			addChild(bottomGroup)
			
			var addRuleButton:Button = new Button()
			addRuleButton.label = '添加玩法'
			addRuleButton.addEventListener(MouseEvent.CLICK, addRuleButton_clickHandler)
			bottomGroup.addChild(addRuleButton)
			
			var switchRuleButton:Button = new Button()
			switchRuleButton.label = '切换玩法'
			switchRuleButton.addEventListener(MouseEvent.CLICK, switchRuleButton_clickHandler)
			bottomGroup.addChild(switchRuleButton)
				
			var userSettingButton:Button = new Button()
			userSettingButton.label = '成员管理'
			userSettingButton.addEventListener(MouseEvent.CLICK, userSettingButton_clickHandler)
			bottomGroup.addChild(userSettingButton)
			
			goback= new Image()
			goback.source = 'assets/club_btn_back.png';
			goback.width = 71;
			goback.height = 86;
			goback.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
				userInfoView.reset();
				Api.getInstane().leaveGroup()			
				MainView.getInstane().pushView(HallView)
			})
			addChild(goback)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			groupInfoView.x = roomsList.padding;
			groupInfoView.y = goback.y+goback.height+20;
			groupInfoView.width = width/2-roomsList.padding*1-5
			groupInfoView.height = 70;
			
			roomsList.y = groupInfoView.y+groupInfoView.height+roomsList.padding;
			roomsList.height = height - roomsList.y
			roomsList.width = width;
			roomsList.itemRendererHeight = (roomsList.width- roomsList.padding * 3 - roomsList.gap*2) / 4
				
			bottomGroup.width = width
			bottomGroup.height = 100
			bottomGroup.y = height - bottomGroup.height
			
			goback.x = width-goback.width-20;
			goback.y = 20;
		}
		
		protected function roomsList_changeHandler(event:UIEvent):void
		{
//			if(roomsList.selectedItem!=null){
//				if(roomsList.selectedItem.name=='+'){
//					HttpApi.getInstane().addRoom(roomsData.length+"号房间",thisGroupID,3,function(e:Event):void{
//						if(JSON.parse(e.currentTarget.data).result==0){
//						}
//					},null);
//					roomsList.selectedIndex = -1
//					return;
//				}
//				selectedRoom = roomsList.selectedItem
//				Loading.getInstance().open()
//				if (!selectedRoom.hasOwnProperty('huxi')) { selectedRoom.huxi = 5 }
//				Api.getInstane().joinRoom(selectedRoom)
//			}
//			roomsList.selectedIndex = -1
		}
		
		private var thisGroupID:int
		private var _groupInfoObj:Object
		private var copyGroupInfoData:Object;
		private var tempUsers : Array;
		/**
		 * 群界面初始化
		 * @param groupid 群id
		 * @param groupAdminId 该群的群主id
		 * @param groupInfoObj 该群的一些信息
		 */
		public function init(): void {
			
		}
		
		private function getUser(username:String):Object {
			return null
		}
		
		private function getRoom(roomname:String):Object {
			for each(var room:Object in roomsData) {
				if (room.roomname == roomname)
					return room
			}
			
			return null
		}
		
		protected function updateOnlineStatus():void
		{
			var user:Object
			for each(var username:String in onlineUsernames) {
				user = getUser(username)
				if (user) {
					user.online = true
				}
			}
			invalidateProperties()
		}
		
		protected function updateRoomOnlineStatus():void
		{
			// 加入群成功 去查询下房间的人数信息
			var roomnames:Array = []
			for each(var room:Object in roomsData) {
				roomnames.push(room.roomname)
			}
			Api.getInstane().getRoomsUsers(roomnames, function (data:Object):void {
				for (var roomname:String in data) {
					var room:Object = getRoom(roomname)
					if (room) { room.users = data[roomname] }
				}
			})
			
			invalidateProperties()
		}
		
		protected function joinRoomSuccessHandler(event:ApiEvent):void
		{
			trace('跳转到房间')
			Loading.getInstance().close()
			RoomView(MainView.getInstane().pushView(RoomView)).init(selectedRoom)
		}
		
		protected function joinRoomFaultHandler(event:ApiEvent):void
		{
			Loading.getInstance().close()
			Alert.show(JSON.stringify(event.data))
		}
		
		protected function onGroupHandler(event:ApiEvent):void
		{
			const notification:Object = event.data
			//			trace('notification:',JSON.stringify(notification));
			switch(notification.name)
			{
				case Notifications.onJoinGroup:
				{
					const user:Object = getUser(notification.data.username)
					if (user) { 
						user.online = true 
						invalidateProperties()
					}
					break;
				}
				case Notifications.onLeaveGroup:
				{
					const user2:Object = getUser(notification.data.username)
					if (user2) { 
						user2.online = false 
						invalidateProperties()
					}
					break;
				}
				case Notifications.onJoinRoom:
				{
					const room:Object = getRoom(notification.data.roomname)
					if (room) { 
						room.users.push(notification.data.username)
						invalidateProperties()
					}
					break;
				}
				case Notifications.onLeaveRoom:
				{
					const room2:Object = getRoom(notification.data.roomname)
					if (room2) {
						for (var i:int = 0; i < room2.users.length; i++) {
							if (room2.users[i] == notification.data.username) {
								room2.users.splice(i, 1)
								invalidateProperties()
								break
							}
						}
					}
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
			GroupUsersView(MainView.getInstane().pushView(GroupUsersView)).init()
		}
		
	}
}