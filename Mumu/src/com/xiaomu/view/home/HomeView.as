package com.xiaomu.view.home
{
	import com.xiaomu.component.ImageBtnWithUpAndDown;
	import com.xiaomu.itemRender.HomeBottomBarRender;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	import com.xiaomu.view.MainView;
	import com.xiaomu.view.hall.HallView;
	import com.xiaomu.view.home.setting.SettingPanelView;
	import com.xiaomu.view.userBarView.UserInfoView;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import coco.component.ButtonGroup;
	import coco.component.Image;
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
		private var myGroup:ImageBtnWithUpAndDown;
		private var userInfoView:UserInfoView
		private var shoppingBtn:ImageBtnWithUpAndDown;
		private var btnGroup:ButtonGroup;
		private var proxyBtn:ImageBtnWithUpAndDown;
		private	var checkInBtn:ImageBtnWithUpAndDown;
		private var waiterBtn:ImageBtnWithUpAndDown;
		private var joinRoom:ImageBtnWithUpAndDown;
		
		private var daTongZiImg:ImageBtnWithUpAndDown;
		private var ziPaiImg:ImageBtnWithUpAndDown;
		private var xiuXianImg:ImageBtnWithUpAndDown;
		private var paoDeKuaiImg:ImageBtnWithUpAndDown;
		override protected function createChildren():void
		{
			super.createChildren();
			
			bg = new Image();
			bg.source = 'assets/bg.png';
			addChild(bg);
			
			userInfoView = new UserInfoView();
			addChild(userInfoView);
			
			myGroup = new ImageBtnWithUpAndDown();
			myGroup.width = 270*0.36;
			myGroup.height = 407*0.36;
			myGroup.upImageSource = 'assets/home/guild_up.png';
			myGroup.downImageSource = 'assets/home/guild_up.png';
			myGroup.addEventListener(MouseEvent.CLICK,clickHandler);
			addChild(myGroup);
			
			/*myGroup = new Image();
			myGroup.width = 270*0.6;
			myGroup.height = 407*0.6;
			myGroup.source = 'assets/home/myGroup.png';
			myGroup.addEventListener(MouseEvent.CLICK,clickHandler);
			addChild(myGroup);*/
			
			daTongZiImg = new ImageBtnWithUpAndDown();
			daTongZiImg.width = 260*0.35;
			daTongZiImg.height = 190*0.35;
			daTongZiImg.upImageSource = 'assets/home/other/fen_up.png';
			daTongZiImg.downImageSource = 'assets/home/other/fen_up.png';
			addChild(daTongZiImg);
			
			ziPaiImg = new ImageBtnWithUpAndDown();
			ziPaiImg.width = 260*0.35;
			ziPaiImg.height = 190*0.35;
			ziPaiImg.upImageSource = 'assets/home/other/creatRoom_up.png';
			ziPaiImg.downImageSource = 'assets/home/other/creatRoom_up.png';
			addChild(ziPaiImg);
			
			xiuXianImg = new ImageBtnWithUpAndDown();
			xiuXianImg.width = 260*0.35;
			xiuXianImg.height = 190*0.35;
			xiuXianImg.upImageSource = 'assets/home/other/coinRoom_up.png';
			xiuXianImg.downImageSource = 'assets/home/other/coinRoom_up.png';
			addChild(xiuXianImg);
			
			paoDeKuaiImg = new ImageBtnWithUpAndDown();
			paoDeKuaiImg.width = 260*0.35;
			paoDeKuaiImg.height = 190*0.35;
			paoDeKuaiImg.upImageSource = 'assets/home/other/zi_up.png';
			paoDeKuaiImg.downImageSource = 'assets/home/other/zi_up.png';
			addChild(paoDeKuaiImg);
			
			shoppingBtn = new ImageBtnWithUpAndDown();
			shoppingBtn.width = 117*0.32;
			shoppingBtn.height = 92*0.32;
			shoppingBtn.upImageSource = 'assets/home/bottomBar/shangcheng_up.png';
			shoppingBtn.downImageSource = 'assets/home/bottomBar/shangcheng_up.png';
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
			joinRoom.downImageSource = 'assets/home/newjoin_up.png';
			joinRoom.width = 354*0.4;
			joinRoom.height = 108*0.4;
			joinRoom.addEventListener(MouseEvent.CLICK,joinRoomClickHandler);
			addChild(joinRoom);
			
			proxyBtn = new ImageBtnWithUpAndDown();
			proxyBtn.upImageSource = 'assets/home/cwdl_up.png';
			proxyBtn.downImageSource = 'assets/home/cwdl_up.png';
			proxyBtn.width = 30;
			proxyBtn.height = 30;
			addChild(proxyBtn);
			
			checkInBtn = new ImageBtnWithUpAndDown();
			checkInBtn.upImageSource = 'assets/home/qiandao_up.png';
			checkInBtn.downImageSource = 'assets/home/qiandao_up.png';
			checkInBtn.width = 30;
			checkInBtn.height = 30;
			addChild(checkInBtn);
			
			waiterBtn = new ImageBtnWithUpAndDown();
			waiterBtn.upImageSource = 'assets/home/btn_kf_normal.png';
			waiterBtn.downImageSource = 'assets/home/btn_kf_normal.png';
			waiterBtn.width = 30;
			waiterBtn.height = 30;
			addChild(waiterBtn);
		}
		
		override protected function updateDisplayList():void{
			super.updateDisplayList();
			
			bg.width = width;
			bg.height = height;
			
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
			
			daTongZiImg.x = width/2-daTongZiImg.width-3;
			daTongZiImg.y = height/2-daTongZiImg.height-1;
			
			ziPaiImg.x = width/2+3;
			ziPaiImg.y = daTongZiImg.y;
			
			xiuXianImg.x = daTongZiImg.x;
			xiuXianImg.y = height/2+1;
			
			paoDeKuaiImg.x = ziPaiImg.x;
			paoDeKuaiImg.y = xiuXianImg.y;
			
			myGroup.x = ziPaiImg.x+ziPaiImg.width+10;
			myGroup.y = (height-myGroup.height)/2;
		}
		
		public function init():void{
			HttpApi.getInstane().getUserInfoByName(AppData.getInstane().username,function(e:Event):void{
				//trace('大厅界面：金币',JSON.parse(e.currentTarget.data).message[0].group_info);
				//trace('大厅界面：房卡',JSON.parse(e.currentTarget.data).message[0].room_card);
				//trace('大厅界面：用户id',JSON.parse(e.currentTarget.data).message[0].id);
				var room_card:String = JSON.parse(e.currentTarget.data).message[0].room_card?JSON.parse(e.currentTarget.data).message[0].room_card+'':'0'
				var user_id:String = JSON.parse(e.currentTarget.data).message[0].id+''
				AppData.getInstane().user.userId = user_id;
				userInfoView.userInfoData = {"roomCard":room_card,'userName':AppData.getInstane().username}
			},null);
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