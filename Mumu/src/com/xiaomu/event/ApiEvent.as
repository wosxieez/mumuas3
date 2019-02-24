package com.xiaomu.event
{
	import flash.events.Event;
	
	public class ApiEvent extends Event
	{
		
		public static const Notification:String = 'notification'
			
		public var notification: Object
		
		public function ApiEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}