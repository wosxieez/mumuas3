package com.xiaomu.view.hall
{
	import com.xiaomu.component.ImgBtn;
	import com.xiaomu.renderer.ButtonRenderer;
	import com.xiaomu.renderer.GroupRenderer;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.Assets;
	import com.xiaomu.util.Audio;
	import com.xiaomu.util.HttpApi;
	import com.xiaomu.view.MainView;
	import com.xiaomu.view.group.GroupView;
	import com.xiaomu.view.login.LoginView;
	import com.xiaomu.view.userBarView.UserInfoVIew;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
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
		}
		
		private var topbg:Image
		private var bottombg:Image
		private var btnsList:List
		private var groupsList:List
		private var signoutBtn:Image
		private var userInfoView : UserInfoVIew
		private var joinGroupBtn : ImgBtn;
		private var createGroupBtn : ImgBtn;
		
		private var _groupsData:Array
		
		public function get groupsData():Array
		{
			return _groupsData;
		}
		
		public function set groupsData(value:Array):void
		{
			_groupsData = value;
			invalidateProperties()
		}
		
		override protected function createChildren():void {
			super.createChildren()
			
			topbg = new Image()
			topbg.source = 'assets/hall/home_top_headbg.png'
			topbg.height = 30
			addChild(topbg)
			
			bottombg = new Image()
			bottombg.source = 'assets/hall/img_home_btnsBg.png'
			bottombg.height = 30
			addChild(bottombg)
			
			userInfoView = new UserInfoVIew();
			userInfoView.width = 300;
			userInfoView.height = 40;
			userInfoView.inRoomFlag = false;
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
			
			signoutBtn = new Image()
			signoutBtn.width = 55
			signoutBtn.height = 20
			signoutBtn.y = 5
			signoutBtn.addEventListener(MouseEvent.CLICK, signoutBtn_clickHandler)
			signoutBtn.source = 'assets/hall/setting_out_press.png'
			addChild(signoutBtn)
			
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
		
		protected function signoutBtn_clickHandler(event:MouseEvent):void
		{
			dispose()
			MainView.getInstane().popView(LoginView)
			//			trace("测试");
			//			HttpApi.getInstane().updateUserGroupInfo(AppData.getInstane().username,
			//				[{group_id:1,gold:100},{group_id:2,gold:200},{group_id:4,gold:300}],function(e:Event):void{},null);
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			groupsList.dataProvider = groupsData
		}
		
		override protected function updateDisplayList():void{
			super.updateDisplayList();
			
			topbg.width = width
			
			bottombg.width = width
			bottombg.y = height - bottombg.height
			
			groupsList.width = width
			groupsList.height = bottombg.y - groupsList.y
			
			btnsList.width = width
			btnsList.y = bottombg.y
			
			signoutBtn.x = width - signoutBtn.width - 5
			
			joinGroupBtn.x = width - joinGroupBtn.width-40;
			joinGroupBtn.y = height-joinGroupBtn.height-5;
			
			createGroupBtn.x = joinGroupBtn.x-10-createGroupBtn.width;
			createGroupBtn.y = joinGroupBtn.y;
		}
		
		private var i:int = 1
		
		protected function groupsList_changeHandler(event:UIEvent):void
		{
			var groupid:int = int(groupsList.selectedItem.group_id)
			setTimeout(function ():void { groupsList.selectedIndex = -1 }, 200)
			GroupView(MainView.getInstane().pushView(GroupView)).init(groupid)
		}
		
		public function init():void {
			groupsData = JSON.parse(AppData.getInstane().user.group_info) as Array;
			Audio.getInstane().playBGM('assets/bgm.mp3')
			Assets.getInstane().loadAssets('assets/mumu.png', 'assets/mumu.json')
			HttpApi.getInstane().getUserInfo(AppData.getInstane().username,function(e:Event):void{
				//				trace('大厅界面：金币',JSON.parse(e.currentTarget.data).message[0].group_info);
				//				trace('大厅界面：房卡',JSON.parse(e.currentTarget.data).message[0].room_card);
				//				trace('大厅界面：用户id',JSON.parse(e.currentTarget.data).message[0].id);
				AppData.getInstane().user.userId = JSON.parse(e.currentTarget.data).message[0].id+'';
				userInfoView.userInfoData = {"roomCard":JSON.parse(e.currentTarget.data).message[0].room_card+'','userName':AppData.getInstane().username}
			},null);
		}
		
		public function dispose():void {
			Audio.getInstane().stopBGM()
		}
		
		/**
		 * 创建亲友圈
		 */
		protected function createGroupHandler(event:MouseEvent):void
		{
			var createCroupPanel : CreateGroupPanel;
			if(!createCroupPanel){
				createCroupPanel = new CreateGroupPanel();
			}
			PopUpManager.addPopUp(createCroupPanel,null,false,true);
			PopUpManager.centerPopUp(createCroupPanel);
		}
		
		/**
		 * 加入亲友圈
		 */
		protected function joinGroupHandler(event:MouseEvent):void
		{
//			trace("加入亲友圈");
		}		
		
		
	}
}