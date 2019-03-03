package com.xiaomu.view
{
	import com.xiaomu.util.Api;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.Assets;
	import com.xiaomu.util.Audio;
	import com.xiaomu.view.registered.RegisterView;
	import com.xiaomu.view.user.UserInfo;
	
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import coco.component.Button;
	import coco.component.HorizontalAlign;
	import coco.component.Image;
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
			bg.source = Assets.getInstane().getAssets('hall_bg.png')
			addChild(bg)
			
			userInfo = new UserInfo();
			addChild(userInfo);
			
			groupsList = new List()
			groupsList.itemRendererRowCount = 1
			groupsList.padding = 50
			groupsList.verticalAlign = VerticalAlign.JUSTIFY
			groupsList.horizontalAlign = HorizontalAlign.JUSTIFY
			groupsList.addEventListener(UIEvent.CHANGE, groupsList_changeHandler)
			addChild(groupsList)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			groupsList.dataProvider = groupsData
		}
		
		protected function goBackHandler(event:MouseEvent):void
		{
			MainView.getInstane().pushView(RegisterView);
		}
		
		override protected function updateDisplayList():void{
			super.updateDisplayList();
			
			bg.width = width;
			bg.height = height;
			
			groupsList.width = width
			groupsList.height = height
		}
		
		private var i:int = 1
		
		protected function groupsList_changeHandler(event:UIEvent):void
		{
			var groupid:int = int(groupsList.selectedItem)
			setTimeout(function ():void { groupsList.selectedIndex = -1 }, 200)
			Api.getInstane().joinGroup('wosxieez' + i++, 2)
			//			GroupView(MainView.getInstane().pushView(GroupView)).init(groupid)
		}
		
		public function init():void {
			groupsData = AppData.getInstane().user.group_ids.split(',')
			//			Audio.getInstane().playBGM('assets/bgm.mp3')
			Assets.getInstane().loadAssets('assets/mumu.png', 'assets/mumu.json')
		}
		
	}
}