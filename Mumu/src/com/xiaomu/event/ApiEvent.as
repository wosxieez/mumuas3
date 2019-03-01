package com.xiaomu.event
{
	import flash.events.Event;
	
	public class ApiEvent extends Event
	{
		
		public static const Notification:String = 'notification'
		public static const LOGIN_SUCCESS:String = 'loginSuccess'
		public static const LOGIN_FAULT:String = 'loginFault'
			
		public static const GET_GROUPS_SUCCESS:String = 'getGroupsSuccess'
		public static const GET_GROUPS_FAULT:String = 'getGroupsFault'
			
		public static const GET_ROOMS_SUCCESS:String = 'getRoomsSuccess'
		public static const GET_ROOMS_FAULT:String = 'getRoomsFault'
			
		public var notification: Object
		public var data:Object
		
		public function ApiEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}