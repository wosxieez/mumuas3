package com.xiaomu.util
{
	import com.xiaomu.event.ApiEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import coco.component.Alert;
	
	import org.idream.pomelo.Pomelo;
	import org.idream.pomelo.PomeloEvent;
	
	[Event(name="notification", type="com.xiaomu.event.ApiEvent")]
	[Event(name="joinGroup", type="com.xiaomu.event.ApiEvent")]
	[Event(name="leaveGroup", type="com.xiaomu.event.ApiEvent")]
	[Event(name="onGroup", type="com.xiaomu.event.ApiEvent")]
	[Event(name="onRoom", type="com.xiaomu.event.ApiEvent")]
	
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
		
		private var pomelo:Pomelo
		private var username:String
		private var groupid:int
		
		/**
		 * 用户登录 
		 *  
		 * @param username
		 * @param password
		 */		
		public function joinGroup(username:String, groupid:int):void {
			this.username = username
			this.groupid = groupid
			pomelo = new Pomelo()
//			pomelo.init("127.0.0.1", 3014)
			pomelo.init("106.14.148.139", 3014)
			pomelo.addEventListener(PomeloEvent.HANDSHAKE, onConnectHandler);
			pomelo.addEventListener(PomeloEvent.ERROR, pomeloErrorHandler);
		}
		
		private function onConnectHandler(event:Event):void {
			if (!pomelo) return
			pomelo.request("gate.gateHandler.queryEntry", {username: this.username}, function(response:Object):void {
				pomelo.disconnect()
				pomelo.removeEventListener('handshake', onConnectHandler)
				pomelo.addEventListener('handshake', onQueryHandler)
				pomelo.addEventListener(Event.CLOSE, pomelo_closeHandler)
				pomelo.init(response.host, response.port)
			})
		}
		
		protected function pomelo_closeHandler(event:Event):void
		{
			trace('断开连接')
			pomelo = null
		}
		
		protected function pomeloErrorHandler(event:PomeloEvent):void
		{
			Alert.show('连接服务器失败')
			pomelo = null
		}
		
		private function onQueryHandler(event:Event):void {
			if (!pomelo) return
			pomelo.request('connector.entryHandler.joinGroup', {username: this.username, groupid: this.groupid},
				function(response:Object):void {
					if (response.code == 0) {
						// 登录成功
						const je:ApiEvent = new ApiEvent(ApiEvent.JOIN_GROUP_SUCCESS)
						je.data = response.data
						dispatchEvent(je)
						
						pomelo.on('onNotification', function (e: PomeloEvent): void {
							var apiEvent: ApiEvent = new ApiEvent(ApiEvent.Notification)
							apiEvent.data = e.message
							dispatchEvent(apiEvent)
						})
						pomelo.on('onGroup', function (e: PomeloEvent): void {
							var apiEvent: ApiEvent = new ApiEvent(ApiEvent.ON_GROUP)
							apiEvent.data = e.message
							dispatchEvent(apiEvent)
						})
						pomelo.on('onRoom', function (e: PomeloEvent): void {
							var apiEvent: ApiEvent = new ApiEvent(ApiEvent.ON_ROOM)
							apiEvent.data = e.message
							dispatchEvent(apiEvent)
						})
					} else {
						const jef:ApiEvent = new ApiEvent(ApiEvent.JOIN_GROUP_FAULT)
						jef.data = response.data
						dispatchEvent(jef)
					}
				})
		}
		
		public function leaveGroup():void {
			if (!pomelo) return
			pomelo.disconnect()
			pomelo = null
		}
		
		public function joinRoom(roominfo:Object, cb:Function = null):void {
			if (!pomelo) return
			pomelo.request('connector.entryHandler.joinRoom', roominfo,
				function(response:Object):void {
					if (cb) { cb(response) }
				})
		}
		
		public function leaveRoom():void {
			if (!pomelo) return
			pomelo.request('connector.entryHandler.leaveRoom', {},
				function(response:Object):void {
					if (response.code == 0) {
						
					} else {
					}
				})
		}
		
		/**
		 * 发送动作 
		 * @param action
		 */		
		public function sendAction(action):void  {
			if (!pomelo) return
			pomelo.request('chat.roomHandler.sendAction', action, function(response:Object):void {
				if (response.code == 0) {
				} else {
				}
			})
		}
		
		public function getRoomsUsers(roomnames:Array, cb:Function):void  {
			if (!pomelo) return
			pomelo.request('chat.roomHandler.getRoomsUsers', {roomnames: roomnames}, function(response:Object):void {
				if (response.code == 0) {
					cb(response.data)
				} else {
					cb([])
				}
			})
		}
		
		public function sendRoomMessage(message, cb:Function):void  {
			if (!pomelo) return
			pomelo.request('chat.roomHandler.pushMessage', {message: message}, function(response:Object):void {
				if (response.code == 0) {
					cb(response.data)
				} else {
					cb([])
				}
			})
		}
		
	}
}