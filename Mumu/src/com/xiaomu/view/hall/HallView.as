package com.xiaomu.view.hall
{
	import com.xiaomu.component.ImageBtnWithUpAndDown;
	import com.xiaomu.component.ImgBtn;
	import com.xiaomu.component.Loading;
	import com.xiaomu.event.ApiEvent;
	import com.xiaomu.event.AppManagerEvent;
	import com.xiaomu.manager.AppManager;
	import com.xiaomu.renderer.GroupRenderer;
	import com.xiaomu.util.Api;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.Audio;
	import com.xiaomu.util.HttpApi;
	import com.xiaomu.view.MainView;
	import com.xiaomu.view.group.GroupViewNew;
	import com.xiaomu.view.hall.popUpPanel.CreateGroupPanel;
	import com.xiaomu.view.home.HomeView;
	import com.xiaomu.view.userBarView.UserInfoView2;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Alert;
	import coco.component.HorizontalAlign;
	import coco.component.Image;
	import coco.component.List;
	import coco.component.VerticalAlign;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	import coco.manager.PopUpManager;
	
	/**
	 * 大厅界面
	 */
	public class HallView extends UIComponent
	{
		public function HallView()
		{
			super();
			AppManager.getInstance().addEventListener(AppManagerEvent.UPDATE_GROUP_SUCCESS,updateGroupSuccessHandler);
			AppManager.getInstance().addEventListener(AppManagerEvent.CREATE_GROUP_SUCCESS,createGroupSuccessHandler);
			Api.getInstane().addEventListener(ApiEvent.JOIN_GROUP_SUCCESS, joinGroupSuccessHandler)
			Api.getInstane().addEventListener(ApiEvent.JOIN_GROUP_FAULT, joinGroupFaultHandler)
		}
		
		private var groupsList:List
		private var signoutBtn:Image
		private var goback:Image;
		private var userInfoView : UserInfoView2
		private var joinGroupBtn : ImgBtn;
		private var createGroupBtn : ImgBtn;
		
		private var groupsData:Array
		
		private var bgImg:Image;
		private var titleImg:Image;
		private var gonggaoImg:Image;
		private var meiziImg:Image;
		private var createGroupImg:ImageBtnWithUpAndDown;
		private var joinGroupImg:ImageBtnWithUpAndDown;
		
		override protected function createChildren():void {
			super.createChildren()
			
			bgImg = new Image();
			bgImg.width = 1280;
			bgImg.height = 720;
			bgImg.source = 'assets/hall/guild_hall_bg.png';
			addChild(bgImg);
			bgImg.visible = false;
			
			titleImg = new Image();
			titleImg.width = 400;
			titleImg.height = 92;
			titleImg.source = 'assets/hall/guild_hall_logo.png';
			addChild(titleImg);
			titleImg.visible = false;
			
			gonggaoImg = new Image();
			gonggaoImg.width = 360;
			gonggaoImg.height = 480;
			gonggaoImg.source = 'assets/hall/guild_hall_info.png';
			addChild(gonggaoImg);
			gonggaoImg.visible = false;
			
			meiziImg = new Image();
			meiziImg.width = 239;
			meiziImg.height = 393;
			meiziImg.source = 'assets/hall/guild_hall_npc.png';
			addChild(meiziImg);
			meiziImg.visible = false;
			
			userInfoView =new UserInfoView2();
			addChild(userInfoView);
			userInfoView.visible = false;
			
			groupsList = new List()
			groupsList.padding = 20
			groupsList.gap = 10
			groupsList.labelField = 'group_id'
			groupsList.horizontalScrollEnabled = true
			groupsList.verticalScrollEnabled = false
			groupsList.itemRendererClass = GroupRenderer
			groupsList.itemRendererRowCount = 1
			groupsList.itemRendererHeight = 456
			groupsList.itemRendererWidth = 345
			groupsList.horizontalAlign = HorizontalAlign.CENTER
			groupsList.verticalAlign = VerticalAlign.MIDDLE
			groupsList.addEventListener(UIEvent.CHANGE, groupsList_changeHandler)
			addChild(groupsList)
			groupsList.visible = false;
			
			goback = new Image();
			goback.source = 'assets/club_btn_back.png';
			goback.width = 71;
			goback.height = 86;
			goback.addEventListener(MouseEvent.CLICK,gobackHandler);
			addChild(goback);
			
			joinGroupBtn = new ImgBtn();
			joinGroupBtn.imgSource = 'assets/hall/join_group.png';
			joinGroupBtn.width = 140*1.5;
			joinGroupBtn.height = 40*1.5;
			joinGroupBtn.labText = '加入亲友圈';
			joinGroupBtn.labFontSize = 20*1.5;
			joinGroupBtn.labColor = 0xffffff;
			joinGroupBtn.addEventListener(MouseEvent.CLICK,joinGroupHandler);
			addChild(joinGroupBtn);
			
			createGroupBtn = new ImgBtn();
			createGroupBtn.imgSource = 'assets/hall/create_group.png';
			createGroupBtn.width = 140*1.5;
			createGroupBtn.height = 40*1.5;
			createGroupBtn.labText = '创建亲友圈';
			createGroupBtn.labFontSize = 20*1.5;
			createGroupBtn.labColor = 0xffffff;
			createGroupBtn.addEventListener(MouseEvent.CLICK,createGroupHandler);
			addChild(createGroupBtn);
		}
		
		protected function gobackHandler(event:MouseEvent):void
		{
			MainView.getInstane().pushView(HomeView);
		}
		
		override protected function updateDisplayList():void{
			super.updateDisplayList();
			
			//			createGroupBtn.visible = AppData.getInstane().user.is_admin=='T'
			AppData.getInstane().inGroupView = false;
			
			bgImg.x = bgImg.y = 0;
			titleImg.x = (width-titleImg.width)/2;
			titleImg.y = 0;
			
			gonggaoImg.x = width/2-gonggaoImg.width-20;
			gonggaoImg.y = height-gonggaoImg.height-30;
			
			meiziImg.y = gonggaoImg.y;
			meiziImg.x = gonggaoImg.x+gonggaoImg.width+30;
			
			
			groupsList.width = width
			groupsList.height = groupsList.itemRendererHeight*1.1
			groupsList.y = (height-groupsList.height)/2
			
			goback.x = width - goback.width - 20
			goback.y = 20;
			
			joinGroupBtn.x = width - joinGroupBtn.width-60;
			joinGroupBtn.y = height-joinGroupBtn.height-5;
			
			createGroupBtn.x = joinGroupBtn.x-10-createGroupBtn.width;
			createGroupBtn.y = joinGroupBtn.y;
		}
		
		private var i:int = 1
		private var selectedItem:Object
		
		protected function groupsList_changeHandler(event:UIEvent):void
		{
			if(!groupsList.selectedItem){
				return
			}
			selectedItem = groupsList.selectedItem;
			Loading.getInstance().open()
			Api.getInstane().joinGroup(AppData.getInstane().user.username, int(selectedItem.group_id))
			groupsList.selectedIndex = -1
		}
		
		public function init():void {
			if(AppData.getInstane().user.group_info==null){
				AppData.getInstane().user.group_info="[]"
				groupsData = [];
			}else{
				groupsData = JSON.parse(AppData.getInstane().user.group_info) as Array;
			}
			HttpApi.getInstane().getUserInfoByName(AppData.getInstane().username,function(e:Event):void{
				//								trace('大厅界面：金币',JSON.parse(e.currentTarget.data).message[0].group_info);
				//				trace('大厅界面：房卡',JSON.parse(e.currentTarget.data).message[0].room_card);
				//				trace('大厅界面：用户id',JSON.parse(e.currentTarget.data).message[0].id);
				var room_card:String = JSON.parse(e.currentTarget.data).message[0].room_card?JSON.parse(e.currentTarget.data).message[0].room_card+'':'0'
				var user_id:String = JSON.parse(e.currentTarget.data).message[0].id+''
				AppData.getInstane().user.userId = user_id;
				userInfoView.userInfoData = {"roomCard":room_card,'userName':AppData.getInstane().username}
			},null);
			getAllGroupInfo();
			invalidateDisplayList();
		}
		
		/**
		 * 查询group表，获取所有群信息
		 */
		private function getAllGroupInfo():void{
			HttpApi.getInstane().getAllGroupInfo(function(e:Event):void{
				var groupArr : Array = JSON.parse(e.currentTarget.data).message as Array;///所有组群信息
				for each (var j:Object in groupArr) {
					for each (var k:Object in groupsData) {
						if(k.group_id==j.id){
							k.name = j.name
							k.admin_id = j.admin_id
							k.remark = j.remark
						}
					}
				}
				groupsList.dataProvider = groupsData
				//				groupsList.dataProvider = []
				refreshView();
			},null);
		}
		
		private function refreshView():void
		{
			if(groupsList.dataProvider.length>0){
				bgImg.visible = gonggaoImg.visible = meiziImg.visible = titleImg.visible = false;
				userInfoView.visible = groupsList.visible = true;
			}else{
				bgImg.visible = gonggaoImg.visible = meiziImg.visible = titleImg.visible = true;
				userInfoView.visible = groupsList.visible = false;
			}
		}
		
		public function dispose():void {
			Audio.getInstane().stopBGM()
		}
		
		/**
		 * 创建亲友圈
		 */
		protected function createGroupHandler(event:MouseEvent):void{
			var createCroupPanel : CreateGroupPanel;
			if(!createCroupPanel){
				createCroupPanel = new CreateGroupPanel();
			}
			PopUpManager.centerPopUp(PopUpManager.addPopUp(createCroupPanel,null,true,false,0xffffff,0.5));
		}
		
		/**
		 * 加入亲友圈
		 */
		protected function joinGroupHandler(event:MouseEvent):void{
			//			trace("加入亲友圈");
		}		
		
		/**
		 *监听到群信息更新成功 
		 */
		protected function updateGroupSuccessHandler(event:AppManagerEvent):void{
			getAllGroupInfo();
		}
		
		/**
		 * 创建亲友圈群成功
		 */
		protected function createGroupSuccessHandler(event:Event):void
		{
			HttpApi.getInstane().getUserInfoById(AppData.getInstane().user.id,function(e:Event):void{
				var group_info_arr:Array = JSON.parse(JSON.parse(e.currentTarget.data).message[0].group_info) as Array;
				AppData.getInstane().user.group_info = JSON.stringify(group_info_arr);
				init();
			},null);
		}
		
		protected function joinGroupSuccessHandler(event:ApiEvent):void
		{
			trace('跳转到群')
			Loading.getInstance().close()
			GroupViewNew(MainView.getInstane().pushView(GroupViewNew)).init(selectedItem.group_id, 
				selectedItem.name,
				selectedItem.admin_id,
				selectedItem.remark,
				event.data as Array)
		}
		
		protected function joinGroupFaultHandler(event:ApiEvent):void {
			Loading.getInstance().close()
			Alert.show(JSON.stringify(event.data))
		}
		
	}
}