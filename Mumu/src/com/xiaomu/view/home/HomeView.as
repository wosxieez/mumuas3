package com.xiaomu.view.home
{
	import com.xiaomu.util.AppData;
	import com.xiaomu.view.MainView;
	import com.xiaomu.view.hall.HallView;
	import com.xiaomu.view.home.setting.SettingPanelView;
	import com.xiaomu.view.userBarView.UserInfoView;
	
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import coco.component.Button;
	import coco.component.ButtonGroup;
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.List;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	import coco.manager.PopUpManager;
	
	public class HomeView extends UIComponent
	{
		public function HomeView()
		{
			super();
		}
		
		private var bg : Image;
		private var myGroup:Image;
		private var userInfoView:UserInfoView
		private var btnGroup:ButtonGroup;
		private var proxyBtn:Button;
		private	var checkInBtn:Button;
		private var waiterBtn:Button;
		private var realNameBtn:Button;
		private var joinRoom:Image;
		private var rankList:List;
		override protected function createChildren():void
		{
			super.createChildren();
			
			userInfoView = new UserInfoView();
			addChild(userInfoView);
			
			myGroup = new Image();
			myGroup.source = 'assets/home/guild_up.png';
			myGroup.addEventListener(MouseEvent.CLICK,clickHandler);
			addChild(myGroup);
			
			btnGroup =  new ButtonGroup();
			btnGroup.dataProvider = [{'name':'商场','image':'shangcheng_up'},{'name':'邮件','image':'youjian_up'},{'name':'分享','image':'fenxiang_up'},{'name':'公告','image':'gonggao_up'},{'name':'战绩','image':'shezhi_up'},{'name':'设置','image':'shezhi_up'}];
			btnGroup.itemRendererWidth = 60;
			btnGroup.labelField = 'name';
			btnGroup.addEventListener(UIEvent.CHANGE,changeHandler);
			addChild(btnGroup);
			
			joinRoom = new Image();
			joinRoom.source = 'assets/home/newjoin_up.png';
			addChild(joinRoom);
			
			proxyBtn = new Button();
			proxyBtn.label = '代理';
			addChild(proxyBtn);
			
			checkInBtn = new Button();
			checkInBtn.label = '签到';
			addChild(checkInBtn);
			
			waiterBtn = new Button();
			waiterBtn.label = '客服';
			addChild(waiterBtn);
			
			realNameBtn = new Button();
			realNameBtn.label = '实名认证';
			addChild(realNameBtn);
			
			rankList = new List();
			rankList.dataProvider = [{'name':'aa'},{'name':'bb'},{'name':'cc'},{'name':'dd'},{'name':'ee'}]
			rankList.labelField = 'name';
			addChild(rankList);
		}
		
		protected function changeHandler(event:UIEvent):void
		{
			if(btnGroup.selectedItem.name=='设置'){
				var setPanelView:SettingPanelView
				if(!setPanelView){
					setPanelView = new SettingPanelView();
				}
				PopUpManager.centerPopUp(PopUpManager.addPopUp(setPanelView,null,true,false,0x000000,0.8));
			}
			setTimeout(function():void{btnGroup.selectedIndex = -1},200);
		}
		
		override protected function updateDisplayList():void{
			super.updateDisplayList();
			
			myGroup.width = 80;
			myGroup.height = 120;
			myGroup.x = width-myGroup.width-50;
			myGroup.y = (height-myGroup.height)/2;
			
			btnGroup.width = btnGroup.dataProvider.length*btnGroup.itemRendererWidth;
			btnGroup.height = 25;
			btnGroup.x = 0;
			btnGroup.y = height-btnGroup.height;
			joinRoom.height =  35;
			joinRoom.width = width-btnGroup.width
			joinRoom.x = width-joinRoom.width;
			joinRoom.y = height-joinRoom.height;
			
			proxyBtn.width = proxyBtn.height = 25;
			proxyBtn.x = width-proxyBtn.width-10;
			proxyBtn.y = 10;
			
			checkInBtn.width = checkInBtn.height = 25;
			checkInBtn.x = 10;
			checkInBtn.y = 50;
			
			waiterBtn.width = waiterBtn.height = 25;
			waiterBtn.x = checkInBtn.x;
			waiterBtn.y = checkInBtn.y+checkInBtn.height+10;
			
			realNameBtn.width = realNameBtn.height = 25;
			realNameBtn.x = checkInBtn.x;
			realNameBtn.y = waiterBtn.y+waiterBtn.height+10;
			
			rankList.x = realNameBtn.x+realNameBtn.width+20;
			rankList.y = myGroup.y;
			rankList.width = myGroup.width;
			rankList.height = myGroup.height;
		}
		
		public function init():void{
			trace('homeView');
		}
		
		protected function clickHandler(event:MouseEvent):void{
			trace('选中我的组群---进入hallView');
			AppData.getInstane().inGroupView = false;
			HallView(MainView.getInstane().pushView(HallView)).init()
		}
	}
}