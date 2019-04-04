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
		
		public var user:Object  // 当前用户
		public var group:Object // 当前群
		public var groupLL:int;//你在当前群中的等级 0普通，1二级管理员，2一级管理员，3副馆主，4馆主
		public var rule:Object  // 当前玩法
		public var allRules:Array //该群中的所有玩法
		public var groupUsers:Array;//当前群中的所有成员
		
		
		public function get gameMusicValue():String
		{
			if (getShareObjectValue("gameMusicValue")) {
				return getShareObjectValue("gameMusicValue")
			} else {
				return '100'
			}
		}
		
		public function set gameMusicValue(value:String):void
		{
			setShareObjectValue("gameMusicValue", value);
		}
		
		public function get bgmValue():String
		{
			if (getShareObjectValue("bgmValue")) {
				return getShareObjectValue("bgmValue")
			} else {
				return '100'
			}
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