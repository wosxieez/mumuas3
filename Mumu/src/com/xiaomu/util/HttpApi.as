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
		
//		private static const WEB_URL:String = 'http://192.168.1.154:3888/'
		private static const WEB_URL:String = 'http://172.20.10.3:3888/'
		
			
		/**
		 * 添加用户 
		 * @param resultHandler
		 * @param faultHandler
		 * 
		 */			
		public function addUser(params:Object, resultHandler:Function = null, faultHandler:Function = null):void
		{
			var urlrequest:URLRequest = new URLRequest(WEB_URL + 'inster_user');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		/**
		 * 查询用户 
		 * @param resultHandler
		 * @param faultHandler
		 * 
		 */			
		public function getUser(params:Object, resultHandler:Function = null, faultHandler:Function = null):void
		{
			var urlrequest:URLRequest = new URLRequest(WEB_URL + 'find_user');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		/**
		 * 更新用户 
		 * @param resultHandler
		 * @param faultHandler
		 * 
		 */			
		public function updateUser(params:Object, resultHandler:Function = null, faultHandler:Function = null):void
		{
			var urlrequest:URLRequest = new URLRequest(WEB_URL + 'update_user');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		/**
		 * 移除用户 
		 * @param resultHandler
		 * @param faultHandler
		 * 
		 */			
		public function removeUser(params:Object, resultHandler:Function = null, faultHandler:Function = null):void
		{
			var urlrequest:URLRequest = new URLRequest(WEB_URL + 'remove_user');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		/**
		 * 添加群组
		 * @param groupname 群名称
		 * @param fc 房卡数
		 * @param resultHandler
		 * @param faultHandler
		 */		
		public function addGroup(params:Object, resultHandler:Function = null, faultHandler:Function = null):void {
			var urlrequest:URLRequest = new URLRequest(WEB_URL + 'insert_group');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		/**
		 * 获取群组 
		 * @param params
		 * @param resultHandler
		 * @param faultHandler
		 * 
		 */		
		public function getGroup(params:Object, resultHandler:Function = null, faultHandler:Function = null):void
		{
			var urlrequest:URLRequest = new URLRequest(WEB_URL + 'find_group');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		/**
		 * 更新群组
		 * @param groupname 群名称
		 * @param fc 房卡数
		 * @param resultHandler
		 * @param faultHandler
		 */		
		public function updateGroup(params:Object, resultHandler:Function = null, faultHandler:Function = null):void {
			var urlrequest:URLRequest = new URLRequest(WEB_URL + 'update_group');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		/**
		 * 移除群组
		 * @param groupname 群名称
		 * @param fc 房卡数
		 * @param resultHandler
		 * @param faultHandler
		 */		
		public function removeGroup(params:Object, resultHandler:Function = null, faultHandler:Function = null):void {
			var urlrequest:URLRequest = new URLRequest(WEB_URL + 'remove_group');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		
		/**
		 * 添加群组用户
		 * gid: uid: pid: fs: ll:
		 * @param resultHandler
		 * @param faultHandler
		 */		
		public function addGroupUser(params:Object, resultHandler:Function = null, faultHandler:Function = null):void {
			var urlrequest:URLRequest = new URLRequest(WEB_URL + 'insert_groupuser');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		/**
		 * 获取群成员
		 * @param gid
		 * @param resultHandler
		 * @param faultHandler
		 * 
		 */		
		public function getGroupUser(params:Object, resultHandler:Function = null, faultHandler:Function = null):void {
			var urlrequest:URLRequest = new URLRequest(WEB_URL + 'find_groupuser');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		/**
		 * 更新群成员
		 * @param gid
		 * @param resultHandler
		 * @param faultHandler
		 */		
		public function updateGroupUser(params:Object, resultHandler:Function = null, faultHandler:Function = null):void {
			var urlrequest:URLRequest = new URLRequest(WEB_URL + 'update_groupuser');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		/**
		 * 删除群成员
		 * @param gid
		 * @param resultHandler
		 * @param faultHandler
		 */		
		public function removeGroupUser(params:Object, resultHandler:Function = null, faultHandler:Function = null):void {
			var urlrequest:URLRequest = new URLRequest(WEB_URL + 'remove_groupuser');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		/**
		 * 添加玩法
		 * @param rulename
		 * @param cc
		 * @param resultHandler
		 * @param faultHandler
		 */			
		public function addRule(params:Object, resultHandler:Function = null, faultHandler:Function = null):void {
			var urlrequest:URLRequest = new URLRequest(WEB_URL + 'insert_rule');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		/**
		 * 获取群玩法
		 * @param params
		 * @param resultHandler
		 * @param faultHandler
		 */			
		public function getRule(params:Object, resultHandler:Function = null, faultHandler:Function = null):void {
			var urlrequest:URLRequest = new URLRequest(WEB_URL + 'find_rule');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		/**
		 * 更新玩法
		 * @param rulename
		 * @param cc
		 * @param resultHandler
		 * @param faultHandler
		 */			
		public function updateRule(params:Object, resultHandler:Function = null, faultHandler:Function = null):void {
			var urlrequest:URLRequest = new URLRequest(WEB_URL + 'update_rule');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		/**
		 * 删除玩法
		 * @param rulename
		 * @param cc
		 * @param resultHandler
		 * @param faultHandler
		 */			
		public function removeRule(params:Object, resultHandler:Function = null, faultHandler:Function = null):void {
			var urlrequest:URLRequest = new URLRequest(WEB_URL + 'remove_rule');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
	}
}