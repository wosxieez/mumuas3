package com.xiaomu.view.room
{
	import coco.component.HGroup;
	import coco.component.HorizontalAlign;
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.VerticalAlign;
	import coco.core.UIComponent;
	
	public class WinTypes extends UIComponent
	{
		public function WinTypes()
		{
			super();
		}
		
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

		private var huXiDisplay:Label
		private var content:HGroup
		
		override protected function createChildren():void {
			super.createChildren()
				
			content = new HGroup()
			content.gap = 1
			content.horizontalAlign = HorizontalAlign.CENTER
			content.verticalAlign = VerticalAlign.MIDDLE
			addChild(content)
			
			huXiDisplay = new Label()
			huXiDisplay.fontSize = 15
			addChild(huXiDisplay)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
				
			content.removeAllChild()
				
			if (!data) return
			huXiDisplay.text = '胡息' + data.hx
				
			for each(var type:int in data.hts) {
				var image:Image = new Image()
				image.width = 80
				image.height = 89
				image.source = "assets/room/hts/" + type + '.png'
				content.addChild(image)
			}
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
				
			huXiDisplay.width = width
				
			content.width = width
			content.height = height
		}
		
	}
}