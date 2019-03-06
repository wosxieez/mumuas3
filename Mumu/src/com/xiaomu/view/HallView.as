package com.xiaomu.view
{
	import com.xiaomu.renderer.ButtonRenderer;
	import com.xiaomu.renderer.GroupRenderer;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.Assets;
	import com.xiaomu.util.Audio;
	import com.xiaomu.util.HttpApi;
	import com.xiaomu.view.login.LoginView;
	import com.xiaomu.view.userBarView.UserInfoVIew;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import coco.component.HorizontalAlign;
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.List;
	import coco.component.VerticalAlign;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	
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
//		private var userIcon:Image
//		private var userLabel:Label
		private var btnsList:List
		private var groupsList:List
		private var signoutBtn:Image
		private var userInfoView : UserInfoVIew
		
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
			
//			userIcon = new Image
//			userIcon.source = 'assets/hall/usericon.png'
//			userIcon.width = userIcon.height = 26
//			userIcon.x = userIcon.y = 2
//			addChild(userIcon)
//			
//			userLabel = new Label()
//			userLabel.x = 30
//			userLabel.height = 30
//			userLabel.color = 0xFFFFFF
//			addChild(userLabel)
			
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
			
			signoutBtn = new Image()
			signoutBtn.width = 55
			signoutBtn.height = 20
			signoutBtn.y = 5
			signoutBtn.addEventListener(MouseEvent.CLICK, signoutBtn_clickHandler)
			signoutBtn.source = 'assets/hall/setting_out_press.png'
			addChild(signoutBtn)
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
			
//			userLabel.text = AppData.getInstane().user.username
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
				userInfoView.userInfoData = {"roomCard":JSON.parse(e.currentTarget.data).message[0].room_card+'','userName':AppData.getInstane().username}
			},null);
		}
		
		public function dispose():void {
			Audio.getInstane().stopBGM()
		}
		
	}
}