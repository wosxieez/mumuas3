package com.xiaomu.view
{
	import com.xiaomu.event.ApiEvent;
	import com.xiaomu.util.Api;
	import com.xiaomu.util.Assets;
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
			groupsList.labelField = 'name'
			groupsList.itemRendererRowCount = 1
			groupsList.padding = 50
			groupsList.verticalAlign = VerticalAlign.JUSTIFY
			groupsList.horizontalAlign = HorizontalAlign.JUSTIFY
			groupsList.addEventListener(UIEvent.CHANGE, groupsList_changeHandler)
			addChild(groupsList)
			
			Api.getInstane().addEventListener(ApiEvent.GET_GROUPS_SUCCESS, getGroupsSuccessHandler)
			Api.getInstane().getGroups()
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
		
		protected function getGroupsSuccessHandler(event:ApiEvent):void
		{
			groupsData = event.data as Array
		}
		
		protected function groupsList_changeHandler(event:UIEvent):void
		{
			const groupid:int = groupsList.selectedItem.id
			setTimeout(function ():void { groupsList.selectedIndex = -1 }, 200)
			MainView.getInstane().pushView(GroupView)
			Api.getInstane().getRooms(groupid)
		}
		
	}
}