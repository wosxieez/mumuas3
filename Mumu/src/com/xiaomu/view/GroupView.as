package com.xiaomu.view
{
	import com.xiaomu.util.Api;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import coco.component.Button;
	import coco.component.HorizontalAlign;
	import coco.component.List;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	
	
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
		}
		
		private var roomsList:List
		private var usersList:List
		
		override protected function createChildren():void {
			super.createChildren()
			
			roomsList = new List()
			roomsList.labelField = 'name'
			roomsList.itemRendererColumnCount = 2
			roomsList.horizontalAlign = HorizontalAlign.JUSTIFY
			roomsList.padding = roomsList.gap = 20
			roomsList.addEventListener(UIEvent.CHANGE, roomsList_changeHandler)
			addChild(roomsList)
			
			usersList = new List()
			usersList.width = 100
			addChild(usersList)
			
			var button:Button = new Button()
			button.label = 'leave'
			button.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
				Api.getInstane().leaveGroup()			
				MainView.getInstane().pushView(HallView)
			})
			addChild(button)
		}
		
		protected function roomsList_changeHandler(event:UIEvent):void
		{
			const roominfo:Object = roomsList.selectedItem
			setTimeout(function ():void { roomsList.selectedIndex = -1 }, 200)
			RoomView(MainView.getInstane().pushView(RoomView)).init(roominfo)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			roomsList.height = usersList.height = height
			roomsList.width = usersList.x = width - usersList.width
		}
		
		public function init(groupid:int): void {
			Api.getInstane().joinGroup(AppData.getInstane().user.username, groupid)
			HttpApi.getInstane().listRooms(groupid, function ok(e:Event):void {
				const response:Object = JSON.parse(e.currentTarget.data)
				trace(JSON.stringify(response))
				if (response.result == 0 && response.message) {
					roomsList.dataProvider = response.message
				} 
			}, function error(e:Event):void {})
		}
		
	}
}