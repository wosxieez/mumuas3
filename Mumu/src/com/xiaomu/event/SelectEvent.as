package com.xiaomu.event
{
	import flash.events.Event;
	
	public class SelectEvent extends Event
	{
		
		public static const SELECTED:String = "selected";
		
		public function SelectEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public var data:Object
		
	}
}