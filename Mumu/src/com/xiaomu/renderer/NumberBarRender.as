package com.xiaomu.renderer
{
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	
	public class NumberBarRender extends DefaultItemRenderer
	{
		public function NumberBarRender()
		{
			super();
		}
		
		private var numberImg:Image;
		override protected function createChildren():void
		{
			super.createChildren();
			
			labelDisplay.visible = false;
			
			numberImg = new Image();
			addChild(numberImg);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			numberImg.width = width;
			numberImg.height = height;
			
			numberImg.y = 5;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if(data){
				numberImg.source = 'assets/number/win_'+data+'.png'
			}
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0x3b3d41);
			graphics.drawRoundRect(0,0,width,height,10,10);
			graphics.endFill();
		}
	}
}