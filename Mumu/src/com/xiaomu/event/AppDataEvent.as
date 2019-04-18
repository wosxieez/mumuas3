package com.xiaomu.event
{
	import flash.events.Event;
	
	public class AppDataEvent extends Event
	{
		
		public static const USER_DATA_CHAGNED:String = 'userDataChanged'
		
		public function AppDataEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}