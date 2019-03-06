package com.xiaomu.util
{
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	public class HttpApi extends EventDispatcher
	{
		public function HttpApi()
		{
		}
		
		private static var instance:HttpApi
		
		public static function getInstane(): HttpApi {
			if (!instance) {
				instance = new HttpApi()
			}
			
			return instance
		}
		
		private static const WEB_URL:String = 'http://hefeixiaomu.com:3008/'
		
		public function login(username:String, 
							  password:String,
							  resultHandler:Function = null, 
							  faultHandler:Function = null):void
		{
			var params:Object = {username:username, password:password}
			var urlrequest:URLRequest = new URLRequest(WEB_URL + 'find_user');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		public function getGroupUsers(groupid:int, 
									  resultHandler:Function = null, 
									  faultHandler:Function = null):void
		{
//			var params:Object = {group_info: {$like: '%' + groupid + '%'}}
			var params:Object = {group_info: {$like: '%"group_id":' + groupid + '%'}}
			var urlrequest:URLRequest = new URLRequest(WEB_URL + 'find_user');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		public function getGroupRooms(groupid:int, 
									  resultHandler:Function = null, 
									  faultHandler:Function = null):void
		{
			var params:Object = {group_id: groupid}
			var urlrequest:URLRequest = new URLRequest(WEB_URL + 'find_room');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		public function getUserInfo(username:String, 
									resultHandler:Function = null, 
									faultHandler:Function = null):void
		{
			var params:Object = {username: username}
			var urlrequest:URLRequest = new URLRequest(WEB_URL + 'find_user');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		public function updateUserGroupInfo(username:String, 
											group_info:Array,
											resultHandler:Function = null, 
											faultHandler:Function = null):void
		{
			var params: Object = {update:{group_info: 
				JSON.stringify(group_info)}, query:{username:username}};
			var urlrequest:URLRequest = new URLRequest(WEB_URL + 'update_user');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
	}
}