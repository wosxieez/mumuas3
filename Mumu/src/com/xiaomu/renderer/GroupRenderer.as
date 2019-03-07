package com.xiaomu.renderer
{
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	
	public class GroupRenderer extends DefaultItemRenderer
	{
		public function GroupRenderer()
		{
			super();
		    borderAlpha = 0
			backgroundAlpha = 0
		}
		
		private var icon:Image
		override protected function createChildren():void {
			icon = new Image()
			icon.source = 'assets/hall/home_club_bg.png'
			addChild(icon)
			
			super.createChildren()
			labelDisplay.color = 0xFFFFFF
				
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			icon.width = width
			icon.height = height
				
			labelDisplay.width = width
			labelDisplay.height = 30
			labelDisplay.y = height - 30
		}
		
	}
}