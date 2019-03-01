package com.xiaomu.util
{
	import com.xiaomu.event.ApiEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import coco.component.Alert;
	
	import org.idream.pomelo.Pomelo;
	import org.idream.pomelo.PomeloEvent;
	
	[Event(name="notification", type="com.xiaomu.event.ApiEvent")]
	[Event(name="loginSuccess", type="com.xiaomu.event.ApiEvent")]
	[Event(name="loginFault", type="com.xiaomu.event.ApiEvent")]
	[Event(name="getGroupsSuccess", type="com.xiaomu.event.ApiEvent")]
	[Event(name="getGroupsFault", type="com.xiaomu.event.ApiEvent")]
	[Event(name="getRoomsSuccess", type="com.xiaomu.event.ApiEvent")]
	[Event(name="getRoomsFault", type="com.xiaomu.event.ApiEvent")]
	
	public class Api extends EventDispatcher
	{
		public function Api()
		{
		}
		
		private static var instance:Api
		
		public static function getInstane(): Api {
			if (!instance) {
				instance = new Api()
			}
			
			return instance
		}
		
		private var pomelo:Pomelo = Pomelo.getIns()
		public var username:String
		public var password:String
		private var roomname:String
		private var roominfo:Object
		private var isJoinRoom:Boolean = false
		public var user:Object 
		
		/**
		 * 用户登录 
		 *  
		 * @param username
		 * @param password
		 */		
		public function login(username:String, password:String):void {
			this.username = username
			this.password = password
			pomelo.init("127.0.0.1", 3014)
			//pomelo.init("106.14.148.139", 3014)
			pomelo.addEventListener(PomeloEvent.HANDSHAKE, onConnectHandler);
			pomelo.addEventListener(PomeloEvent.ERROR, pomeloErrorHandler);
		}
		
		private function onConnectHandler(event:Event):void {
			pomelo.request("gate.gateHandler.queryEntry", {username: this.username}, function(response:Object):void {
				pomelo.disconnect()
				pomelo.removeEventListener('handshake', onConnectHandler)
				pomelo.addEventListener('handshake', onQueryHandler)
				pomelo.init(response.host, response.port)
			});
		}
		
		protected function pomeloErrorHandler(event:PomeloEvent):void
		{
			Alert.show('连接服务器失败')
		}
		
		private function onQueryHandler(event:Event):void {
			pomelo.request('connector.entryHandler.login', {username: this.username, password: this.password},
				function(response:Object):void {
					if (response.code == 0) {
						var e:ApiEvent = new ApiEvent(ApiEvent.LOGIN_SUCCESS)
						e.data = response.data
						dispatchEvent(e)
					} else {
						dispatchEvent(new ApiEvent(ApiEvent.LOGIN_FAULT))
					}
				})
		}
		
		/**
		 * 创建群 
		 */		
		public function createGroup(name:String):void {
			pomelo.request('connector.entryHandler.createGroup', {name: name},
				function(response:Object):void {
					Alert.show(JSON.stringify(response))
					if (response.code == 0) {
					} else {
					}
				})
		}
		
		/**
		 * 获取群信息 
		 * @param username
		 * 
		 */		
		public function getGroups():void {
			pomelo.request('connector.entryHandler.getGroups', {},
				function(response:Object):void {
					if (response.code == 0) {
						var e:ApiEvent = new ApiEvent(ApiEvent.GET_GROUPS_SUCCESS)
						e.data = response.data
						dispatchEvent(e)
					} else {
						dispatchEvent(new ApiEvent(ApiEvent.LOGIN_FAULT))
					}
				})
		}
		
		/**
		 * 创建房间
		 */		
		public function createRoom(groupid:int, name:String, count:int):void {
			pomelo.request('connector.entryHandler.createRoom', {groupid: groupid, name: name, count: count},
				function(response:Object):void {
					Alert.show(JSON.stringify(response))
					if (response.code == 0) {
					} else {
					}
				})
		}
		
		/**
		 * 获取群信息 
		 * @param username
		 * 
		 */		
		public function getRooms(groupid:int):void {
			pomelo.request('connector.entryHandler.getRooms', {groupid: groupid},
				function(response:Object):void {
					if (response.code == 0) {
						var e:ApiEvent = new ApiEvent(ApiEvent.GET_ROOMS_SUCCESS)
						e.data = response.data
						dispatchEvent(e)
					} else {
						dispatchEvent(new ApiEvent(ApiEvent.GET_ROOMS_FAULT))
					}
				})
		}
		
		public function joinRoom(roomname:String, username:String):void {
		}
		
		/**
		 * 发送动作 
		 * @param action
		 */		
		public function sendAction(action):void  {
			pomelo.request('chat.roomHandler.sendAction', action)
		}
		
		
		
	}
}