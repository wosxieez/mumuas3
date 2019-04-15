package coco.event
{
	import flash.events.Event;
	
	public class TalkEvent extends Event
	{
		
		public static const SUCCESS:String = "success"
		public static const FAULT:String = 'fault'
			
		public var data:String
		
		public function TalkEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}