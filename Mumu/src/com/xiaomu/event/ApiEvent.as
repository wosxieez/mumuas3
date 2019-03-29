package com.xiaomu.event
{
	import flash.events.Event;
	
	public class ApiEvent extends Event
	{
		
		public static const Notification:String = 'notification'
		public static const JOIN_GROUP_SUCCESS:String = 'joinGroupSuccess'
		public static const JOIN_GROUP_FAULT:String = 'joinGroupFault'
		public static const CREATE_GROUP_ROOM_SUCCESS:String = 'createGroupRoomSuccess'
		public static const CREATE_GROUP_ROOM_FAULT:String = 'createGroupRoomFault'
		public static const JOIN_GROUP_ROOM_SUCCESS:String = 'joinGroupRoomSuccess'
		public static const JOIN_GROUP_ROOM_FAULT:String = 'joinGroupRoomFault'
		public static const JOIN_ROOM_SUCCESS:String = 'joinRoomSuccess'
		public static const JOIN_ROOM_FAULT:String = 'joinRoomFault'
		public static const ON_GROUP:String = 'onGroup'
		public static const ON_GROUP_ROOM:String = 'onGroupRoom'
		public static const ON_ROOM:String = 'onRoom'
			
		public var data: Object
		
		public function ApiEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}