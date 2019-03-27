package com.xiaomu.view.group
{
	import com.xiaomu.event.ApiEvent;
	import com.xiaomu.event.AppManagerEvent;
	import com.xiaomu.manager.AppManager;
	import com.xiaomu.renderer.RoomRenderer;
	import com.xiaomu.util.Api;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	import com.xiaomu.util.Notifications;
	import com.xiaomu.view.MainView;
	import com.xiaomu.view.hall.HallView;
	import com.xiaomu.view.room.RoomView;
	import com.xiaomu.view.userBarView.UserInfoView2;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import caurina.transitions.Tweener;
	
	import coco.component.Alert;
	import coco.component.Button;
	import coco.component.HorizontalAlign;
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.List;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	
	
	/**
	 * 群视图---测试
	 */	
	public class GroupViewNew extends UIComponent
	{
		public function GroupViewNew()
		{
			super();
			
			Api.getInstane().addEventListener(ApiEvent.JOIN_GROUP_SUCCESS, joinGroupSuccessHandler)
			Api.getInstane().addEventListener(ApiEvent.JOIN_GROUP_FAULT, joinGroupFaultHandler)
			Api.getInstane().addEventListener(ApiEvent.ON_GROUP, onGroupHandler)
			AppManager.getInstance().addEventListener(AppManagerEvent.UPDATE_GROUP_SUCCESS,updateGroupSuccessHandler);
			AppManager.getInstance().addEventListener(AppManagerEvent.UPDATE_MEMBER_INFO_SUCCESS,updateMemberInfoSuccessHandler);
			AppManager.getInstance().addEventListener(AppManagerEvent.UPDATE_ADMIN_GOLD_SUCCESS,updateAdminGoldSuccessHandler);
			AppManager.getInstance().addEventListener(AppManagerEvent.CHANGE_MEMBER_SUCCESS,changeMemberSuccessHandler);
		}
		
		private var groupInfoView:GroupInfoView
		private var userInfoView : UserInfoView2
		private var userIcon:Image
		private var userLabel:Label
		private var roomsList:List
		private var usersList:HideUserListView
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
		
		private var _isNowGroupAdmin:Boolean;
		
		public function get isNowGroupAdmin():Boolean
		{
			return _isNowGroupAdmin;
		}
		
		public function set isNowGroupAdmin(value:Boolean):void
		{
			_isNowGroupAdmin = value;
			invalidateDisplayList();
		}
		
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
			
			goback= new Image()
			goback.source = 'assets/club_btn_back.png';
			goback.width = 71;
			goback.height = 86;
			goback.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
				userInfoView.reset();
				Api.getInstane().leaveGroup()			
				MainView.getInstane().pushView(HallView)
				usersList.showFlag = false;
			})
			addChild(goback)
			
			usersList = new HideUserListView()
			addChild(usersList)
			usersList.changeShowAndHide.addEventListener(MouseEvent.CLICK,changeShowAndHideHandler);
			usersList.statusImg.addEventListener(MouseEvent.CLICK,changeShowAndHideHandler);
			usersList.addMemberBtn.addEventListener(MouseEvent.CLICK,addMemberButton_clickHandler);
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			userInfoView.x=userInfoView.y=0;
			
			usersList.isNowGroupAdmin = isNowGroupAdmin;
			
			groupInfoView.x = roomsList.padding;
			groupInfoView.y = goback.y+goback.height+20;
			groupInfoView.width = width-(width/3+roomsList.padding*2)
			groupInfoView.height = 100;
			
			roomsList.y = groupInfoView.y+groupInfoView.height+roomsList.padding;
			roomsList.height = height - roomsList.y
			roomsList.width = width;
			roomsList.itemRendererHeight = (roomsList.width- roomsList.padding * 3 - roomsList.gap*2) / 4
			
			goback.x = width-goback.width-20;
			goback.y = 20;
			
			usersList.y = groupInfoView.y;
			usersList.width = width / 4
			usersList.height = height-usersList.y-50;
			usersList.x = width;
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			AppData.getInstane().inGroupView = true;
			roomsList.dataProvider = roomsData
			trace('roomsData:',JSON.stringify(roomsData));
			var tempArr:Array = [];
			for each (var i:Object in usersData) 
			{
				if(i.online){
					tempArr.unshift(i)
				}else{
					tempArr.push(i);
				}
			}
			var finalArr:Array = [];
			for each (var j:Object in tempArr) 
			{
				if(j.isAdmin){
					finalArr.unshift(j);
				}else{
					finalArr.push(j);
				}
			}
			//usersList.dataProvider = finalArr
			usersList.dataProvider = finalArr.slice(1);///移除首位的群主
			userInfoView.userInfoData = userData
		}
		
		protected function roomsList_changeHandler(event:UIEvent):void
		{
			if(roomsList.selectedItem!=null){
				if(roomsList.selectedItem.name=='+'){
					HttpApi.getInstane().addRoom(roomsData.length+"号房间",thisGroupID,3,function(e:Event):void{
						if(JSON.parse(e.currentTarget.data).result==0){
							getGroupRoomHandler(false);
						}
					},null);
					roomsList.selectedIndex = -1
					return;
				}
				var room:Object = roomsList.selectedItem
				Api.getInstane().joinRoom(room, function (response):void {
					if (response.code == 0) {
						RoomView(MainView.getInstane().pushView(RoomView)).init(room)
					} else {
						Alert.show("response.data：",response.data)
					}
				})
			}
			roomsList.selectedIndex = -1
		}
		
		private var thisGroupID:int
		private var _groupInfoObj:Object
		private var copyGroupInfoData:Object;
		private var tempUsers : Array;
		private var _groupAdminId:int;
		/**
		 * 群界面初始化
		 * @param groupid 群id
		 * @param groupAdminId 该群的群主id
		 * @param groupInfoObj 该群的一些信息
		 */
		public function init(groupid:int,groupAdminId:int,groupInfoObj:Object): void {
			_groupAdminId = groupAdminId;
			_groupInfoObj = groupInfoObj;
			isNowGroupAdmin = groupAdminId==AppData.getInstane().user.id;///当前该用户是不是这个群的群主
			groupInfoObj.isNowGroupAdmin = isNowGroupAdmin///当前该用户是不是这个群的群主
			groupInfoView.groupInfoData = groupInfoObj;
			AppData.getInstane().isNowGroupAdmin = isNowGroupAdmin
			thisGroupID = groupid
			
			getUserInfoByName();
			
			HttpApi.getInstane().getGroupUsers(groupid, 
				function (e:Event):void {
					// get group users ok
					const usersResponse:Object = JSON.parse(e.currentTarget.data)
					if (usersResponse.result == 0 && usersResponse.message) {
						var users:Array = usersResponse.message
						for each(var user:Object in users) {
							user.group_id = thisGroupID
						}
						tempUsers = JSON.parse(JSON.stringify(users)) as Array;
						tempUsers.map(function(item:*,index:int,arr:Array):Object{
							item.allowSetFlag = groupAdminId==AppData.getInstane().user.id; ///你只有是该群的群主 你才能给其他群成员设置金币
							item.isAdmin = groupAdminId==item.id
						},null);
						usersData = tempUsers
					} 
					
					getGroupRoomHandler(true);
				}, 
				null)
		}
		
		private function getGroupRoomHandler(initFlag:Boolean):void
		{
			// 加载群的房间信息
			HttpApi.getInstane().getGroupRooms(thisGroupID, 
				function (e:Event):void {
					const roomsResponse:Object = JSON.parse(e.currentTarget.data)
					if (roomsResponse.result == 0 && roomsResponse.message) {
						var rooms:Array = roomsResponse.message
						for each(var room:Object in rooms) {
						room.roomname = 'room' + room.id
						}
						///如果是该群的群主,才支持添加房间
						if(_groupAdminId==AppData.getInstane().user.id){
							rooms.push({"name":"+"})
						}
						roomsData = rooms
						// 初始化加入群，后期调用时，用于刷新界面，不是再次加入该群
						if(initFlag){
							Api.getInstane().joinGroup(AppData.getInstane().user.username, thisGroupID)
						}
					} 
				}, 
				null)
		}
		
		private function getUserInfoByName():void
		{
			HttpApi.getInstane().getUserInfoByName(AppData.getInstane().username,function(e:Event):void{
				var roomCard:String = JSON.parse(e.currentTarget.data).message[0].room_card+'';
				var tempArr : Array = JSON.parse(JSON.parse(e.currentTarget.data).message[0].group_info) as Array;
				for each (var i:Object in tempArr){
					if(i.group_id+''==thisGroupID+''){
						userData = {'gold':i.gold,'userName':AppData.getInstane().username,'roomCard':roomCard,'userId':AppData.getInstane().user.id,'groupId':thisGroupID}///用于顶部用户信息界面
					}
				}
			},null);
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
				//				trace('获取房间用户数据', JSON.stringify(data))
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
		
		private function addRoomUser(room:Object, username:String):void {
			
		}
		
		private function removeRoomUser(room:Object, username:String):void {
			
		}
		
		protected function addMemberButton_clickHandler(event:MouseEvent):void
		{
			AddMemberPanel.getInstane().open(thisGroupID)
		}
		
		/**
		 * 监听到群信息更新成功
		 */
		protected function updateGroupSuccessHandler(event:AppManagerEvent):void
		{
			//			trace('监听到群信息更新成功');
			//			trace('groupInfoData:',JSON.stringify(groupInfoData));
			HttpApi.getInstane().getGroupInfoByGroupId(thisGroupID,function(e:Event):void{
				var respones:Object = JSON.parse(e.currentTarget.data).message[0]
				if(respones){
					copyGroupInfoData = JSON.parse(JSON.stringify(_groupInfoObj));
					copyGroupInfoData.group_name = respones.name
					copyGroupInfoData.remark = respones.remark
					//					trace('最终数据：',JSON.stringify(copyGroupInfoData));
					groupInfoView.groupInfoData = copyGroupInfoData;
				}
			},null);
		}
		
		/**
		 * 监听到人员信息更新成功
		 */
		protected function updateMemberInfoSuccessHandler(event:AppManagerEvent):void
		{
			getGroupUserHandler();
		}
		
		private function getGroupUserHandler():void
		{
			HttpApi.getInstane().getGroupUsers(thisGroupID, 
				function (e:Event):void {
					// get group users ok
					const usersResponse:Object = JSON.parse(e.currentTarget.data)
					if (usersResponse.result == 0 && usersResponse.message) {
						var users:Array = usersResponse.message
						for each(var user:Object in users) {
							user.group_id = thisGroupID
						}
						//usersData = users
						tempUsers = JSON.parse(JSON.stringify(users)) as Array;
						tempUsers.map(function(item:*,index:int,arr:Array):Object{
							item.allowSetFlag = _groupAdminId==AppData.getInstane().user.id; ///你只有是该群的群主 你才能给其他群成员设置金币
							item.isAdmin = _groupAdminId==item.id
						},null);
						usersData = tempUsers
					} 
				}, 
				null)
		}
		
		/**
		 * 监听到群主自身的金币信息更新成功
		 */
		protected function updateAdminGoldSuccessHandler(event:AppManagerEvent):void
		{
			getUserInfoByName();
		}
		
		/**
		 * 添加或移除成员成功
		 */
		protected function changeMemberSuccessHandler(event:AppManagerEvent):void
		{
			HttpApi.getInstane().getGroupUsers(thisGroupID, 
				function (e:Event):void {
					// get group users ok
					const usersResponse:Object = JSON.parse(e.currentTarget.data)
					if (usersResponse.result == 0 && usersResponse.message) {
						var users:Array = usersResponse.message
						for each(var user:Object in users) {
							user.group_id = thisGroupID
						}
						tempUsers = JSON.parse(JSON.stringify(users)) as Array;
						tempUsers.map(function(item:*,index:int,arr:Array):Object{
							item.allowSetFlag = _groupAdminId==AppData.getInstane().user.id; ///你只有是该群的群主 你才能给其他群成员设置金币
							item.isAdmin = _groupAdminId==item.id
						},null);
						usersData = tempUsers
					}
				},null);
		}
		
		
		/**
		 * 
		 */
		protected function changeShowAndHideHandler(event:MouseEvent):void
		{
			if(usersList.showFlag){
				Tweener.addTween(usersList,{x:width, y:usersList.y, time:0.2,transition:'linear',onComplete:function():void{
					usersList.showFlag = !usersList.showFlag}});
			}else{
				Tweener.addTween(usersList,{x:width-usersList.width, y:usersList.y, time:0.2,transition:'linear',onComplete:function():void{
					usersList.showFlag = !usersList.showFlag}});
			}
		}
		
	}
}