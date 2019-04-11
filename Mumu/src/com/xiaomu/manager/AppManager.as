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
	[Event(name="changeSelectedRule", type="com.xiaomu.event.AppManagerEvent")]
	[Event(name="changeRoomTableImg", type="com.xiaomu.event.AppManagerEvent")]
	[Event(name="leaveGroupRoom", type="com.xiaomu.event.AppManagerEvent")]
	[Event(name="fixRoom", type="com.xiaomu.event.AppManagerEvent")]
	[Event(name="updateGroupRulesSuccess", type="com.xiaomu.event.AppManagerEvent")]
	[Event(name="createGroupSuccess", type="com.xiaomu.event.AppManagerEvent")]
	[Event(name="refreshGroupData", type="com.xiaomu.event.AppManagerEvent")]
	[Event(name="forceLeave", type="com.xiaomu.event.AppManagerEvent")]
	
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