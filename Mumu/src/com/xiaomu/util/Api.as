package com.xiaomu.util
{
	import com.xiaomu.component.AppAlert;
	import com.xiaomu.component.Loading;
	import com.xiaomu.event.ApiEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.idream.pomelo.Pomelo;
	import org.idream.pomelo.PomeloEvent;
	
	[Event(name="notification", type="com.xiaomu.event.ApiEvent")]
	[Event(name="onGroup", type="com.xiaomu.event.ApiEvent")]
	[Event(name="onRoom", type="com.xiaomu.event.ApiEvent")]
	[Event(name="onGroupRoom", type="com.xiaomu.event.ApiEvent")]
	
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
		private var cb:Function
		
		/**
		 * 用户登录 
		 *  
		 * @param username
		 * @param password
		 */		
		public function joinGroup(username:String, groupid:int, cb:Function):void {
			disconnect()
			this.username = username
			this.groupid = groupid
			this.cb = cb
			pomelo = new Pomelo()
			pomelo.init(AppData.getInstane().serverHost, 3014)
//			pomelo.init('127.0.0.1', 3014)
//			pomelo.init('114.115.165.189', 3014)	
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
			Loading.getInstance().close()
		}
		
		protected function pomeloErrorHandler(event:PomeloEvent):void
		{
			cb({code: 401, data:'连接服务器失败'})
			pomelo = null
			Loading.getInstance().close()
		}
		
		private function onQueryHandler(event:Event):void {
			if (!pomelo) return
			pomelo.request('connector.entryHandler.joinGroup', {username: this.username, groupid: this.groupid},
				function(response:Object):void {
					cb(response)
					
					if (response.code == 0) {
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
					}
				})
		}
		
		/**
		 * 查询状态 
		 * @param cb
		 * 
		 */		
		public function queryGroupStatus(cb:Function):void  {
			if (!pomelo) {
				cb({code:404, data: '服务已断开，请重新登录'})
				return
			}
			pomelo.request('connector.entryHandler.queryGroupStatus', {}, function(response:Object):void {
				cb(response)
			})
		}
		
		/**
		 * 离开群 
		 * 
		 */		
		public function leaveGroup():void {
			this.username = null
			this.groupid = -1
			this.cb = null
			if (!pomelo) return
			pomelo.disconnect()
			pomelo = null
		}
		
		/**
		 * 创建房间 
		 * @param rule
		 * @param cb
		 */		
		public function createRoom(rule:Object, cb:Function):void {
			if (!pomelo) {
				cb({code:404, data: '服务已断开，请重新登录'})
				return
			}
			pomelo.request('connector.entryHandler.createRoom', rule,
				function(response:Object):void {
					cb(response)
				})
		}
		
		/**
		 * 加入房间 
		 * @param room
		 * @param cb
		 */		
		public function joinRoom(room:Object, cb:Function):void {
			if (!pomelo) {
				cb({code:404, data: '服务已断开，请重新登录'})
				return
			}
			pomelo.request('connector.entryHandler.joinRoom', room,
				function(response:Object):void {
					cb(response)
				})
		}
		
		/**
		 * 离开房间 
		 * @param cb
		 */		
		public function leaveRoom(cb:Function):void {
			if (!pomelo) {
				cb({code:404, data: '服务已断开，请重新登录'})
				return
			}
			pomelo.request('connector.entryHandler.leaveRoom', {},
				function(response:Object):void {
					cb(response)
				})
		}
		
		/**
		 * 查询状态 
		 * @param cb
		 * 
		 */		
		public function queryRoomStatus(cb:Function):void  {
			if (!pomelo) {
				cb({code:404, data: '服务已断开，请重新登录'})
				return
			}
			pomelo.request('connector.entryHandler.queryRoomStatus', {}, function(response:Object):void {
				cb(response)
			})
		}
		
		/**
		 * 断开连接 
		 * 
		 */		
		public function disconnect():void {
			if (!pomelo) return
			pomelo.disconnect()
			pomelo = null
			trace('已断开服务连接')
		}
		
		/**
		 * 发送动作 
		 * @param action
		 */		
		public function sendAction(action):void  {
			if (!pomelo) {
				AppAlert.show('服务已断开，请重新登录')
				return
			}
			pomelo.request('chat.roomHandler.sendAction', action, function(response:Object):void {
			})
		}
		
		/**
		 * 发送房间消息 
		 * @param message
		 * @param cb
		 * 
		 */		
		public function sendRoomMessage(data:Object, cb:Function):void  {
			if (!pomelo) {
				cb({code:404, data: '服务已断开，请重新登录'})
				return
			}
			pomelo.request('chat.roomHandler.pushMessage', data, function(response:Object):void {
				cb(response)
			})
		}
		
	}
}