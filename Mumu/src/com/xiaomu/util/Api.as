package com.xiaomu.util
{
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
	[Event(name="joinRoom", type="com.xiaomu.event.ApiEvent")]
	
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
		private var savedUsername:String = null
		private var savedGroupid:int = -1
		private var savedRoomname:String = null
		private var savedCallback:Function
		
		private var isReconnect:Boolean = false
		private var reconnectAction:Object = null
		
		/**
		 * 用户登录 
		 *  
		 * @param username
		 * @param password
		 */		
		public function joinGroup(username:String, groupid:int, cb:Function):void {
			trace('手动连接服务器...')
			disconnect()
			isReconnect = false
			savedUsername = username
			savedGroupid = groupid
			savedCallback = cb
			pomelo = new Pomelo()
			// 如果群有独立的服务器进入独立的服务器
			var server:String 
			if (AppData.getInstane().group && AppData.getInstane().group.ss && AppData.getInstane().group.ss.length > 0) {
				server = AppData.getInstane().group.ss
			} else {
				server = AppData.getInstane().serverHost
			}
			// test
//			server ='127.0.0.1'
			trace('战斗服务器地址...', server)
			pomelo.init(server, 3014)
			pomelo.addEventListener(PomeloEvent.HANDSHAKE, onConnectHandler);
			pomelo.addEventListener(PomeloEvent.ERROR, pomeloErrorHandler);
		}
		
		
		/**
		 * 重连
		 *  
		 * @param username
		 * @param password
		 */		
		public function reJoinGroup():void {
			disconnect()
			isReconnect = true
			trace('正在重连服务器...')
			pomelo = new Pomelo()
			// 如果群有独立的服务器进入独立的服务器
			var server:String 
			if (AppData.getInstane().group && AppData.getInstane().group.ss && AppData.getInstane().group.ss.length > 0) {
				server = AppData.getInstane().group.ss
			} else {
				server = AppData.getInstane().serverHost
			}
			// test
//			server ='127.0.0.1'
			trace('战斗服务器地址...', server)
			pomelo.init(server, 3014)
			pomelo.addEventListener(PomeloEvent.HANDSHAKE, onConnectHandler);
			pomelo.addEventListener(PomeloEvent.ERROR, pomeloErrorHandler);
		}
		
		private function onConnectHandler(event:Event):void {
			pomelo.request("gate.gateHandler.queryEntry", {username: savedUsername}, function(response:Object):void {
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
			if (isReconnect) trace('正在重连...失败')
			if (savedCallback != null && !isReconnect) {
				savedCallback({code: 401, data:'连接服务器失败'})
			}
			pomelo = null
			Loading.getInstance().close()
		}
		
		private function onQueryHandler(event:Event):void {
			pomelo.request('connector.entryHandler.joinGroup', {username: savedUsername, groupid: savedGroupid},
				function(response:Object):void {
					if (!isReconnect && savedCallback != null) { savedCallback(response) }
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
						
						// 看是不是重连 如果是重连切有房间号 自动加入房间
						if (isReconnect) {
							trace('正在重连...加入群成功', savedRoomname)
							if (savedRoomname) {
								reJoinRoom(savedRoomname)
							}
						} 
						else {
							trace('手动连接...加入群成功')
						} 
					} else {
						if (isReconnect) trace('正在重连...加入群失败')
						else trace('手动连接...加入群失败')
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
				reconnect()
				cb({code: 404, data: '服务已断开，正在重连中...'})
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
			this.savedUsername = null
			this.savedGroupid = -1
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
				reconnect()
				cb({code: 404, data: '服务已断开，正在重连中...'})
				return
			}
			pomelo.request('connector.entryHandler.createRoom', rule,
				function(response:Object):void {
					cb(response)
					
					// 记录加入的房间号
					if (response.code == 0) {
						savedRoomname = response.data.rn
					} else {
						savedRoomname = null
					}
				})
		}
		
		/**
		 * 加入房间 
		 * @param room
		 * @param cb
		 */		
		public function joinRoom(roomname:String, cb:Function):void {
			if (!pomelo) {
				reconnect()
				cb({code: 404, data: '服务已断开，正在重连中...'})
				return
			}
			pomelo.request('connector.entryHandler.joinRoom', {roomname: roomname},
				function(response:Object):void {
					cb(response)
					// 记录加入的房间号
					if (response.code == 0) {
						trace('手动连接...加入房间成功')
						savedRoomname = response.data.rn
						dispatchEvent(new ApiEvent(ApiEvent.JOIN_ROOM))
					} else {
						savedRoomname = null
						trace('手动连接...加入房间失败')
					}
				})
		}
		
		/**
		 * 重连房间
		 * @param room
		 * @param cb
		 */		
		public function reJoinRoom(roomname:String):void {
			pomelo.request('connector.entryHandler.joinRoom', {roomname: roomname},
				function(response:Object):void {
					if (response.code == 0) {
						trace('正在重连...加入房间成功')
						dispatchEvent(new ApiEvent(ApiEvent.JOIN_ROOM))
						if (reconnectAction) sendAction(reconnectAction)
					} else {
						trace('正在重连...加入房间失败')
					}
				})
		}
		
		/**
		 * 离开房间 
		 * @param cb
		 */		
		public function leaveRoom(cb:Function):void {
			savedRoomname = null
			if (!pomelo) return
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
			if (!pomelo) { reconnect(); return }
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
			trace('手动断开服务器连接')
		}
		
		/**
		 * 发送动作 
		 * @param action
		 */		
		public function sendAction(action:Object):void  {
			if (!pomelo) { reconnect(action); return }
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
			if (!pomelo) { reconnect(); return }
			pomelo.request('chat.roomHandler.pushMessage', data, function(response:Object):void {
				cb(response)
			})
		}
		
		public function checkReconnect():void {
			if (savedGroupid >= 0 && savedUsername && !pomelo) {
				reconnect()
			}
		}
		
		public function reconnect(action:Object = null):void {
			reconnectAction = action
			if (savedGroupid >= 0 && savedUsername) {
				// 可以重连
				reJoinGroup()
			}
		}
		
	}
}