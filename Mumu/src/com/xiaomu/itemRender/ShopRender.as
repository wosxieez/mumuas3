package com.xiaomu.itemRender
{
	import coco.component.Image;
	import coco.component.ItemRenderer;
	
	public class ShopRender extends ItemRenderer
	{
		public function ShopRender()
		{
			super();
			mouseChildren = true
			borderAlpha = 0
			backgroundAlpha = 0;
		}
		
		private var bgImg:Image;
		
		override protected function createChildren():void {
			super.createChildren()
			
			bgImg = new Image();
			addChild(bgImg);
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			bgImg.source = data.url
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			bgImg.x = bgImg.y = 40
			bgImg.width = width - 80
			bgImg.height = height - 80
		}
		
	}
}