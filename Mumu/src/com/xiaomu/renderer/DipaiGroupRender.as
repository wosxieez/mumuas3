package com.xiaomu.renderer
{
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	
	public class DipaiGroupRender extends DefaultItemRenderer
	{
		public function DipaiGroupRender()
		{
			super();
			autoDrawSkin = false;
		}
		
		private var cardIcon:Image;
		override protected function createChildren():void
		{
			super.createChildren();
			
			cardIcon = new Image();
			addChild(cardIcon);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			cardIcon.width = width;
			cardIcon.height = height;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			cardIcon.source = 'assets/cards/Card_half_'+data+".png"
		}
	}
}