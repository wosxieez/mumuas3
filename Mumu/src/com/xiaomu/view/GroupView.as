package com.xiaomu.view
{
	import com.xiaomu.event.ApiEvent;
	import com.xiaomu.util.Api;
	
	import coco.component.HorizontalAlign;
	import coco.component.List;
	import coco.core.UIComponent;
	
	
	/**
	 * 群视图 
	 * @author coco
	 * 
	 */	
	public class GroupView extends UIComponent
	{
		public function GroupView()
		{
			super();
			
			Api.getInstane().addEventListener(ApiEvent.GET_ROOMS_SUCCESS, getRoomsSuccessHandler)
		}
		
		private var roomsList:List
		private var usersList:List
		
		override protected function createChildren():void {
			super.createChildren()
				
			roomsList = new List()
			roomsList.itemRendererColumnCount = 2
			roomsList.horizontalAlign = HorizontalAlign.JUSTIFY
			roomsList.padding = roomsList.gap = 20
			addChild(roomsList)
			
			usersList = new List()
			usersList.dataProvider = ['用户1', '用户2', '用户3', '用户4']
			usersList.width = 100
			addChild(usersList)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
				
			roomsList.height = usersList.height = height
			roomsList.width = usersList.x = width - usersList.width
		}
		
		protected function getRoomsSuccessHandler(event:ApiEvent):void
		{
			roomsList.dataProvider = event.data as Array
		}
		
	}
}