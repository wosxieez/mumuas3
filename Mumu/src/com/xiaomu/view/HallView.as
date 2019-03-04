package com.xiaomu.view
{
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.Assets;
	import com.xiaomu.view.home.HomeView;
	import com.xiaomu.view.registered.RegisterView;
	import com.xiaomu.view.user.UserInfo;
	
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import coco.component.Button;
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
		
		private var bg : Image;
		private var createRoom:Button;
		private var joinRoom:Button;
		private var goBackBtn : Button;
		private var userInfo : UserInfo;
		private var groupsList:List
		private var _groupsData:Array
		private var groupLab:Image;
		private var goBack:Button;
		private var titlelab:Label;
		
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
			
			bg = new Image()
			bg.source = 'assets/hall/hall_bg.png';
			addChild(bg)
			
			userInfo = new UserInfo();
			addChild(userInfo);
			
			goBack = new Button();
			goBack.label = '返回';
			goBack.width = 40;
			goBack.height = 20;
			goBack.addEventListener(MouseEvent.CLICK,goBackHandler);
			addChild(goBack);
			
			titlelab = new Label();
			titlelab.text = '我的亲友圈';
			titlelab.color = 0xffffff;
			addChild(titlelab);
			
			groupsList = new List()
			groupsList.itemRendererColumnCount = 3;
			groupsList.itemRendererHeight = 30;
			groupsList.gap = 5;
			groupsList.width = 200
			groupsList.height = 200
			groupsList.addEventListener(UIEvent.CHANGE, groupsList_changeHandler)
			addChild(groupsList)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			groupsList.dataProvider = groupsData
		}
		
		override protected function updateDisplayList():void{
			super.updateDisplayList();
			
			bg.width = width;
			bg.height = height;
			
			goBack.x = width-40;
			goBack.y = 0;
			
			
			groupsList.x = (width-groupsList.width)/2;
			groupsList.y = 80
			titlelab.x = groupsList.x;
			titlelab.y = groupsList.y-30;
		}
		
		protected function goBackHandler(event:MouseEvent):void
		{
			MainView.getInstane().pushView(HomeView);
		}
		
		private var i:int = 1
		
		protected function groupsList_changeHandler(event:UIEvent):void
		{
			var groupid:int = int(groupsList.selectedItem)
			setTimeout(function ():void { groupsList.selectedIndex = -1 }, 200)
			GroupView(MainView.getInstane().pushView(GroupView)).init(groupid)
		}
		
		public function init():void {
			groupsData = AppData.getInstane().user.group_ids.split(',')
			//			Audio.getInstane().playBGM('assets/bgm.mp3')
			Assets.getInstane().loadAssets('assets/mumu.png', 'assets/mumu.json')
		}
		
	}
}