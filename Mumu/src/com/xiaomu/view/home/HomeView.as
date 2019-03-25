package com.xiaomu.view.home
{
	import com.xiaomu.component.ImageBtnWithUpAndDown;
	import com.xiaomu.itemRender.HomeBottomBarRender;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.Audio;
	import com.xiaomu.util.HttpApi;
	import com.xiaomu.view.MainView;
	import com.xiaomu.view.hall.HallView;
	import com.xiaomu.view.home.noticeBar.NoticeBar;
	import com.xiaomu.view.home.popUP.OfficalGongGaoView;
	import com.xiaomu.view.home.popUP.OfficalNoticeView;
	import com.xiaomu.view.home.popUP.OfficalNoticeViewOfCopy;
	import com.xiaomu.view.home.setting.SettingPanelView;
	import com.xiaomu.view.userBarView.UserInfoView2;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import coco.component.ButtonGroup;
	import coco.component.Image;
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
		private var userInfoView:UserInfoView2
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
		private var otherImg:ImageBtnWithUpAndDown;
		private var gonggaoImg:Image;
		private var noticeBar:NoticeBar;
		override protected function createChildren():void
		{
			super.createChildren();
			
			bg = new Image();
			bg.source = 'assets/bg.png';
			addChild(bg);
			
			userInfoView = new UserInfoView2();
			addChild(userInfoView);
			
			myGroup = new ImageBtnWithUpAndDown();
			myGroup.width = 270;
			myGroup.height = 407;
			myGroup.upImageSource = 'assets/home/guild_up.png';
			myGroup.downImageSource = 'assets/home/guild_down.png';
			myGroup.addEventListener(MouseEvent.CLICK,clickHandler);
			addChild(myGroup);
			
			/*myGroup = new Image();
			myGroup.width = 270*0.6;
			myGroup.height = 407*0.6;
			myGroup.source = 'assets/home/myGroup.png';
			myGroup.addEventListener(MouseEvent.CLICK,clickHandler);
			addChild(myGroup);*/
			
			daTongZiImg = new ImageBtnWithUpAndDown();
			daTongZiImg.width = 260;
			daTongZiImg.height = 190;
			daTongZiImg.upImageSource = 'assets/home/other/fen_up.png';
			daTongZiImg.downImageSource = 'assets/home/other/fen_down.png';
			addChild(daTongZiImg);
			
			ziPaiImg = new ImageBtnWithUpAndDown();
			ziPaiImg.width = 260;
			ziPaiImg.height = 190;
			ziPaiImg.upImageSource = 'assets/home/other/creatRoom_up.png';
			ziPaiImg.downImageSource = 'assets/home/other/creatRoom_down.png';
			addChild(ziPaiImg);
			
			xiuXianImg = new ImageBtnWithUpAndDown();
			xiuXianImg.width = 260;
			xiuXianImg.height = 190;
			xiuXianImg.upImageSource = 'assets/home/other/coinRoom_up.png';
			xiuXianImg.downImageSource = 'assets/home/other/coinRoom_down.png';
			addChild(xiuXianImg);
			
			paoDeKuaiImg = new ImageBtnWithUpAndDown();
			paoDeKuaiImg.width = 260;
			paoDeKuaiImg.height = 190;
			paoDeKuaiImg.upImageSource = 'assets/home/other/zi_up.png';
			paoDeKuaiImg.downImageSource = 'assets/home/other/zi_down.png';
			addChild(paoDeKuaiImg);
			
			otherImg = new ImageBtnWithUpAndDown();
			otherImg.width = 259;
			otherImg.height = 291;
			otherImg.upImageSource = 'assets/home/yl_tuibj.png';
			otherImg.downImageSource = 'assets/home/yl_tuibjd.png';
			addChild(otherImg);
			
			gonggaoImg = new Image();
			gonggaoImg.width = 259;
			gonggaoImg.height = 131;
			gonggaoImg.source = 'assets/home/gonggao.png';
			addChild(gonggaoImg);
			
			shoppingBtn = new ImageBtnWithUpAndDown();
			shoppingBtn.width = 117;
			shoppingBtn.height = 92;
			shoppingBtn.upImageSource = 'assets/home/bottomBar/shangcheng_up.png';
			shoppingBtn.downImageSource = 'assets/home/bottomBar/shangcheng_down.png';
			shoppingBtn.addEventListener(MouseEvent.CLICK,shoppingBtnHandler);
			addChild(shoppingBtn);
			
			btnGroup =  new ButtonGroup();
			btnGroup.dataProvider = [{'name':'邮件','image':'youjian'},{'name':'分享','image':'fenxiang'},{'name':'公告','image':'gonggao'},{'name':'战绩','image':'zhanji'},{'name':'设置','image':'shezhi'}];
			btnGroup.itemRendererWidth = 126;
			btnGroup.itemRendererHeight = 60;
			btnGroup.gap = 36;
			btnGroup.labelField = 'name';
			btnGroup.width = (btnGroup.itemRendererWidth+btnGroup.gap)*btnGroup.dataProvider.length
			btnGroup.height = btnGroup.itemRendererHeight;
			btnGroup.itemRendererClass = HomeBottomBarRender;
			btnGroup.addEventListener(UIEvent.CHANGE,changeHandler);
			addChild(btnGroup);
			
			joinRoom = new ImageBtnWithUpAndDown();
			joinRoom.upImageSource = 'assets/home/newjoin_up.png';
			joinRoom.downImageSource = 'assets/home/newjoin_down.png';
			joinRoom.width = 354;
			joinRoom.height = 108;
			joinRoom.addEventListener(MouseEvent.CLICK,joinRoomClickHandler);
			addChild(joinRoom);
			
			proxyBtn = new ImageBtnWithUpAndDown();
			proxyBtn.upImageSource = 'assets/home/cwdl_up.png';
			proxyBtn.downImageSource = 'assets/home/cwdl_down.png';
			proxyBtn.width = 109;
			proxyBtn.height = 113;
			proxyBtn.addEventListener(MouseEvent.CLICK,proxyBtnBtnHandler);
			addChild(proxyBtn);
			
			checkInBtn = new ImageBtnWithUpAndDown();
			checkInBtn.upImageSource = 'assets/home/qiandao_up.png';
			checkInBtn.downImageSource = 'assets/home/qiandao_down.png';
			checkInBtn.width = 109*0.8;
			checkInBtn.height = 111*0.8;
			checkInBtn.addEventListener(MouseEvent.CLICK,checkInBtnHandler);
			addChild(checkInBtn);
			
			waiterBtn = new ImageBtnWithUpAndDown();
			waiterBtn.upImageSource = 'assets/home/btn_kf_normal.png';
			waiterBtn.downImageSource = 'assets/home/btn_kf_press.png';
			waiterBtn.width = 104*0.8;
			waiterBtn.height = 106*0.8;
			waiterBtn.addEventListener(MouseEvent.CLICK,waiterBtnHandler);
			addChild(waiterBtn);
			
			noticeBar = new NoticeBar();
			noticeBar.width = 500;
			noticeBar.height = 32;
			addChild(noticeBar);
			noticeBar.visible = false;
		}
		
		override protected function updateDisplayList():void{
			super.updateDisplayList();
			
			bg.width = width;
			bg.height = height;
			
			shoppingBtn.x = 5;
			shoppingBtn.y = height-shoppingBtn.height-2;
			
			btnGroup.x = shoppingBtn.x+shoppingBtn.width+35;
			btnGroup.y = height-btnGroup.itemRendererHeight-10;
			
			joinRoom.x = width-joinRoom.width;
			joinRoom.y = height-joinRoom.height;
			
			proxyBtn.x = width-proxyBtn.width-10;
			proxyBtn.y = 10;
			
			checkInBtn.x = 10;
			checkInBtn.y = userInfoView.x+userInfoView.height+20;
			
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
			
			otherImg.x = daTongZiImg.x-otherImg.width-10;
			otherImg.y = myGroup.y;
			
			gonggaoImg.x = otherImg.x;
			gonggaoImg.y = otherImg.y+otherImg.height-10;
			
			noticeBar.x = (width-noticeBar.width)/2;
			noticeBar.y = myGroup.y-noticeBar.height-20;
		}
		
		public function init():void{
			Audio.getInstane().playBGM()
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
			setTimeout(function():void{
				AppData.getInstane().inGroupView = false;
				HallView(MainView.getInstane().pushView(HallView)).init()
			},100);
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
			}else if(btnGroup.selectedItem.name=='公告'){
				var gonggaoView:OfficalGongGaoView;
				if(!gonggaoView){
					gonggaoView = new OfficalGongGaoView();
					PopUpManager.centerPopUp(PopUpManager.addPopUp(gonggaoView,null,false,true,0,0.6));
				}
			}
			
			btnGroup.selectedIndex = -1
		}
		
		protected function joinRoomClickHandler(event:MouseEvent):void
		{
			trace('点击joinRoom');
		}
		
		/**
		 * 商场
		 */
		protected function shoppingBtnHandler(event:MouseEvent):void
		{
			var text:String = '如需购买房卡请联系客服微信：';
			popUpHandler(text);
		}
		
		/**
		 * 联系客服
		 */
		protected function waiterBtnHandler(event:MouseEvent):void
		{
			var text:String = '有问题请联系微信：';
			popUpHandler(text);
		}
		
		/**
		 * 成为代理
		 */
		protected function proxyBtnBtnHandler(event:MouseEvent):void
		{
			var text:String = '您不是代理，想成为代理请联系微信：';
			popUpHandler(text);
		}
		
		private function popUpHandler(text:String):void
		{
			var noticePanel:OfficalNoticeViewOfCopy;
			if(!noticePanel){
				noticePanel = new OfficalNoticeViewOfCopy();
			}
			noticePanel.showText = text;
			PopUpManager.centerPopUp(PopUpManager.addPopUp(noticePanel,null,true,false,0,0.6));
		}
		
		/**
		 * 签到
		 */
		protected function checkInBtnHandler(event:MouseEvent):void
		{
			var noticePanel:OfficalNoticeView;
			if(!noticePanel){noticePanel = new OfficalNoticeView()}
			var todayDate:String = getTodayDate();
//			trace("今日日期:",todayDate);
			var user_id:int = parseInt(AppData.getInstane().user.userId);
			HttpApi.getInstane().getUserInfoById(user_id,function(e:Event):void{
				var oldDate:String = JSON.parse(e.currentTarget.data).message[0].checkin_date;
				var oldRoomCardNumber:int = JSON.parse(e.currentTarget.data).message[0].room_card;
//				trace('房卡数：',JSON.parse(e.currentTarget.data).message[0].room_card);
				if(todayDate!=oldDate){
					HttpApi.getInstane().updateUserCheckIn(todayDate,user_id,function(e:Event):void{
						if(JSON.parse(e.currentTarget.data).result==0){
//							trace('签到成功');
							var str:String = '签到成功，赠送您2张房卡。祝您游戏愉快！';
							noticePanel.showText = str;
							PopUpManager.centerPopUp(PopUpManager.addPopUp(noticePanel,null,true,false,0,0.6));
							HttpApi.getInstane().updateUserRoomCard(oldRoomCardNumber+2,user_id,function(e:Event):void{
								if(JSON.parse(e.currentTarget.data).result==0){
//									trace('房卡增加成功');
									userInfoView.userInfoData = {"roomCard":oldRoomCardNumber+2,'userName':AppData.getInstane().username}
								}
							},null);
						}
					},null);
				}else{
					trace('今日已经签到');
					var str:String = '今日已经签到过了哦，明天再来吧。亲！';
					noticePanel.showText = str;
					PopUpManager.centerPopUp(PopUpManager.addPopUp(noticePanel,null,true,false,0,0.6));
				}
			},null);
		}
		
		private function getTodayDate():String
		{
			var date:Date = new Date();
			return date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
		}		
		
		
	}
}