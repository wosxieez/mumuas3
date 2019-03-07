package com.xiaomu.view.group
{
	import com.xiaomu.event.ApiEvent;
	import com.xiaomu.renderer.RoomRenderer;
	import com.xiaomu.renderer.UserRenderer;
	import com.xiaomu.util.Api;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	import com.xiaomu.util.Notifications;
	import com.xiaomu.view.MainView;
	import com.xiaomu.view.hall.HallView;
	import com.xiaomu.view.room.RoomView;
	import com.xiaomu.view.userBarView.UserInfoVIew;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import coco.component.Alert;
	import coco.component.Button;
	import coco.component.HorizontalAlign;
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
		
		private var userInfoView : UserInfoVIew
		private var userIcon:Image
		private var userLabel:Label
		private var roomsList:List
		private var usersList:List
		private var goback:Image;
		private var _roomsData:Array
		private var _userData : Object;
		
		public function get userData():Object
		{
			return _userData;
		}
		
		public function set userData(value:Object):void
		{
			_userData = value;
			invalidateProperties();
		}
		
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
		
		private var addMemberButton:Button
		
		override protected function createChildren():void {
			super.createChildren()
			
			userInfoView = new UserInfoVIew();
			userInfoView.height = 40;
			userInfoView.inRoomFlag = true;
			addChild(userInfoView);
			
			roomsList = new List()
			roomsList.itemRendererClass = RoomRenderer
			roomsList.itemRendererColumnCount = 2
			roomsList.horizontalAlign = HorizontalAlign.JUSTIFY;
			roomsList.gap = roomsList.padding = 10
			roomsList.y = 40
			roomsList.addEventListener(UIEvent.CHANGE, roomsList_changeHandler)
			addChild(roomsList)
			
			usersList = new List()
			usersList.radius = 10
			usersList.padding = 10
			usersList.paddingLeft = 0
			usersList.y = 40
			usersList.gap = 5
			usersList.backgroundColor = 0xFFFFFF
			usersList.backgroundAlpha = 0
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
			
			addMemberButton = new Button()
			addMemberButton.backgroundColor = 0xFFFFFF
			addMemberButton.backgroundAlpha = 0.1
			addMemberButton.borderAlpha = 0
			addMemberButton.radius = 5
			addMemberButton.fontSize = 9
			addMemberButton.color = 0xFFFFFF
			addMemberButton.label = '添加成员'
			addMemberButton.addEventListener(MouseEvent.CLICK, addMemberButton_clickHandler)
			addChild(addMemberButton)
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
				
			userInfoView.width = width
			
			usersList.width = width / 3
			usersList.height = height - usersList.y
			usersList.x = width - usersList.width
				
			addMemberButton.x = usersList.x
			addMemberButton.width = usersList.width - usersList.padding
			addMemberButton.height = 25
			addMemberButton.y = height - addMemberButton.height - usersList.padding
				
			roomsList.height = height - roomsList.y
			roomsList.width = width * 2 / 3
			roomsList.itemRendererHeight = (roomsList.width- roomsList.padding * 2 - roomsList.gap) / 2
			
			goback.x = width-goback.width;
			goback.y = 0;
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
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
			userInfoView.userInfoData = userData
		}
		
		protected function roomsList_changeHandler(event:UIEvent):void
		{
			const roominfo:Object = roomsList.selectedItem
			setTimeout(function ():void { roomsList.selectedIndex = -1 }, 200)
			
			Api.getInstane().joinRoom(roominfo, function (response):void {
				if (response.code == 0) {
					RoomView(MainView.getInstane().pushView(RoomView)).init(roominfo)
				} else {
					Alert.show(response.data)
				}
			})
		}
		
		private var thisGroupID:int
		
		public function init(groupid:int): void {
			thisGroupID = groupid
			HttpApi.getInstane().getUserInfo(AppData.getInstane().username,function(e:Event):void{
				//				trace('房间界面：',JSON.stringify(JSON.parse(e.currentTarget.data).message[0]));
				//				trace('房间界面：金币',JSON.parse(e.currentTarget.data).message[0].group_info);
				//				trace('房间界面：房卡',JSON.parse(e.currentTarget.data).message[0].room_card);
				var roomCard:String = JSON.parse(e.currentTarget.data).message[0].room_card+'';
				var tempArr : Array = JSON.parse(JSON.parse(e.currentTarget.data).message[0].group_info) as Array;
				for each (var i:Object in tempArr) 
				{
					if(i.group_id+''==groupid+''){
						userData = {'gold':i.gold,'userName':AppData.getInstane().username,'roomCard':roomCard}
						//						trace("userData:",JSON.stringify(userData));
					}
				}
			},null);
			
			HttpApi.getInstane().getGroupUsers(groupid, 
				function (e:Event):void {
					// get group users ok
					const usersResponse:Object = JSON.parse(e.currentTarget.data)
					if (usersResponse.result == 0 && usersResponse.message) {
						usersData = usersResponse.message
						//						trace("结果：",JSON.stringify(usersResponse.message));
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
		
		protected function addMemberButton_clickHandler(event:MouseEvent):void
		{
			AddMemberPanel.getInstane().open(thisGroupID)
		}
		
	}
}