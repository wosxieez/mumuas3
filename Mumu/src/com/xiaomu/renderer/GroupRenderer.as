package com.xiaomu.renderer
{
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	import coco.component.Label;
	
	public class GroupRenderer extends DefaultItemRenderer
	{
		public function GroupRenderer()
		{
			super();
		    borderAlpha = 0
			backgroundAlpha = 0
		}
		
		private var _data:Object;

		override public function get data():Object
		{
			return _data;
		}

		override public function set data(value:Object):void
		{
			_data = value;
			invalidateProperties();
		}

		private var icon:Image
		private var nameLab:Label;
		override protected function createChildren():void {
			icon = new Image()
			icon.source = 'assets/hall/home_club_bg.png'
			addChild(icon)
			
			super.createChildren()
			labelDisplay.color = 0xFFFFFF
			labelDisplay.visible = false;
			
			nameLab = new Label();
			nameLab.color = 0xFFFFFF;
			addChild(nameLab);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			nameLab.text = data.groupname ? data.groupname: '/';
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			icon.width = width*0.9
			icon.height = height*0.9
			icon.x = (width-icon.width)/2-10;
			icon.y = (height-icon.height)/2;
				
			labelDisplay.width = width
			labelDisplay.height = 30
			labelDisplay.y = height - 35
				
			nameLab.width = width;
			nameLab.height = 35;
			nameLab.fontSize = 30;
			nameLab.y = height-25;
		}
		
	}
}