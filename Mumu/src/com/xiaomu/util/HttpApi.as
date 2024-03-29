package com.xiaomu.util
{
	import com.xiaomu.component.AppAlert;
	import com.xiaomu.view.other.NetErrorView;
	
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	import air.net.URLMonitor;
	
	import coco.event.UIEvent;
	
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
		
		private var monitor:URLMonitor =new URLMonitor(new URLRequest("http://hefeixiaomu.com"));  
		
		public function startMonitor():void
		{
			monitor.addEventListener(StatusEvent.STATUS, showStatus)  
			monitor.start();  
		}
		
		public function stopMonitor():void {
			monitor.removeEventListener(StatusEvent.STATUS, showStatus)  
			monitor.stop()  
		}
		
		protected function showStatus(event:StatusEvent):void
		{
			trace('网络状态', monitor.available, monitor.acceptableStatusCodes)
			if (!monitor.available) {
				AppAlert.show('网络连接断开，请检查网络设置，重新连接', "", 0x4, function (e:UIEvent):void {
					NetErrorView.getInstance().open()
				})
			}
		}
		
		public function getVersion(resultHandler:Function = null, faultHandler:Function = null):void
		{
			var urlrequest:URLRequest = new URLRequest('http://hefeixiaomu.com:3008/version_update');
			urlrequest.method = URLRequestMethod.GET
			urlrequest.contentType = 'application/json'
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		/**
		 * 登录用户 
		 * @param resultHandler
		 * @param faultHandler
		 * 
		 */			
		public function login(params:Object, resultHandler:Function = null, faultHandler:Function = null):void
		{
			var urlrequest:URLRequest = new URLRequest('http://hefeixiaomu.com:3008/login');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		/**
		 * 添加用户 
		 * @param resultHandler
		 * @param faultHandler
		 * 
		 */			
		public function addUser(params:Object, resultHandler:Function = null, faultHandler:Function = null):void
		{
			var urlrequest:URLRequest = new URLRequest('http://hefeixiaomu.com:3008/insert_user');
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
			var urlrequest:URLRequest = new URLRequest(AppData.getInstane().webUrl + 'find_user');
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
		public function getUser2(params:Object, resultHandler:Function = null, faultHandler:Function = null):void
		{
			var urlrequest:URLRequest = new URLRequest(AppData.getInstane().webUrl + 'find_user2');
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
			var urlrequest:URLRequest = new URLRequest(AppData.getInstane().webUrl + 'update_user');
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
			var urlrequest:URLRequest = new URLRequest(AppData.getInstane().webUrl + 'remove_user');
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
			var urlrequest:URLRequest = new URLRequest(AppData.getInstane().webUrl + 'insert_group');
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
			var urlrequest:URLRequest = new URLRequest(AppData.getInstane().webUrl + 'find_group');
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
			var urlrequest:URLRequest = new URLRequest(AppData.getInstane().webUrl + 'update_group');
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
			var urlrequest:URLRequest = new URLRequest(AppData.getInstane().webUrl + 'remove_group');
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
			var urlrequest:URLRequest = new URLRequest(AppData.getInstane().webUrl + 'insert_groupuser');
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
			var urlrequest:URLRequest = new URLRequest(AppData.getInstane().webUrl + 'find_groupuser');
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
			var urlrequest:URLRequest = new URLRequest(AppData.getInstane().webUrl + 'update_groupuser');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		/**
		 * 上分操作
		 * @param gid
		 * @param resultHandler
		 * @param faultHandler
		 */		
		public function addGroupUserScore(gid:int, tid:int, tn:String, fid:int, fn:String, ss:Number,
										  resultHandler:Function = null, faultHandler:Function = null):void {
			var urlrequest:URLRequest = new URLRequest(AppData.getInstane().webUrl + 'update_gus');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify({gid: gid, tid: tid, tn: tn, fid: fid, fn: fn, ss: ss})
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
			var urlrequest:URLRequest = new URLRequest(AppData.getInstane().webUrl + 'remove_groupuser');
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
			var urlrequest:URLRequest = new URLRequest(AppData.getInstane().webUrl + 'insert_rule');
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
			var urlrequest:URLRequest = new URLRequest(AppData.getInstane().webUrl + 'find_rule');
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
			var urlrequest:URLRequest = new URLRequest(AppData.getInstane().webUrl + 'update_rule');
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
			var urlrequest:URLRequest = new URLRequest(AppData.getInstane().webUrl + 'remove_rule');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		/**
		 * 查询战绩记录（和上下分记录）
		 * @param resultHandler
		 * @param faultHandler
		 * 
		 */			
		public function getfight(params:Object, resultHandler:Function = null, faultHandler:Function = null):void
		{
			var urlrequest:URLRequest = new URLRequest(AppData.getInstane().webUrl + 'find_fight');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		/**
		 * 签到
		 * @param params
		 * @param resultHandler
		 * @param faultHandler
		 */
		public function checkIn(params:Object, resultHandler:Function = null, faultHandler:Function = null):void
		{
			var urlrequest:URLRequest = new URLRequest(AppData.getInstane().webUrl + 'get_check_in');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		/**
		 *玩家申请加入群的记录表
		 * @param params
		 * @param resultHandler
		 * @param faultHandler
		 */
		public function joinApplyrecord(params:Object, resultHandler:Function = null, faultHandler:Function = null):void
		{
			var urlrequest:URLRequest = new URLRequest(AppData.getInstane().webUrl + 'insert_applyrecord');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		/**
		 * 查询申请记录表
		 * @param params
		 * @param resultHandler
		 * @param faultHandler
		 */
		public function findApplyrecord(params:Object, resultHandler:Function = null, faultHandler:Function = null):void
		{
			var urlrequest:URLRequest = new URLRequest(AppData.getInstane().webUrl + 'find_applyrecord');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		/**
		 * 更新申请记录表
		 * @param params
		 * @param resultHandler
		 * @param faultHandler
		 */
		public function updateApplyrecord(params:Object, resultHandler:Function = null, faultHandler:Function = null):void
		{
			var urlrequest:URLRequest = new URLRequest(AppData.getInstane().webUrl + 'update_applyrecord');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify(params)
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
		
		/**
		 * @param resultHandler
		 * @param faultHandler
		 */			
		public function getNotice(resultHandler:Function = null, faultHandler:Function = null):void
		{
			var urlrequest:URLRequest = new URLRequest(AppData.getInstane().webUrl + 'get_notice');
			urlrequest.method = URLRequestMethod.GET
			urlrequest.contentType = 'application/json'
			var urlLoader:CocoURLLoader = new CocoURLLoader(resultHandler, faultHandler, true, 20000);
			urlLoader.load(urlrequest)
		}
	}
}