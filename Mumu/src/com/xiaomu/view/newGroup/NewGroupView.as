package com.xiaomu.view.newGroup
{
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	import com.xiaomu.view.MainView;
	import com.xiaomu.view.hall.HallView;
	import com.xiaomu.view.userBarView.UserInfoView;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Button;
	import coco.component.List;
	import coco.core.UIComponent;
	
	public class NewGroupView extends UIComponent
	{
		public function NewGroupView()
		{
			super();
		}
		
		private var userinfoView:UserInfoView;///用户的个人信息界面//作为该群群主，显示金币/房卡/  群成员只显示金币  群主能设置自身和群员的金币数
		private var changePlayStyleBtn:Button;//显示玩法的按钮
		private var changePlayStyleList:List;///切换玩法。作为群主可以查看选择玩法，添加/删除玩法。 群成员只能选择玩法。
		private var changePlayRuleListView:ChangePlayRuleListView
		private var bottomBar:Button;///底部玩法说明条，随左侧玩法列表联动。 群主可以点击后弹出设置界面。设置该小组的玩法。群成员不可点击。只能看到玩法说明。
		private var joinGameQuicklyBtn:Button;///快速加入该玩法小组中的某个桌子。
		private var userList:List;///右侧。该群中成员信息列表。用于显示在线状态。群主对群员的金币设置。
		private var gobackBtn:Button;///返回按钮
		private var _playRulesData:Array=[];

		public function get playRulesData():Array
		{
			return _playRulesData;
		}

		public function set playRulesData(value:Array):void
		{
			_playRulesData = value;
			invalidateProperties();
		}

		override protected function createChildren():void
		{
			super.createChildren();
			
			userinfoView = new UserInfoView();///从点击grouplist时就获取该群信息，反应在金币多少，房卡是否显示。
			addChild(userinfoView);
			
			changePlayStyleBtn = new Button();
			changePlayStyleBtn.label = '切换玩法';
			changePlayStyleBtn.width = 60;
			changePlayStyleBtn.height = 20;
			changePlayStyleBtn.addEventListener(MouseEvent.CLICK,changePlayStyleBtnHandler);
			addChild(changePlayStyleBtn);
			
//			changePlayStyleList = new List();
//			changePlayStyleList.selectedIndex = 0;
//			changePlayStyleList.width = 120;
//			changePlayStyleList.height = 100;
//			changePlayStyleList.itemRendererWidth = 120;
//			changePlayStyleList.itemRendererHeight = 20;
//			changePlayStyleList.labelField = 'name';
//			changePlayStyleList.addEventListener(UIEvent.CHANGE,changePlayStyleListHandler);
//			addChild(changePlayStyleList);///数据的改动要同步到后台，后台要主动发送给各个群成员
			
			changePlayRuleListView = new ChangePlayRuleListView();
			changePlayRuleListView.width = 120;
			addChild(changePlayRuleListView);///数据的改动要同步到后台，后台要主动发送给各个群成员
			
			gobackBtn = new Button();
			gobackBtn.label = '返回'
			gobackBtn.width = 40;
			gobackBtn.height = 20;
			gobackBtn.addEventListener(MouseEvent.CLICK,gobackHandler);
			addChild(gobackBtn);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			changePlayRuleListView.playRuleData = playRulesData;
			if(playRulesData.length+1<=5){
				changePlayRuleListView.height = (playRulesData.length+1)*20;
			}else{
				changePlayRuleListView.height = 5*20;
			}
			changePlayRuleListView.y = changePlayStyleBtn.y-changePlayRuleListView.height
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			gobackBtn.x = width-gobackBtn.width;
			
			userinfoView.x = userinfoView.y = 5;
			
			changePlayStyleBtn.x = 5;
			changePlayStyleBtn.y = height - changePlayStyleBtn.height-5;
			
//			changePlayStyleList.x = changePlayStyleBtn.x;
//			changePlayStyleList.y = changePlayStyleBtn.y-changePlayStyleList.height;///changePlayStyleList.height有个最大值
			
			changePlayRuleListView.x = changePlayStyleBtn.x;
		}
		
		protected function gobackHandler(event:MouseEvent):void
		{
			MainView.getInstane().pushView(HallView);
		}
		
		///{"group_name/当前群名":"主要测试群","group_id/当前的群id":2,"admin_name/当前群主名":"wosxieez","remark":"测试群介绍","admin_id/当前群主id":1}
		public function init(data:Object):void{
//			trace('数据：',JSON.stringify(data));
			
			AppData.getInstane().isNowGroupAdmin = data.admin_id+''==AppData.getInstane().user.id+''; ///是否为当前群的群主
			AppData.getInstane().inGroupView = true;///是否进入groupView
			
			HttpApi.getInstane().getUserInfoByName(AppData.getInstane().username,function(e:Event):void{
				var roomCard:String = JSON.parse(e.currentTarget.data).message[0].room_card+'';
				var tempArr : Array = JSON.parse(JSON.parse(e.currentTarget.data).message[0].group_info) as Array;
				for each (var i:Object in tempArr){
					if(i.group_id+''==data.group_id+''){
						userinfoView.userInfoData = {'gold':i.gold,'userName':AppData.getInstane().username,'roomCard':roomCard,'userId':AppData.getInstane().user.id,'groupId':data.group_id}///用于顶部用户信息界面
					}
				}
			},null);
			
			HttpApi.getInstane().getGroupInfoByGroupId(data.group_id,function(e:Event):void{
				trace('群信息：',JSON.stringify(JSON.parse(e.currentTarget.data).message[0]));
				trace(JSON.parse(e.currentTarget.data).message[0].play_rules);
				var play_rules_str:String = JSON.parse(e.currentTarget.data).message[0].play_rules
				if(!play_rules_str){playRulesData=[];return}
				var play_rules_arr:Array = JSON.parse(play_rules_str) as Array;
				playRulesData = play_rules_arr;
			},null);
		}
		
		protected function changePlayStyleBtnHandler(event:MouseEvent):void
		{
//			changePlayStyleList.visible = !changePlayStyleList.visible;
			changePlayRuleListView.visible = !changePlayRuleListView.visible
		}
		
//		protected function changePlayStyleListHandler(event:UIEvent):void
//		{
//			trace('玩法选择：',JSON.stringify(changePlayStyleList.selectedItem));
//			
////			setTimeout(function():void{},50);
//			changePlayStyleList.selectedIndex = -1
//		}
	}
}