package com.xiaomu.util
{
	import flash.net.SharedObject;

	public class AppData
	{
		public function AppData()
		{
		}
		
		private static var instance:AppData
		
		public static function getInstane(): AppData {
			if (!instance) {
				instance = new AppData()
			}
			
			return instance
		}
		
		public var user:Object
		
		/**
		 *你是不是当前进入的群的群主 
		 *默认 不是这个群的群主
		 */
		public var isNowGroupAdmin:Boolean=false;
		
		/**
		 *用户当前有没有进入 groupView
		 */
		public var inGroupView:Boolean=false
			
		public function get gameMusicValue():String
		{
			return getShareObjectValue("gameMusicValue");
		}
		
		public function set gameMusicValue(value:String):void
		{
			setShareObjectValue("gameMusicValue", value);
		}
		
		public function get bgmValue():String
		{
			return getShareObjectValue("bgmValue");
		}
		
		public function set bgmValue(value:String):void
		{
			setShareObjectValue("bgmValue", value);
		}
		
		public function get username():String
		{
			return getShareObjectValue("username");
		}
		
		public function set username(value:String):void
		{
			setShareObjectValue("username", value);
		}
		
		public function get password():String
		{
			return getShareObjectValue("password");
		}
		
		public function set password(value:String):void
		{
			setShareObjectValue("password", value);
		}
		
		//--------------------------------------------------------------------------
		//
		//  SharedObject Value
		//
		//--------------------------------------------------------------------------
		
		public function setShareObjectValue(key:String, value:String):void
		{
			SharedObject.getLocal("mumu").data[key] = value;
			SharedObject.getLocal("mumu").flush();
		}
		
		public function getShareObjectValue(key:String):String
		{
			if (SharedObject.getLocal("mumu").data[key] != undefined)
				return SharedObject.getLocal("mumu").data[key];
			else
				return null;
		}
		
	}
}