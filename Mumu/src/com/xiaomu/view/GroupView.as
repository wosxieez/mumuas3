package com.xiaomu.view
{
	import com.xiaomu.component.UserStatusList;
	import com.xiaomu.event.ApiEvent;
	import com.xiaomu.renderer.RoomRenderer;
	import com.xiaomu.renderer.UserRenderer;
	import com.xiaomu.util.Api;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	import com.xiaomu.util.Notifications;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import coco.component.Alert;
	import coco.component.Button;
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.List;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	
	
	/**
	 * 群视图 
	 * @author coco
	 * 
	 */	
	public class GroupView extends UIComponent
	{
		public function GroupView()
		{
			super();
			
			Api.getInstane().addEventListener(ApiEvent.JOIN_GROUP_SUCCESS, joinGroupSuccessHandler)
			Api.getInstane().addEventListener(ApiEvent.JOIN_GROUP_FAULT, joinGroupFaultHandler)
			Api.getInstane().addEventListener(ApiEvent.ON_GROUP, onGroupHandler)
		}
		
		private var userIcon:Image
		private var userLabel:Label
		private var bg : Image;
		private var roomsList:List
		private var usersList:List
		private var goback:Image;
		private var lab : Label;
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
		
		private var _usersData:Array
		
		public function get usersData():Array
		{
			return _usersData;
		}
		
		public function set usersData(value:Array):void
		{
			_usersData = value;
			invalidateProperties()
		}
		
		override protected function createChildren():void {
			super.createChildren()
			
			bg = new Image();
			bg.source = 'assets/room/table_bg.png';
			addChild(bg);
			
			userIcon = new Image
			userIcon.source = 'assets/hall/usericon.png'
			userIcon.width = userIcon.height = 26
			userIcon.x = userIcon.y = 2
			addChild(userIcon)
			
			userLabel = new Label()
			userLabel.x = 30
			userLabel.height = 30
			userLabel.color = 0xFFFFFF
			addChild(userLabel)
			
			roomsList = new List()
			roomsList.itemRendererClass = RoomRenderer
			roomsList.itemRendererColumnCount = 3
			roomsList.itemRendererHeight = 80;
			roomsList.itemRendererWidth = 120;
			roomsList.gap = 10
			roomsList.addEventListener(UIEvent.CHANGE, roomsList_changeHandler)
			addChild(roomsList)
			
			lab = new Label();
			lab.text = '圈内好友';
			lab.fontSize = 10;
			lab.color = 0xffffff;
			addChild(lab);
			
			usersList = new UserStatusList()
			usersList.width = 120
			usersList.height = height-50;
			usersList.gap = 1;
			usersList.itemRendererClass = UserRenderer
			usersList.itemRendererHeight = 25;
			addChild(usersList)
			
			goback= new Image()
			goback.source = 'assets/backbtn.png';
			goback.width = 22;
			goback.height = 20;
			goback.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
				Api.getInstane().leaveGroup()			
				MainView.getInstane().pushView(HallView)
			})
			addChild(goback)
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			bg.width = width;
			bg.height = height;
			
			usersList.x = width-usersList.width-10;
			usersList.y = 50;
			lab.x = usersList.x;
			lab.y = usersList.y-15;
			
			roomsList.height = usersList.height = height
			roomsList.width = width-usersList.width-10
			roomsList.x = 10;
			roomsList.y = 50;
			var itemWidth:Number= roomsList.itemRendererWidth;
			var itemCount:Number = roomsList.itemRendererColumnCount;
			var itemGap:Number = roomsList.gap;
			if(width-usersList.width-(itemWidth*(itemCount+1)+(itemCount)*itemGap)>0){
				roomsList.itemRendererColumnCount = itemCount+1
			}
			goback.x = width-goback.width;
			goback.y = 0;
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			userLabel.text = AppData.getInstane().user.username
			usersList.dataProvider = usersData
			roomsList.dataProvider = roomsData
			var tempArr : Array = [];
			for each (var i:Object in usersData) 
			{
				if(i.online){
					tempArr.unshift(i)
				}else{
					tempArr.push(i);
				}
			}
			usersList.dataProvider = tempArr
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
//			graphics.clear();
//			graphics.beginFill(0x9F7D50);
//			graphics.drawRect(0,0,width,height);
//			graphics.endFill();
		}
		
		protected function roomsList_changeHandler(event:UIEvent):void
		{
			const roominfo:Object = roomsList.selectedItem
			setTimeout(function ():void { roomsList.selectedIndex = -1 }, 200)
			RoomView(MainView.getInstane().pushView(RoomView)).init(roominfo)
		}
		
		
		
		public function init(groupid:int): void {
			HttpApi.getInstane().getGroupUsers(groupid, 
				function (e:Event):void {
					// get group users ok
					const usersResponse:Object = JSON.parse(e.currentTarget.data)
					if (usersResponse.result == 0 && usersResponse.message) {
						usersData = usersResponse.message
					} 
					
					// 加载群的房间信息
					HttpApi.getInstane().getGroupRooms(groupid, 
						function (e:Event):void {
							const roomsResponse:Object = JSON.parse(e.currentTarget.data)
							if (roomsResponse.result == 0 && roomsResponse.message) {
								var rooms:Array = roomsResponse.message
								for each(var room:Object in rooms) {
									room.roomname = 'room' + room.id
								}
								roomsData = rooms
								// 加入群
								Api.getInstane().joinGroup(AppData.getInstane().user.username, groupid)
							} 
						}, 
						function (e:Event):void {
							// get group rooms error
						})
					
					
				}, 
				function (e:Event):void {
					// get group users error
				})
			
		}
		
		private function getUser(username:String):Object {
			for each(var user:Object in usersData) {
				if (user.username == username)
					return user
			}
			
			return null
		}
		
		private function getRoom(roomname:String):Object {
			for each(var room:Object in roomsData) {
				if (room.roomname == roomname)
					return room
			}
			
			return null
		}
		
		protected function joinGroupSuccessHandler(event:ApiEvent):void
		{
			const onlineUsernames:Array = event.data as Array
			var user:Object
			for each(var username:String in onlineUsernames) {
				user = getUser(username)
				if (user) {
					user.online = true
				}
			}
			
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
				invalidateProperties()
			})
			
			invalidateProperties()
		}
		
		protected function joinGroupFaultHandler(event:ApiEvent):void {
			Alert.show(JSON.stringify(event.data))
			MainView.getInstane().popView(HallView)
		}
		
		protected function onGroupHandler(event:ApiEvent):void
		{
			const notification:Object = event.data
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
				case Notifications.onLevelGroup:
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
				case Notifications.onLevelRoom:
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
		
	}
}