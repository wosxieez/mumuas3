package com.xiaomu.renderer
{
	import coco.component.DefaultItemRenderer;
	
	public class KeyBoardRender extends DefaultItemRenderer
	{
		public function KeyBoardRender()
		{
			super();
			backgroundAlpha = 0;
			borderAlpha = 0;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			labelDisplay.color = 0x6f1614;
			labelDisplay.fontSize = 30;
			labelDisplay.bold = true;
		}
	}
}