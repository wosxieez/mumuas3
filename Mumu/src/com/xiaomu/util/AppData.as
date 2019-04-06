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
		//测试数据，一把结束后的数据
		public var testData:Object = {"pn":"wosxieez3","us":[{"groupCards":[{"name":"ti","huXi":9,"cards":[2,2,2,2]},{"name":"wei","huXi":3,"cards":[10,10,10]},{"name":"wei","huXi":6,"cards":[13,13,13]},{"cards":[15,16,17],"huXi":0,"name":"chi"}],"dn":false,"handCards":[6,9,3,6,9,6,4],"username":"wosxieez3","hx":0,"upCards":[11,18,19,7,1,5],"passCards":[11,14,18,19,16,7,5,3,12,18,1,11,12,5,8,8,14,16],"ucCards":[11,18,19,7,1,5],"isReady":true}],"ad":[{"name":"ti","huXi":9,"cards":[2,2,2,2]},{"name":"wei","huXi":3,"cards":[10,10,10]},{"name":"wei","huXi":6,"cards":[13,13,13]},{"cards":[15,16,17],"huXi":0,"name":"chi"},{"name":"kan","huXi":3,"cards":[6,6,6]},{"name":"chi","huXi":0,"cards":[3,4,5]},{"name":"jiang","huXi":0,"cards":[9,9]}],"zn":"wosxieez3","pc":5,"og":true,"io":false,"ig":true,"an":"wosxieez3","at":20,"cc":1,"zc":0}
		
		public var versionNum:String="0.0.1"
		public var serverHost:String = '127.0.0.1'
		public var webUrl:String = 'http://hefeixiaomu.com:3008/'
			
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