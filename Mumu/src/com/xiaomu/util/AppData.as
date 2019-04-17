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
		public var testDataHuang3:Object = {"og":true,"pc":0,"io":false,"cc":0,"zc":0,"zn":"wosxieez3","pn":"wosxieez3","us":[{"ucCards":[15,3,6,5,13,13,3,17,20],"username":"wosxieez3","thx":-10,"upCards":[15,3,20],"isReady":false,"handCards":[18,18,14,19,6,5,12,18,19,19,4,13,4,11],"dn":false,"hx":-10,"passCards":[15,6,13,7,20,3,5,20,10,10,3],"groupCards":[{"name":"chi","cards":[10,2,7]},{"name":"wei","cards":[8,8,8]}]},{"ucCards":[3,13,7,17],"username":"fangchao","thx":0,"upCards":[3],"isReady":false,"handCards":[20,4,14,12,15,2,16,2,7,2,14,4,17],"dn":false,"hx":0,"passCards":[3,5,16,11,17,12,17,6],"groupCards":[{"name":"ti","cards":[1,1,1,1]},{"name":"ti","cards":[9,9,9,9]}]}],"aus":[],"ig":false}
		public var testDataDiHu:Object = {"cs":[1,2,3,4,5],"cc":19,"zn":"wosxieez3","hn":"fangchao","hts":[1],"io":true,"og":false,"pc":5,"ig":false,"pn":"wosxieez3","aus":[],"us":[{"username":"wosxieez3","thx":-3,"handCards":[20,17,18,16,8,19,1,2,17,12,4,1,15,9,17,14,8,2,10,4],"upCards":[5],"hx":15,"isReady":false,"ucCards":[5],"dn":true,"groupCards":[],"passCards":[]},{"username":"fangchao","thx":183,"handCards":[],"upCards":[],"hx":100,"isReady":false,"ucCards":[],"dn":false,"groupCards":[{"name":"ti","cards":[13,13,13,13]},{"name":"chi","cards":[1,11,11]},{"name":"chi","cards":[2,7,10]},{"name":"chi","cards":[8,9,10]},{"name":"chi","cards":[12,17,20]},{"name":"chi","cards":[15,5,5]},{"name":"jiang","cards":[6,6]}],"passCards":[]}],"zc":0}
		public var testData3 :Object = {"cc":2,"hc":14,"us":[{"groupCards":[{"name":"wei","cards":[1,1,1],"huXi":3},{"name":"chi","cards":[5,15,5],"huXi":0},{"name":"wei","cards":[9,9,9],"huXi":3},{"name":"wei","cards":[20,20,20],"huXi":6},{"name":"wei","cards":[6,6,6],"huXi":3},{"name":"chi","cards":[4,4,14],"huXi":0},{"name":"kan","cards":[8,8,8],"huXi":3}],"upCards":[7,2,19,16,13,13],"isReady":false,"passCards":[7,7,19,2,19,16,2,12,3,12,13,15,13,10,7,5,17],"dn":false,"hx":72,"handCards":[],"thx":72,"ucCards":[7,19,2,19,16,3,13,13],"nf":0,"tjs":0,"ae":-1,"username":"fc"}],"hn":"fc","io":false,"pc":14,"og":true,"pn":"fc","ig":false,"ic":1,"aus":[],"zc":0,"hts":[2,7],"zn":"fc"}
		public var testDataEnd:Object = {"aus":[],"zn":"aaa","ic":8,"hn":"aaa","io":true,"ig":false,"og":false,"hts":[3,9],"hc":10,"zc":0,"pc":10,"cc":18,"us":[{"ucCards":[13,3,15],"isReady":false,"thx":109,"ae":-1,"nf":20,"hx":30,"handCards":[],"groupCards":[{"name":"wei","huXi":3,"cards":[2,2,2]},{"name":"pao","huXi":6,"cards":[10,10,10,10]},{"name":"kan","huXi":6,"cards":[12,12,12]},{"name":"chi","huXi":0,"cards":[1,11,11]},{"name":"chi","huXi":0,"cards":[5,6,7]},{"name":"chi","huXi":0,"cards":[17,18,19]},{"name":"jiang","huXi":0,"cards":[4,4]}],"username":"aaa","tjs":125,"dn":true,"upCards":[13,15],"passCards":[]},{"ucCards":[3,10],"isReady":false,"thx":-57,"ae":-1,"nf":-20,"hx":-30,"handCards":[6,14,8,17,6,20,9,19,19,20,19,17,16,14],"groupCards":[{"name":"peng","cards":[13,13,13]},{"name":"chi","cards":[15,5,15]}],"username":"fc","tjs":-125,"dn":true,"upCards":[3,10],"passCards":[3]}],"pn":"fc"}
			
		public var versionNum:String="0.0.1"
		public var serverHost:String = '127.0.0.1'
		public var webUrl:String = 'http://127.0.0.1:3008/'
		public var roomTableImgsArr:Array = ["pz_cl_bk_0.jpg","pz_cl_bk_1.jpg","pz_cl_bk_2.jpg","pz_cl_bk_3.jpg"]///桌布图片数据
		public var user:Object  // 当前用户
		public var group:Object // 当前群
		public var groupLL:int;//你在当前群中的等级 0普通，1二级管理员，2一级管理员，3副馆主，4馆主
		public var rule:Object  // 当前你所选中的玩法
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
		
		public function get roomTableIndex():String
		{
			if(getShareObjectValue("roomTableIndex")){
				return getShareObjectValue("roomTableIndex");
			}else{
				return "0"
			}
		}
		
		public function set roomTableIndex(value:String):void
		{
			setShareObjectValue("roomTableIndex", value);
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