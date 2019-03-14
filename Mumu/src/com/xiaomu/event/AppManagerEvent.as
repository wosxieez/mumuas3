package com.xiaomu.event
{
	import flash.events.Event;
	
	public class AppManagerEvent extends Event
	{
		public function AppManagerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		/**
		 *群信息修改成功 
		 */
		public static const UPDATE_GROUP_SUCCESS:String = 'updateGroupSuccess'
			
		/**
		 *群成员信息修改成功 
		 */
		public static const UPDATE_MEMBER_INFO_SUCCESS:String = 'updateMemberInfoSuccess'
			
		/**
		 *群主自身金币数修改成功 
		 */
		public static const UPDATE_ADMIN_GOLD_SUCCESS:String = 'updateAdminGoldSuccess'
			
		/**
		 *创建群成功
		 */
		public static const CREATE_GROUP_SUCCESS:String = 'createGroupSuccess'
			
		/**
		 *添加或移除成员成功
		 */
		public static const CHANGE_MEMBER_SUCCESS:String = 'changeMemberSuccess'	
		
		/** Message用户事件信息存储*/
		public var message:Object;
	}
}