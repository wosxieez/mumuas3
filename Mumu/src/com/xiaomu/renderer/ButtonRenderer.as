package com.xiaomu.renderer
{
	import coco.component.Image;
	import coco.component.ItemRenderer;
	
	public class ButtonRenderer extends ItemRenderer
	{
		public function ButtonRenderer()
		{
			super();
		    borderAlpha = 0
			backgroundAlpha = 0
		}
		
		private var icon:Image
		
		override protected function createChildren():void {
			super.createChildren()
				
			icon = new Image()
			icon.source = 'assets/hall/home_btn_creategroup.png'
			addChild(icon)
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			icon.width = width
			icon.height = height
		}
		
	}
}