package com.xiaomu.view.home
{
	import com.xiaomu.component.ImageBtnWithUpAndDown;
	import com.xiaomu.itemRender.HomeBottomBarRender;
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
//		private var myGroup:ImageBtnWithUpAndDown;
		private var myGroup:Image;
		private var userInfoView:UserInfoView
		private var shoppingBtn:ImageBtnWithUpAndDown;
		private var btnGroup:ButtonGroup;
		private var proxyBtn:ImageBtnWithUpAndDown;
		private	var checkInBtn:ImageBtnWithUpAndDown;
		private var waiterBtn:ImageBtnWithUpAndDown;
		private var joinRoom:ImageBtnWithUpAndDown;
		private var rankList:List;
		override protected function createChildren():void
		{
			super.createChildren();
			
			userInfoView = new UserInfoView();
			addChild(userInfoView);
			
			/*myGroup = new ImageBtnWithUpAndDown();
			myGroup.width = 270*0.3;
			myGroup.height = 407*0.3;
			myGroup.upImageSource = 'assets/home/guild_up.png';
			myGroup.downImageSource = 'assets/home/guild_down.png';
			myGroup.addEventListener(MouseEvent.CLICK,clickHandler);
			addChild(myGroup);*/
			
			myGroup = new Image();
			myGroup.width = 130;
			myGroup.height = 150;
			myGroup.source = 'assets/home/myGroup.png';
			myGroup.addEventListener(MouseEvent.CLICK,clickHandler);
			addChild(myGroup);
			
			shoppingBtn = new ImageBtnWithUpAndDown();
			shoppingBtn.width = 117*0.32;
			shoppingBtn.height = 92*0.32;
			shoppingBtn.upImageSource = 'assets/home/bottomBar/shangcheng_up.png';
			shoppingBtn.downImageSource = 'assets/home/bottomBar/shangcheng_down.png';
			addChild(shoppingBtn);
			
			btnGroup =  new ButtonGroup();
			btnGroup.dataProvider = [{'name':'邮件','image':'youjian'},{'name':'分享','image':'fenxiang'},{'name':'公告','image':'gonggao'},{'name':'战绩','image':'zhanji'},{'name':'设置','image':'shezhi'}];
			btnGroup.itemRendererWidth = 63*0.95;
			btnGroup.itemRendererHeight = 30*0.95;
			btnGroup.labelField = 'name';
			btnGroup.itemRendererClass = HomeBottomBarRender;
			btnGroup.addEventListener(UIEvent.CHANGE,changeHandler);
			addChild(btnGroup);
			
			joinRoom = new ImageBtnWithUpAndDown();
			joinRoom.upImageSource = 'assets/home/newjoin_up.png';
			joinRoom.downImageSource = 'assets/home/newjoin_down.png';
			joinRoom.width = 354*0.4;
			joinRoom.height = 108*0.4;
			joinRoom.addEventListener(MouseEvent.CLICK,joinRoomClickHandler);
			addChild(joinRoom);
			
			proxyBtn = new ImageBtnWithUpAndDown();
			proxyBtn.upImageSource = 'assets/home/cwdl_up.png';
			proxyBtn.downImageSource = 'assets/home/cwdl_down.png';
			proxyBtn.width = 30;
			proxyBtn.height = 30;
			addChild(proxyBtn);
			
			checkInBtn = new ImageBtnWithUpAndDown();
			checkInBtn.upImageSource = 'assets/home/qiandao_up.png';
			checkInBtn.downImageSource = 'assets/home/qiandao_down.png';
			checkInBtn.width = 30;
			checkInBtn.height = 30;
			addChild(checkInBtn);
			
			waiterBtn = new ImageBtnWithUpAndDown();
			waiterBtn.upImageSource = 'assets/home/btn_kf_normal.png';
			waiterBtn.downImageSource = 'assets/home/btn_kf_press.png';
			waiterBtn.width = 30;
			waiterBtn.height = 30;
			addChild(waiterBtn);
			
			rankList = new List();
			rankList.dataProvider = [{'name':'aa'},{'name':'bb'},{'name':'cc'},{'name':'dd'},{'name':'ee'}]
			rankList.labelField = 'name';
			addChild(rankList);
		}
		
		override protected function updateDisplayList():void{
			super.updateDisplayList();
			
			myGroup.width = 80;
			myGroup.height = 120;
			myGroup.x = width-myGroup.width-50;
			myGroup.y = (height-myGroup.height)/2;
			
			shoppingBtn.x = 5;
			shoppingBtn.y = height-shoppingBtn.height-2;
			
			btnGroup.width = btnGroup.dataProvider.length*btnGroup.itemRendererWidth;
			btnGroup.height = 25;
			btnGroup.x = shoppingBtn.x+shoppingBtn.width+5;
			btnGroup.y = height-btnGroup.itemRendererHeight;
			
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
			
			rankList.x = waiterBtn.x+waiterBtn.width+20;
			rankList.y = myGroup.y;
			rankList.width = myGroup.width;
			rankList.height = myGroup.height;
		}
		
		public function init():void{
//			trace('homeView');
		}
		
		protected function clickHandler(event:MouseEvent):void{
//			trace('选中我的组群---进入hallView');
			AppData.getInstane().inGroupView = false;
			HallView(MainView.getInstane().pushView(HallView)).init()
		}
		
		protected function changeHandler(event:UIEvent):void
		{
			if(!btnGroup.selectedItem){
				return;
			}
			if(btnGroup.selectedItem.name=='设置'){
				var setPanelView:SettingPanelView
				if(!setPanelView){
					setPanelView = new SettingPanelView();
				}
				PopUpManager.centerPopUp(PopUpManager.addPopUp(setPanelView,null,true,false,0x000000,0.8));
			}
			setTimeout(function():void{btnGroup.selectedIndex = -1},10);
		}
		
		protected function joinRoomClickHandler(event:MouseEvent):void
		{
			trace('点击joinRoom');
		}
	}
}