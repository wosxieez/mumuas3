package com.xiaomu.renderer
{
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	
	public class HuXiResultRender extends DefaultItemRenderer
	{
		public function HuXiResultRender()
		{
			super();
			backgroundAlpha = borderAlpha = 0;
		}
		
		private var img:Image;
		override protected function createChildren():void
		{
			super.createChildren();
			
			img = new Image();
			addChild(img);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			img.width = width;
			img.height = height;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			img.source = 'assets/room/hts/'+data+'.png';
		}
	}
}