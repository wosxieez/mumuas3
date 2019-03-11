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
		
		/**
		 * 获取加入过该组的所有人员
		 * @param groupid
		 * @param resultHandler
		 * @param faultHandler
		 */
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
		
		/**
		 * 获取用户信息
		 * @param username
		 * @param resultHandler
		 * @param faultHandler
		 */
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
		
		/**
		 * 修改用户的组信息---用户更新金币-更新加入组群等操作
		 * @param username
		 * @param group_info
		 * @param resultHandler
		 * @param faultHandler
		 */
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
		
		/**
		 * 创建组群
		 * @param groupName
		 * @param adminId
		 * @param resultHandler
		 * @param faultHandler
		 */
		public function insertGroupInfo(groupName:String,
										adminId:int,
										resultHandler:Function = null, 
										faultHandler:Function = null):void
		{
			var params: Object = {'name':groupName,'admin_id':adminId};
			var urlrequest:URLRequest = new URLRequest(WEB_URL + 'insert_group');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		/**
		 * 获取所有组群信息
		 * @param resultHandler
		 * @param faultHandler
		 */
		public function getAllGroupInfo( 
			resultHandler:Function = null, 
			faultHandler:Function = null):void
		{
			var params:Object = {}
			var urlrequest:URLRequest = new URLRequest(WEB_URL + 'find_group');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
	}
}