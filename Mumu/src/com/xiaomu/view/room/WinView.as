package com.xiaomu.view.room
{
	import coco.component.Image;
	import coco.core.UIComponent;
	
	public class WinView extends UIComponent
	{
		public function WinView()
		{
			super();
			
			width = 960
			height = 600
		}
		
		private static var instance:WinView
		
		public static function getInstane(): WinView {
			if (!instance) {
				instance = new WinView()
			}
			
			return instance
		}
		
		private var background:Image
		private var items:Array = []
		
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
			
			background = new Image()
			background.source = 'assets/room/win_bg.png'
			addChild(background)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			if (data) {
				const riffleCards:Array = this.data.users
				var oldItems:Array = []
				for each(var item: WinItem in items) {
					item.visible = false
					oldItems.push(item)
				}
				items = []
					
				var newItem:WinItem
				const itemHeight:Number = 80
				for (var i:int = 0; i < data.users.length; i++) {
					newItem = oldItems.pop()
					if (!newItem) {
						newItem = new WinItem()
						addChild(newItem)
					}
					newItem.visible = true
					newItem.height = itemHeight
					newItem.y = itemHeight * i
					newItem.data = data.users[i]
					items.push(newItem)
				}
			}
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			background.width = width
			background.height = height
		}
		
		override protected function drawSkin():void {
			super.drawSkin()
		}
		
		
	}
}