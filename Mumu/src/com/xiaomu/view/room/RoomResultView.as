package com.xiaomu.view.room
{
	import com.xiaomu.util.AppData;
	
	import coco.component.Group;
	import coco.layout.VerticalLayout;
	
	public class RoomResultView extends Group
	{
		public function RoomResultView()
		{
			super();
			
			width = 210
			height = 190
			
			var vlayout:VerticalLayout = new VerticalLayout()
			vlayout.gap = 0
			vlayout.padding = 5
			this.layout = vlayout
		}
		
		private static var instance:RoomResultView
		
		public static function getInstane(): RoomResultView {
			if (!instance) {
				instance = new RoomResultView()
			}
			
			return instance
		}
		
		private var preItem:RoomResultItem
		private var myItem:RoomResultItem
		private var nextItem:RoomResultItem
		
		private var _data:Object
		
		public function get data():Object
		{
			return _data;
		}
		
		public function set data(value:Object):void
		{
			_data = value;
			invalidateProperties()
		}
		
		override protected function createChildren():void {
			super.createChildren()
			
			preItem = new RoomResultItem()
			addChild(preItem)
			
			myItem = new RoomResultItem()
			addChild(myItem)
			
			nextItem = new RoomResultItem()
			addChild(nextItem)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			if (data) {
				for (var i:int = 0; i < data.users.length; i++) {
					if (data.users[i].username == AppData.getInstane().user.username) {
						var endUsers:Array = data.users.slice(i)
						var startUsers:Array = data.users.slice(0, i)
						var orderUsers:Array = endUsers.concat(startUsers)
						myItem.data = orderUsers[0]
						nextItem.data = orderUsers[1]
						preItem.data = orderUsers.pop()
						break
					}
				}
			}
		}
		
		override protected function drawSkin():void {
			super.drawSkin()
				
			graphics.clear()
			graphics.beginFill(0x000000, .8)
			graphics.drawRoundRect(0, 0, width, height, 5, 5)
			graphics.endFill()
		}
		
		
	}
}