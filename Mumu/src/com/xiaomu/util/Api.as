package com.xiaomu.util
{
	import com.xiaomu.event.ApiEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import coco.component.Alert;
	
	import org.idream.pomelo.Pomelo;
	import org.idream.pomelo.PomeloEvent;
	
	[Event(name="notification", type="com.xiaomu.event.ApiEvent")]
	
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
		private var roomname:String
		private var roominfo:Object
		private var isJoinRoom:Boolean = false
		
		public function createRoom(roomname:String, roominfo:Object, username:String):void {
			this.username = username
			this.roominfo = roominfo
			this.roomname = roomname
			this.isJoinRoom = false
			
			// 第一步去连接服务器
			pomelo.init("127.0.0.1", 3014)
			//			pomelo.init("106.14.148.139", 3014)
			pomelo.addEventListener(PomeloEvent.HANDSHAKE, onConnectHandler);
			pomelo.addEventListener(PomeloEvent.ERROR, pomeloErrorHandler);
		}
		
		public function joinRoom(roomname:String, username:String):void {
			this.username = username
			this.roomname = roomname
			this.isJoinRoom = true
			
			// 第一步去连接服务器
			pomelo.init("127.0.0.1", 3014)
			//			pomelo.init("106.14.148.139", 3014)
			pomelo.addEventListener(PomeloEvent.HANDSHAKE, onConnectHandler);
			pomelo.addEventListener(PomeloEvent.ERROR, pomeloErrorHandler);
		}
		
		protected function pomeloErrorHandler(event:PomeloEvent):void
		{
			Alert.show('连接服务器失败')
		}
		/**
		 * 发送动作 
		 * @param action
		 */		
		public function sendAction(action):void  {
			pomelo.request('chat.roomHandler.sendAction', action)
		}
		
		private function onConnectHandler(event:Event):void {
			// 第二步 连接上服务器 开始去查询入口服务器
			pomelo.request("gate.gateHandler.queryEntry", {username: this.username}, function(response:Object):void {
				pomelo.disconnect()
				// 第三步 连接入口服务器
				pomelo.removeEventListener('handshake', onConnectHandler)
				pomelo.addEventListener('handshake', onQueryHandler)
				pomelo.init(response.host, response.port)
			});
		}
		
		private function onQueryHandler(event:Event):void {
			// 第四步 入口服务器连接成功 开始创建房间
			var route:String
			var param:Object
			if (isJoinRoom) {
				route = 'connector.entryHandler.joinRoom'
				param = {roomname: this.roomname, username: this.username}
			} else {
				route = 'connector.entryHandler.createRoom'
				param = {roomname: this.roomname, roominfo: this.roominfo, username: this.username}
			}
			pomelo.request(route, param,
				function(response:Object):void {
					Alert.show(JSON.stringify(response))
					if (response.code == 0) {
						// 创建房间成功
						pomelo.on('onNotification', function (e: PomeloEvent): void {
							var apiEvent: ApiEvent = new ApiEvent(ApiEvent.Notification)
							apiEvent.notification = e.message
							dispatchEvent(apiEvent)
						})
					}
				})
		}
		
	}
}