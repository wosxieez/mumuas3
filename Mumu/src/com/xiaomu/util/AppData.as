package com.xiaomu.util
{
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
		public var username:String
		public var password:String
		
	}
}