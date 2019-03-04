package com.xiaomu.view
{
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
		
//		private var bg : Image;
		private var roomsList:List
		private var usersList:List
		private var goback:Button;
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
			
//			bg = new Image();
//			bg.source = 'assets/room/club_bg.png';
//			addChild(bg);
			
			roomsList = new List()
			roomsList.itemRendererClass = RoomRenderer
			roomsList.itemRendererColumnCount = 3
			roomsList.itemRendererHeight = 80;
			roomsList.itemRendererWidth = 140;
			roomsList.gap = 10
			roomsList.addEventListener(UIEvent.CHANGE, roomsList_changeHandler)
			addChild(roomsList)
			
			usersList = new List()
			usersList.width = 60
			usersList.height = height-50;
			usersList.itemRendererClass = UserRenderer
			addChild(usersList)
			
			goback= new Button()
			goback.label = '返回️'
			goback.width = 40;
			goback.height = 20;
			goback.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
				Api.getInstane().leaveGroup()			
				MainView.getInstane().pushView(HallView)
			})
			addChild(goback)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			usersList.dataProvider = usersData
			roomsList.dataProvider = roomsData
			trace("roomsData",JSON.stringify(roomsData));
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0x336699);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
		
		protected function roomsList_changeHandler(event:UIEvent):void
		{
			const roominfo:Object = roomsList.selectedItem
			setTimeout(function ():void { roomsList.selectedIndex = -1 }, 200)
			RoomView(MainView.getInstane().pushView(RoomView)).init(roominfo)
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
//			bg.width = width;
//			bg.height = height;
			
			usersList.x = width-usersList.width;
			usersList.y = 50;
			
			roomsList.height = usersList.height = height
			roomsList.width = width-usersList.width-10
			roomsList.x = 10;
			roomsList.y = 50;
			
			goback.x = width-goback.width;
			goback.y = 0;
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
			MainView.getInstane().popView()
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