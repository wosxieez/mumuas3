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
			pomelo.init("127.0.0.1", 3014)
			//			pomelo.init("106.14.148.139", 3014)
			pomelo.addEventListener(PomeloEvent.HANDSHAKE, onConnectHandler);
			pomelo.addEventListener(PomeloEvent.ERROR, pomeloErrorHandler);
		}
		
		private function onConnectHandler(event:Event):void {
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
			pomelo.request('connector.entryHandler.joinGroup', {username: this.username, groupid: this.groupid},
				function(response:Object):void {
					Alert.show(JSON.stringify(response))
					if (response.code == 0) {
						// 登录成功
						pomelo.on('onNotification', function (e: PomeloEvent): void {
							var apiEvent: ApiEvent = new ApiEvent(ApiEvent.Notification)
							apiEvent.notification = e.message
							dispatchEvent(apiEvent)
						})
					} else {
					}
				})
		}
		
		public function leaveGroup():void {
			pomelo.disconnect()
			pomelo = null
		}
		
		public function joinRoom(roominfo:Object):void {
			pomelo.request('connector.entryHandler.joinRoom', roominfo,
				function(response:Object):void {
					Alert.show(JSON.stringify(response))
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
			pomelo.request('chat.roomHandler.sendAction', action)
		}
		
	}
}