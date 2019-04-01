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
		
		private static const WEB_URL:String = 'http://127.0.0.1:3888/'
		
		/**
		 * 查询登录 
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
		 * 添加玩法
		 * @param rulename
		 * @param cc
		 * @param resultHandler
		 * @param faultHandler
		 */			
		public function addRule(gid:int, rulename:String, cc:int, resultHandler:Function = null, faultHandler:Function = null):void {
			var params:Object = {}
			params.gid = gid
			params.rulename = rulename
			params.cc = cc
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
		
	}
}