package com.xiaomu.view.home
{
	import com.xiaomu.component.AppAlert;
	import com.xiaomu.component.ImageButton;
	import com.xiaomu.component.Loading;
	import com.xiaomu.itemRender.HomeBottomBarRender;
	import com.xiaomu.util.Api;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.Audio;
	import com.xiaomu.view.MainView;
	import com.xiaomu.view.hall.HallView;
	import com.xiaomu.view.home.noticeBar.NoticeBar;
	import com.xiaomu.view.home.popUp1.OfficalNoticeViewOfCopy;
	import com.xiaomu.view.home.setting.SettingPanelView;
	import com.xiaomu.view.room.EndResultView;
	import com.xiaomu.view.room.RoomView;
	import com.xiaomu.view.userBarView.UserInfoView;
	
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import coco.component.Button;
	import coco.component.ButtonGroup;
	import coco.component.Image;
	import coco.component.Label;
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
		private var myGroup:ImageButton;
		private var userInfoView:UserInfoView
		private var shoppingBtn:ImageButton;
		private var btnGroup:ButtonGroup;
		private var proxyBtn:ImageButton;
		private	var checkInBtn:ImageButton;
		private var waiterBtn:ImageButton;
		private var joinRoom:ImageButton;
		
		private var daTongZiImg:ImageButton;
		private var ziPaiImg:ImageButton;
		private var xiuXianImg:ImageButton;
		private var paoDeKuaiImg:ImageButton;
		private var otherImg:ImageButton;
		private var gonggaoImg:Image;
		private var noticeBar:NoticeBar;
		private var versionLab:Label;
		override protected function createChildren():void
		{
			super.createChildren();
			
			bg = new Image();
			bg.source = 'assets/home/hallBg.png';
			addChild(bg);
			
			var testBtn:Button = new Button();
			testBtn.label = 'test';
			testBtn.addEventListener(MouseEvent.CLICK,testHandler);
			testBtn.x = 300;
			addChild(testBtn);
			testBtn.visible = false;
			
			userInfoView = new UserInfoView();
			addChild(userInfoView);
			
			versionLab = new Label();
			versionLab.text = "ver:"+AppData.getInstane().versionNum;
			versionLab.color = 0xffffff;
			addChild(versionLab);
			
			myGroup = new ImageButton();
			myGroup.width = 270;
			myGroup.height = 407;
			myGroup.upImageSource = 'assets/home/myGroup1_up.png';
			myGroup.downImageSource = 'assets/home/myGroup1_down.png';
			myGroup.addEventListener(MouseEvent.CLICK,clickHandler);
			addChild(myGroup);
			
			/*myGroup = new Image();
			myGroup.width = 270*0.6;
			myGroup.height = 407*0.6;
			myGroup.source = 'assets/home/myGroup.png';
			myGroup.addEventListener(MouseEvent.CLICK,clickHandler);
			addChild(myGroup);*/
			
			daTongZiImg = new ImageButton();
			daTongZiImg.width = 260;
			daTongZiImg.height = 190;
			daTongZiImg.upImageSource = 'assets/home/other/guandan.png';
			daTongZiImg.downImageSource = 'assets/home/other/guandan.png';
			addChild(daTongZiImg);
			
			ziPaiImg = new ImageButton();
			ziPaiImg.width = 260;
			ziPaiImg.height = 190;
			ziPaiImg.upImageSource = 'assets/home/other/creatRoom_up.png';
			ziPaiImg.downImageSource = 'assets/home/other/creatRoom_down.png';
			ziPaiImg.addEventListener(MouseEvent.CLICK, ziPaiImg_clickHandler)
			addChild(ziPaiImg);
			
			xiuXianImg = new ImageButton();
			xiuXianImg.width = 260;
			xiuXianImg.height = 190;
			xiuXianImg.upImageSource = 'assets/home/other/paodekuai.png';
			xiuXianImg.downImageSource = 'assets/home/other/paodekuai.png';
			addChild(xiuXianImg);
			
			paoDeKuaiImg = new ImageButton();
			paoDeKuaiImg.width = 260;
			paoDeKuaiImg.height = 190;
			paoDeKuaiImg.upImageSource = 'assets/home/other/caicaicai_up.png';
			paoDeKuaiImg.downImageSource = 'assets/home/other/caicaicai_down.png';
			paoDeKuaiImg.addEventListener(MouseEvent.CLICK, paoDeKuaiImg_clickHandler)
			addChild(paoDeKuaiImg);
			
			otherImg = new ImageButton();
			otherImg.width = 259;
			otherImg.height = 291;
			otherImg.upImageSource = 'assets/home/youxigaonggao.png';
			otherImg.downImageSource = 'assets/home/youxigaonggao.png';
			//			otherImg.addEventListener(MouseEvent.CLICK, paoDeKuaiImg_clickHandler)
			addChild(otherImg);
			
			gonggaoImg = new Image();
			gonggaoImg.width = 259;
			gonggaoImg.height = 131;
			gonggaoImg.source = 'assets/home/gonggao1.png';
			addChild(gonggaoImg);
			
			shoppingBtn = new ImageButton();
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
			
			joinRoom = new ImageButton();
			joinRoom.upImageSource = 'assets/home/newjoin_up.png';
			joinRoom.downImageSource = 'assets/home/newjoin_down.png';
			joinRoom.width = 354;
			joinRoom.height = 108;
			joinRoom.addEventListener(MouseEvent.CLICK,joinRoomClickHandler);
			addChild(joinRoom);
			
			proxyBtn = new ImageButton();
			proxyBtn.upImageSource = 'assets/home/cwdl_up.png';
			proxyBtn.downImageSource = 'assets/home/cwdl_down.png';
			proxyBtn.width = 104*0.8;
			proxyBtn.height = 106*0.8;
			proxyBtn.addEventListener(MouseEvent.CLICK,proxyBtnBtnHandler);
			addChild(proxyBtn);
			
			checkInBtn = new ImageButton();
			checkInBtn.upImageSource = 'assets/home/qiandao_up.png';
			checkInBtn.downImageSource = 'assets/home/qiandao_down.png';
			checkInBtn.width = 109*0.8;
			checkInBtn.height = 111*0.8;
			checkInBtn.addEventListener(MouseEvent.CLICK,checkInBtnHandler);
			addChild(checkInBtn);
			
			waiterBtn = new ImageButton();
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
		
		protected function paoDeKuaiImg_clickHandler(event:MouseEvent):void
		{
			AppAlert.show('程序员小哥哥正在努力的开发中....')
		}
		
		protected function ziPaiImg_clickHandler(event:MouseEvent):void
		{
			Loading.getInstance().open()
			Api.getInstane().joinGroup(AppData.getInstane().user.username, 0, function (response:Object):void {
				if (response.code == 0) {
				 	Api.getInstane().createRoom({cc: 2, hx: 15, id: 0}, function (response:Object):void {
						Loading.getInstance().close()
						if (response.code == 0) {
							RoomView(MainView.getInstane().pushView(RoomView)).init(response.data)
						} else {
							AppAlert.show(response.data)
						}
					})
				} else {
					Loading.getInstance().close()
				}
			})
		}
		
		override protected function updateDisplayList():void{
			super.updateDisplayList();
			
			versionLab.x = 10
			versionLab.y= userInfoView.height+15
			
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
			checkInBtn.y = userInfoView.x+userInfoView.height+50;
			
			waiterBtn.x = checkInBtn.x;
			waiterBtn.y = checkInBtn.y+checkInBtn.height+10;
			
			//////////////////////
			
			daTongZiImg.x = width/2-daTongZiImg.width-3;
			daTongZiImg.y = height/2-daTongZiImg.height-1;
			
			ziPaiImg.x = width/2+3;
			ziPaiImg.y = daTongZiImg.y;
			/*ziPaiImg.x = (width-ziPaiImg.width)/2;
			ziPaiImg.y = daTongZiImg.y;*/
			
			xiuXianImg.x = daTongZiImg.x;
			xiuXianImg.y = height/2+1;
			
			paoDeKuaiImg.x = ziPaiImg.x;
			paoDeKuaiImg.y = xiuXianImg.y;
			
			myGroup.x = ziPaiImg.x+ziPaiImg.width+10;
			myGroup.y = (height-myGroup.height)/2;
			
			otherImg.x = daTongZiImg.x-otherImg.width-10;
			//			otherImg.x = ziPaiImg.x-otherImg.width-10;
			otherImg.y = ziPaiImg.y-5;
			
			gonggaoImg.x = otherImg.x;
			gonggaoImg.y = otherImg.y+otherImg.height-10;
			
			noticeBar.x = (width-noticeBar.width)/2;
			noticeBar.y = myGroup.y-noticeBar.height-20;
		}
		
		public function init():void{
			Audio.getInstane().playBGM()
			userInfoView.userInfoData = AppData.getInstane().user
			trace('user id ',AppData.getInstane().user.id);
			trace('user:',JSON.stringify(AppData.getInstane().user));
		}
		
		protected function clickHandler(event:MouseEvent):void{
			setTimeout(function():void{
				HallView(MainView.getInstane().pushView(HallView)).init()
			},100);
		}
		
		protected function changeHandler(event:UIEvent):void
		{
			if(!btnGroup.selectedItem){
				return;
			}
			Audio.getInstane().playButton()
			if(btnGroup.selectedItem.name=='设置'){
				SettingPanelView.getInstane().hideSignOutBtn = false;
				PopUpManager.centerPopUp(PopUpManager.addPopUp(SettingPanelView.getInstane(),null,true,false,0x000000,0.8));
			}
				/*else if(btnGroup.selectedItem.name=='公告'){
				var gonggaoView:OfficalGongGaoView;
				if(!gonggaoView){
				gonggaoView = new OfficalGongGaoView();
				PopUpManager.centerPopUp(PopUpManager.addPopUp(gonggaoView,null,false,true,0,0.6));
				}
				}*/
			else if(btnGroup.selectedItem.name=='分享'){
				var noticeView:OfficalNoticeViewOfCopy;
				if(!noticeView){noticeView = new OfficalNoticeViewOfCopy();}
				noticeView.showText = '请用浏览器打开次链接：';
				noticeView.copyText = 'https://fir.im/niuniu1';
				PopUpManager.centerPopUp(PopUpManager.addPopUp(noticeView,null,true,true,0x000000,0.5));
			} else {
				AppAlert.show('程序员小哥哥正在努力的开发中....')
			}
			
			btnGroup.selectedIndex = -1
		}
		
		protected function joinRoomClickHandler(event:MouseEvent):void
		{
			PopUpManager.centerPopUp(PopUpManager.addPopUp(new TempKeyboardPanel(),null,true,true,0,0.2))
		}
		
		/**
		 * 商场
		 */
		protected function shoppingBtnHandler(event:MouseEvent):void
		{
			AppAlert.show('程序员小哥哥正在努力的开发中....')
		}
		
		/**
		 * 联系客服
		 */
		protected function waiterBtnHandler(event:MouseEvent):void
		{
			AppAlert.show('程序员小哥哥正在努力的开发中....')
		}
		
		/**
		 * 成为代理
		 */
		protected function proxyBtnBtnHandler(event:MouseEvent):void
		{
			AppAlert.show('程序员小哥哥正在努力的开发中....')
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
			AppAlert.show('程序员小哥哥正在努力的开发中....')
			return;
			//			var noticePanel:OfficalNoticeView;
			//			if(!noticePanel){noticePanel = new OfficalNoticeView()}
			//			var todayDate:String = getTodayDate();
			//			//			trace("今日日期:",todayDate);
			//			var user_id:int = parseInt(AppData.getInstane().user.userId);
			//			HttpApi.getInstane().getUserInfoById(user_id,function(e:Event):void{
			//				var oldDate:String = JSON.parse(e.currentTarget.data).message[0].checkin_date;
			//				var oldRoomCardNumber:int = JSON.parse(e.currentTarget.data).message[0].room_card;
			//				//				trace('房卡数：',JSON.parse(e.currentTarget.data).message[0].room_card);
			//				if(todayDate!=oldDate){
			//					HttpApi.getInstane().updateUserCheckIn(todayDate,user_id,function(e:Event):void{
			//						if(JSON.parse(e.currentTarget.data).result==0){
			//							//							trace('签到成功');
			//							var str:String = '签到成功，赠送您2张房卡。祝您游戏愉快！';
			//							noticePanel.showText = str;
			//							PopUpManager.centerPopUp(PopUpManager.addPopUp(noticePanel,null,true,false,0,0.6));
			//							HttpApi.getInstane().updateUserRoomCard(oldRoomCardNumber+2,user_id,function(e:Event):void{
			//								if(JSON.parse(e.currentTarget.data).result==0){
			//									//									trace('房卡增加成功');
			//									userInfoView.userInfoData = {"roomCard":oldRoomCardNumber+2,'userName':AppData.getInstane().username}
			//								}
			//							},null);
			//						}
			//					},null);
			//				}else{
			//					trace('今日已经签到');
			//					var str:String = '今日已经签到过了哦，明天再来吧。亲！';
			//					noticePanel.showText = str;
			//					PopUpManager.centerPopUp(PopUpManager.addPopUp(noticePanel,null,true,false,0,0.6));
			//				}
			//			},null);
		}
		
		private function getTodayDate():String
		{
			var date:Date = new Date();
			return date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
		}
		
		protected function testHandler(event:MouseEvent):void
		{
//			var arr:Array = CardUtil.getInstane().riffle([20, 4, 14, 12, 15, 2, 16, 2, 7, 2, 14, 4, 17])
//			var newArr:Array = [];
//			for each (var item:Array in arr) 
//			{
//				newArr.push({"name":"no","cards":item})
//			}
//			trace(JSON.stringify(arr));
//			trace(JSON.stringify(newArr));
			
//			var endView:EndResultView = new EndResultView();
//			endView.data = AppData.getInstane().testDataDiHu;
//			PopUpManager.centerPopUp(PopUpManager.addPopUp(endView,null,true,false,0,0.8));
			
//			var winView3:WinView = new WinView();
//			winView3.data = AppData.getInstane().testDataDiHu;
//			PopUpManager.centerPopUp(PopUpManager.addPopUp(winView3,null,true,false));
		}
		
	}
}