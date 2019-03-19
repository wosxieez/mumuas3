package com.xiaomu.view.hall
{
	import com.xiaomu.component.ImgBtn;
	import com.xiaomu.event.AppManagerEvent;
	import com.xiaomu.manager.AppManager;
	import com.xiaomu.renderer.ButtonRenderer;
	import com.xiaomu.renderer.GroupRenderer;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.Assets;
	import com.xiaomu.util.Audio;
	import com.xiaomu.util.HttpApi;
	import com.xiaomu.view.MainView;
	import com.xiaomu.view.group.GroupView;
	import com.xiaomu.view.hall.popUpPanel.CreateGroupPanel;
	import com.xiaomu.view.home.HomeView;
	import com.xiaomu.view.userBarView.UserInfoView;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import coco.component.Button;
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
		}
		
		private var topbg:Image
		private var bottombg:Image
		private var btnsList:List
		private var groupsList:List
		private var signoutBtn:Image
		private var goback:Button;
		private var userInfoView : UserInfoView
		private var joinGroupBtn : ImgBtn;
		private var createGroupBtn : ImgBtn;
		
		private var groupsData:Array
		
		
		override protected function createChildren():void {
			super.createChildren()
			
			topbg = new Image()
			topbg.source = 'assets/hall/home_top_headbg.png'
			topbg.height = 40
			addChild(topbg)
			
			bottombg = new Image()
			bottombg.source = 'assets/hall/img_home_btnsBg.png'
			bottombg.height = 30
			addChild(bottombg)
			
			userInfoView =new UserInfoView();
			addChild(userInfoView);
			
			groupsList = new List()
			groupsList.y = 30
			groupsList.padding = 30
			groupsList.gap = 10
			groupsList.labelField = 'group_id'
			groupsList.horizontalScrollEnabled = true
			groupsList.verticalScrollEnabled = false
			groupsList.itemRendererClass = GroupRenderer
			groupsList.itemRendererRowCount = 1
			groupsList.itemRendererHeight = 132
			groupsList.itemRendererWidth = 100
			groupsList.horizontalAlign = HorizontalAlign.CENTER
			groupsList.verticalAlign = VerticalAlign.MIDDLE
			groupsList.addEventListener(UIEvent.CHANGE, groupsList_changeHandler)
			addChild(groupsList)
			
			btnsList = new List()
			btnsList.gap = 15
			btnsList.padding = 5
			btnsList.height = 30
			btnsList.labelField = 'name'
			btnsList.horizontalScrollEnabled = false
			btnsList.verticalScrollEnabled = false
			btnsList.itemRendererClass = ButtonRenderer
			btnsList.itemRendererRowCount = 1
			btnsList.itemRendererHeight = 20
			btnsList.itemRendererWidth = 50
			btnsList.dataProvider = ['1', '2', '3', '4', '5', '6']
			btnsList.horizontalAlign = HorizontalAlign.CENTER
			btnsList.verticalAlign = VerticalAlign.MIDDLE
			addChild(btnsList)
			btnsList.visible = false;
			
//			signoutBtn = new Image()
//			signoutBtn.width = 55
//			signoutBtn.height = 20
//			signoutBtn.y = 5
//			signoutBtn.addEventListener(MouseEvent.CLICK, signoutBtn_clickHandler)
//			signoutBtn.source = 'assets/hall/setting_out_press.png'
//			addChild(signoutBtn)
			
			goback = new Button();
			goback.label = '返回'
			goback.width = goback.height = 20;
			goback.addEventListener(MouseEvent.CLICK,gobackHandler);
			addChild(goback);
			
			joinGroupBtn = new ImgBtn();
			joinGroupBtn.imgSource = 'assets/hall/join_group.png';
			joinGroupBtn.width = 70;
			joinGroupBtn.height = 20;
			joinGroupBtn.labText = '加入亲友圈';
			joinGroupBtn.labFontSize = 10;
			joinGroupBtn.labColor = 0xffffff;
			joinGroupBtn.addEventListener(MouseEvent.CLICK,joinGroupHandler);
			addChild(joinGroupBtn);
			
			
			createGroupBtn = new ImgBtn();
			createGroupBtn.imgSource = 'assets/hall/create_group.png';
			createGroupBtn.width = 70;
			createGroupBtn.height = 20;
			createGroupBtn.labText = '创建亲友圈';
			createGroupBtn.labFontSize = 10;
			createGroupBtn.labColor = 0xffffff;
			createGroupBtn.addEventListener(MouseEvent.CLICK,createGroupHandler);
			addChild(createGroupBtn);
		}
		
		protected function gobackHandler(event:MouseEvent):void
		{
			MainView.getInstane().pushView(HomeView);
		}
		
		/*protected function signoutBtn_clickHandler(event:MouseEvent):void
		{
			AppData.getInstane().inGroupView = false;
			dispose()
			MainView.getInstane().popView(LoginView)
		}*/
		
		override protected function updateDisplayList():void{
			super.updateDisplayList();
			
			AppData.getInstane().inGroupView = false;
			topbg.width = width
			
			bottombg.width = width
			bottombg.y = height - bottombg.height
			
			groupsList.width = width
			groupsList.height = bottombg.y - groupsList.y
			
			btnsList.width = width
			btnsList.y = bottombg.y
			
//			signoutBtn.x = width - signoutBtn.width - 5
			goback.x = width - goback.width - 5
			
			joinGroupBtn.x = width - joinGroupBtn.width-40;
			joinGroupBtn.y = height-joinGroupBtn.height-5;
			
			createGroupBtn.x = joinGroupBtn.x-10-createGroupBtn.width;
			createGroupBtn.y = joinGroupBtn.y;
		}
		
		private var i:int = 1
		
		protected function groupsList_changeHandler(event:UIEvent):void
		{
			if(!groupsList.selectedItem){
				return
			}
			var selectedItem:Object = groupsList.selectedItem;
			var groupId:int = int(groupsList.selectedItem.group_id)///群id
			var groupAdminId:int = groupsList.selectedItem.admin_id///该群群主id
			var userId:int = AppData.getInstane().user.id///用户自身id
			HttpApi.getInstane().getUserInfoById(groupAdminId,function(e:Event):void{
				///群消息对象
				var groupInfoObj:Object={
					'group_id':selectedItem.group_id,
					'group_name':selectedItem.name,
					'remark':selectedItem.remark,
					'admin_id':selectedItem.admin_id,
					'admin_name':JSON.parse(e.currentTarget.data).message[0].username}
				GroupView(MainView.getInstane().pushView(GroupView)).init(groupId,groupAdminId,groupInfoObj)///进入房间界面，初始化，输入组id,同时传入需要该组的群主id
			},null)
			setTimeout(function ():void { groupsList.selectedIndex = -1 }, 200)
		}
		
		public function init():void {
			if(AppData.getInstane().user.group_info==null){
				AppData.getInstane().user.group_info=[]
				groupsData = [];
			}else{
				groupsData = JSON.parse(AppData.getInstane().user.group_info) as Array;
			}
//			Audio.getInstane().playBGM('assets/bgm.mp3')
			Assets.getInstane().loadAssets('assets/niu.png', 'assets/niu.json')
			HttpApi.getInstane().getUserInfoByName(AppData.getInstane().username,function(e:Event):void{
				//				trace('大厅界面：金币',JSON.parse(e.currentTarget.data).message[0].group_info);
				//				trace('大厅界面：房卡',JSON.parse(e.currentTarget.data).message[0].room_card);
				//				trace('大厅界面：用户id',JSON.parse(e.currentTarget.data).message[0].id);
				var room_card:String = JSON.parse(e.currentTarget.data).message[0].room_card?JSON.parse(e.currentTarget.data).message[0].room_card+'':'0'
				var user_id:String = JSON.parse(e.currentTarget.data).message[0].id+''
				AppData.getInstane().user.userId = user_id;
				userInfoView.userInfoData = {"roomCard":room_card,'userName':AppData.getInstane().username}
			},null);
			getAllGroupInfo();
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
			},null);
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
			createCroupPanel.width = width*0.8;
			createCroupPanel.height = height*0.8;
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
		
	}
}