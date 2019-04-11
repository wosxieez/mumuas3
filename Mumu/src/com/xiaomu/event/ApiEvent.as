package com.xiaomu.event
{
	import flash.events.Event;
	
	public class ApiEvent extends Event
	{
		
		public static const ON_GROUP:String = 'onGroup'
		public static const ON_ROOM:String = 'onRoom'
		public static const JOIN_ROOM:String = 'joinRoom'
			
		public var data: Object
		
		public function ApiEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}