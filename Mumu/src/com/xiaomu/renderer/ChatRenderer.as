package com.xiaomu.renderer
{
	import coco.component.DefaultItemRenderer;
	
	public class ChatRenderer extends DefaultItemRenderer
	{
		public function ChatRenderer()
		{
			super();
			backgroundAlpha = borderAlpha = 0
		}
		
		override protected function createChildren():void {
			super.createChildren()
				
			labelDisplay.color = 0xFFFFFF
		}
		
	}
}