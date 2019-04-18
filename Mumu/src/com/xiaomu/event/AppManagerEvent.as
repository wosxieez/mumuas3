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
			
		/**
		 *添加或修改 群里的玩法成功 
		 */
		public static const UPDATE_GROUP_RULES_SUCCESS:String = 'updateGroupRulesSuccess';
			
		/**
		 *改变了当前选择的玩法
		 */
		public static const CHANGE_SELECTED_RULE:String = 'changeSelectedRule'	
			
		/**
		 *修改房间桌布 
		 */
		public static const CHANGE_ROOM_TABLE_IMG:String = 'changeRoomTableImg';
		
		/**
		 *离开群房间
		 */
		public static const LEAVE_GROUP_ROOM:String = 'leaveGroupRoom';
		
		/**
		 */
		public static const FIX_ROOM:String = 'fixRoom';
		
		/**
		 *强制退出房间
		 */
		public static const FORCE_LEAVE:String='forceLeave'
		
		/**
		 *刷新群信息 
		 */
		public static const REFRESH_GROUP_DATA:String = 'refreshGroupData'
			
		/**
		 *刷新用户信息 --A界面中请求过后，通知B界面重新赋值。不再重新请求
		 */
		public static const REFRESH_USER_INFO:String = 'refreshUserInfo'
			
		/**
		 *获取用户信息 --从数据库请求
		 */
		public static const GET_USER_INFO:String = 'getUserInfo'
			
		/**
		 *修改了申请表成功--一般是群主同意或拒绝操作后。更新申请表信息
		 */
		public static const CHANGE_APPLY_SUCCESS:String = 'changeApplySuccess'
		
		/** Message用户事件信息存储*/
		public var message:Object;
	}
}