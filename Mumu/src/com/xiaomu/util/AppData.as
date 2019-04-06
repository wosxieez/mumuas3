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
		public var testData2:Object = {"us":[{"groupCards":[{"name":"wei","cards":[10,10,10]},{"name":"wei","cards":[20,20,20]},{"name":"wei","cards":[12,12,12]}],"hx":-10,"dn":false,"ucCards":[2,15,4,7,15,14,18],"isReady":false,"handCards":[14,5,11,19,13,9,6,4,9,19,13],"passCards":[2,15,1,4,8,7,15,7,6,14,15,8,2,5,6,18,11,14,8,15],"username":"wosxieez3","upCards":[2,4,15,18],"thx":54},{"groupCards":[{"name":"wei","cards":[10,10,10]},{"name":"wei","cards":[20,20,20]},{"name":"wei","cards":[12,12,12]}],"hx":-10,"dn":false,"ucCards":[2,15,4,7,15,14,18],"isReady":false,"handCards":[14,5,11,19,13,9,6,4,9,19,13],"passCards":[2,15,1,4,8,7,15,7,6,14,15,8,2,5,6,18,11,14,8,15],"username":"wosxieez","upCards":[2,4,15,18],"thx":54}],"pn":"wosxieez3","og":true,"ig":false,"aus":[],"zn":"wosxieez3","io":false,"pc":0,"cc":0,"zc":0}
		public var testDataHu:Object = {"pn":"wosxieez3","io":false,"hn":"wosxieez3","aus":[],"zn":"wosxieez3","hts":[2,3],"us":[{"upCards":[11],"thx":30,"handCards":[],"dn":false,"passCards":[11],"groupCards":[{"name":"kan","cards":[12,12,12],"huXi":6},{"name":"kan","cards":[14,14,14],"huXi":6},{"name":"chi","cards":[1,2,3],"huXi":3},{"name":"chi","cards":[3,4,5],"huXi":0},{"name":"chi","cards":[6,7,8],"huXi":0},{"name":"chi","cards":[9,19,19],"huXi":0},{"name":"chi","cards":[15,16,17],"huXi":0}],"username":"wosxieez3","isReady":false,"hx":30,"ucCards":[11]}],"zc":0,"cc":18,"og":true,"ig":false,"pc":17}
		public var testDataHu2:Object={"pn":"wosxieez3","io":false,"hn":"wosxieez","aus":[],"zn":"wosxieez3","hts":[2,1,3],"us":[{"upCards":[11],"thx":30,"handCards":[],"dn":false,"passCards":[11],"groupCards":[{"name":"kan","cards":[12,12,12],"huXi":6},{"name":"kan","cards":[14,14,14],"huXi":6},{"name":"chi","cards":[1,2,3],"huXi":3},{"name":"chi","cards":[3,4,5],"huXi":0},{"name":"chi","cards":[6,7,8],"huXi":0},{"name":"chi","cards":[9,19,19],"huXi":0},{"name":"chi","cards":[15,16,17],"huXi":0}],"username":"wosxieez3","isReady":false,"hx":30,"ucCards":[11]},{"upCards":[11],"thx":30,"handCards":[],"dn":false,"passCards":[11],"groupCards":[{"name":"kan","cards":[12,12,12],"huXi":6},{"name":"kan","cards":[14,14,14],"huXi":6},{"name":"chi","cards":[1,2,3],"huXi":3},{"name":"chi","cards":[3,4,5],"huXi":0},{"name":"chi","cards":[6,7,8],"huXi":0},{"name":"chi","cards":[9,19,19],"huXi":0},{"name":"chi","cards":[15,16,17],"huXi":0}],"username":"wosxieez","isReady":false,"hx":30,"ucCards":[11]}],"zc":0,"cc":18,"og":true,"ig":false,"pc":17}
		public var testDataHuang2:Object =  {"cc":0,"io":false,"zc":0,"og":true,"pc":0,"zn":"wosxieez3","ig":false,"pn":"xzh","us":[{"handCards":[14,17,18,14,10,20,4,10,18,5,2,13,8,12],"groupCards":[{"cards":[7,7,7],"name":"wei"},{"cards":[19,19,19],"name":"wei"}],"isReady":false,"passCards":[15,6,8,20,16,13,1,12,15,17],"upCards":[15,6,20,10],"username":"wosxieez3","thx":64,"hx":-10,"dn":false,"ucCards":[15,6,12,8,8,20,16,4]},{"handCards":[9,6,18,11,9,3,5,3,13,16,2,15,18,11,14,16,8,6,4,9],"groupCards":[],"isReady":false,"passCards":[5,12,1,15,4,17,13,4,10,1],"upCards":[6,16],"username":"xzh","thx":30,"hx":0,"dn":false,"ucCards":[15,5,6,12,12,8,1,16,4,4,13,17]}],"aus":[]}

			
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