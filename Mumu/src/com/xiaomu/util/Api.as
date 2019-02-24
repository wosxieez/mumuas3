package com.xiaomu.util
{
	import com.xiaomu.event.ApiEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
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
		private var username:String
		private var roomname:String
		private var roominfo:Object
		
		public function createRoom(roomname:String, roominfo:Object, username:String):void {
			this.username = username
			this.roominfo = roominfo
			this.roomname = roomname
			
			// 第一步去连接服务器
			pomelo.init("127.0.0.1", 3014)
			pomelo.addEventListener("handshake", onConnectHandler);
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
			pomelo.request('connector.entryHandler.createRoom', {roomname: this.roomname, roominfo: this.roominfo, username: this.username},
				function(response:Object):void {
					trace(JSON.stringify(response))
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