package com.xiaomu.event
{
	import flash.events.Event;
	
	public class ApiEvent extends Event
	{
		
		public static const Notification:String = 'notification'
		public static const JOIN_GROUP_SUCCESS:String = 'joinGroupSuccess'
		public static const JOIN_GROUP_FAULT:String = 'joinGroupFault'
		public static const ON_GROUP:String = 'onGroup'
			
		public var data: Object
		
		public function ApiEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}