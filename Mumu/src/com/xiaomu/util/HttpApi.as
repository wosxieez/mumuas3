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
		 * 获取用户信息 -- 根据用户名
		 * @param username
		 * @param resultHandler
		 * @param faultHandler
		 */
		public function getUserInfoByName(username:String, 
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
		 * 获取用户信息 -- 根据用户id
		 * @param userid
		 * @param resultHandler
		 * @param faultHandler
		 */
		public function getUserInfoById(userid:int, 
										resultHandler:Function = null, 
										faultHandler:Function = null):void
		{
			var params:Object = {id: userid}
			var urlrequest:URLRequest = new URLRequest(WEB_URL + 'find_user');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		/**
		 * 添加用户---用于用户注册
		 * @param username
		 * @param password
		 * @param resultHandler
		 * @param faultHandler
		 */
		public function addUser(username:String,
								password:String,
								resultHandler:Function = null, 
								faultHandler:Function = null):void
		{
			var params:Object = {'username': username,'password':password}
			var urlrequest:URLRequest = new URLRequest(WEB_URL + 'insert_user');
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
		
		
		/**
		 * 根据群id，获取群信息
		 * @param group_id
		 * @param resultHandler
		 * @param faultHandler
		 */
		public function getGroupInfoByGroupId(group_id:int,
											  resultHandler:Function = null, 
											  faultHandler:Function = null):void
		{
			var params:Object = {'id':group_id}
			var urlrequest:URLRequest = new URLRequest(WEB_URL + 'find_group');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		/**
		 * 根据群id，修该群数据
		 * @param group_id
		 * @param newParam
		 * @param resultHandler
		 * @param faultHandler
		 */
		public function updateGroupByGroupId(group_id:int,
											 newParam:Object,resultHandler:Function = null, 
											 faultHandler:Function = null):void{
			var params:Object = {update:{name: 
				newParam.group_name,remark:newParam.remark}, query:{id:group_id}}
			var urlrequest:URLRequest = new URLRequest(WEB_URL + 'update_group');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		/**
		 * 添加房间
		 * @param roomName
		 * @param groupId
		 * @param count
		 * @param resultHandler
		 * @param faultHandler
		 */
		public function addRoom(roomName:String,groupId:int,count:int,resultHandler:Function=null,faultHandler:Function=null):void{
			var params: Object = {'name':roomName,'group_id':groupId,'count':count};
			var urlrequest:URLRequest = new URLRequest(WEB_URL + 'insert_room');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		/**
		 * 签到
		 * @param today 今日日期
		 * @param userId 用户id
		 * @param resultHandler
		 * @param faultHandler
		 */
		public function updateUserCheckIn(today:String,userId:int,resultHandler:Function=null,faultHandler:Function=null):void{
			var params:Object = {update:{checkin_date: 
				today}, query:{id:userId}}
			var urlrequest:URLRequest = new URLRequest(WEB_URL + 'update_user');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		/**
		 *更新用户的房卡数 
		 * @param newRoomCardNumber 最新房卡数
		 * @param userId
		 * @param resultHandler
		 * @param faultHandler
		 */
		public function updateUserRoomCard(newRoomCardNumber:int,userId:int,resultHandler:Function=null,faultHandler:Function=null):void{
			var params:Object = {update:{room_card: 
				newRoomCardNumber}, query:{id:userId}}
			var urlrequest:URLRequest = new URLRequest(WEB_URL + 'update_user');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
	}
}