package com.xiaomu.manager
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	///事件绑定
	[Event(name="testEvent", type="com.xiaomu.event.AppManagerEvent")]
	[Event(name="updateGroupSuccess", type="com.xiaomu.event.AppManagerEvent")]
	[Event(name="updateMemberInfoSuccess", type="com.xiaomu.event.AppManagerEvent")]
	[Event(name="updateAdminGoldSuccess", type="com.xiaomu.event.AppManagerEvent")]
	[Event(name="changeMemberSuccess", type="com.xiaomu.event.AppManagerEvent")]
	public class AppManager extends EventDispatcher
	{
		public function AppManager(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		private static var instance:AppManager;
		
		public static function getInstance():AppManager
		{
			if (!instance){instance = new AppManager();}
			return instance;
		}
	}
}