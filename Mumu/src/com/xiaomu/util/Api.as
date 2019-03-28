package com.xiaomu.util
{
	import com.xiaomu.event.ApiEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.idream.pomelo.Pomelo;
	import org.idream.pomelo.PomeloEvent;
	
	[Event(name="notification", type="com.xiaomu.event.ApiEvent")]
	
	[Event(name="joinGroupSuccess", type="com.xiaomu.event.ApiEvent")]
	[Event(name="joinGroupFault", type="com.xiaomu.event.ApiEvent")]
	
	[Event(name="joinRoomSuccess", type="com.xiaomu.event.ApiEvent")]
	[Event(name="joinRoomFault", type="com.xiaomu.event.ApiEvent")]
	
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
		private var username:String = null
		private var groupid:int = -1
		private var roominfo:Object = null
		
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
			pomelo.init("127.0.0.1", 3014)
//			pomelo.init("106.14.148.139", 3014)
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
			trace('连接群失败')
			var jef:ApiEvent = new ApiEvent(ApiEvent.JOIN_GROUP_FAULT)
			jef.data = '连接服务器失败'
			dispatchEvent(jef)
			pomelo = null
		}
		
		private function onQueryHandler(event:Event):void {
			if (!pomelo) return
			pomelo.request('connector.entryHandler.joinGroup', {username: this.username, groupid: this.groupid},
				function(response:Object):void {
					if (response.code == 0) {
						// 登录成功
						trace('连接群成功')
						var je:ApiEvent = new ApiEvent(ApiEvent.JOIN_GROUP_SUCCESS)
						je.data = response.data
						dispatchEvent(je)
						
						// 如果有房间信息 自动加入房间
						if (roominfo) {
							trace('检测到需要重连的房间信息。。。正在重连房间')
							joinRoom(roominfo)
						}
						
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
						trace('连接群失败')
						var jef:ApiEvent = new ApiEvent(ApiEvent.JOIN_GROUP_FAULT)
						jef.data = response.data
						dispatchEvent(jef)
					}
				})
		}
		
		public function leaveGroup():void {
			this.username = null
			this.groupid = -1
			trace('离开群成功')
			if (!pomelo) return
			pomelo.disconnect()
			pomelo = null
		}
		
		public function joinRoom(roominfo:Object):void {
			this.roominfo = roominfo
			if (!pomelo) {
				reconnect()
				return
			}
			pomelo.request('connector.entryHandler.joinRoom', roominfo,
				function(response:Object):void {
					if (response.code == 0) {
						trace('连接房间成功')
						var jres:ApiEvent = new ApiEvent(ApiEvent.JOIN_ROOM_SUCCESS)
						jres.data = response.data
						dispatchEvent(jres)
					} else {
						trace('连接房间失败')
						var jref:ApiEvent = new ApiEvent(ApiEvent.JOIN_ROOM_FAULT)
						jref.data = response.data
						dispatchEvent(jref)
					}
				})
		}
		
		public function leaveRoom():void {
			this.roominfo = null
			if (!pomelo) return
			pomelo.request('connector.entryHandler.leaveRoom', {},
				function(response:Object):void {
					if (response.code == 0) {
						trace('离开房间成功')
					} else {
						trace('离开房间失败')
					}
				})
		}
		
		public function resumeRoom():void {
			if (!pomelo) return
			pomelo.request('connector.entryHandler.resumeRoom', {},
				function(response:Object):void {
					if (response.code == 0) {
						trace('恢复房间成功')
					} else {
						trace('恢复房间失败')
					}
				})
		}
		
		public function disconnect():void {
			if (!pomelo) return
			pomelo.disconnect()
			pomelo = null
			trace('已断开服务连接')
		}
		
		public function reconnect():void {
			autoCheckConnection()
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
		
		
		/**
		 * 自动检查服务连接问题 
		 * 
		 */		
		public function autoCheckConnection():void {
			if (pomelo) {
				trace('检测到服务已经连接')
				return
			} else {
				trace('检测到服务未连接')
			}
			
			if (this.username && this.groupid >= 0) { 
				trace('检测到需要重连的群信息。。。正在重连')
				joinGroup(this.username, this.groupid) 
			} else {
				trace('不需要重连')
			}
		}
		
	}
}