package com.xiaomu.view.home.popUP
{
	import coco.component.Button;
	import coco.component.Image;
	import coco.component.TextArea;
	import coco.core.UIComponent;
	import coco.util.FontFamily;
	
	public class TongzhiSubView extends UIComponent
	{
		public function TongzhiSubView()
		{
			super();
		}
		
		private var contentImg:Image;
		override protected function createChildren():void
		{
			contentImg = new Image();
			contentImg.source = 'assets/home/popUP/notice_bg_dabing.png';
			addChild(contentImg);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			contentImg.width = width;
			contentImg.height = height;
		}
		
		/*override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xfffff0);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}*/
	}
}