package com.xiaomu.renderer
{
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	import coco.component.Label;
	
	public class GroupUserMenuRender extends DefaultItemRenderer
	{
		public function GroupUserMenuRender()
		{
			super();
			borderAlpha = 0;
			backgroundAlpha = 0;
		}
		
		private var bgImg:Image;
		private var lab:Label;
		override protected function createChildren():void
		{
			super.createChildren();
			
			bgImg = new Image();
			bgImg.source = 'assets/guild/guild_diban02.png';
			bgImg.radius = 10;
			addChild(bgImg);
			
			lab = new Label();
			lab.bold = true;
			lab.fontSize = 26;
			lab.color = 0x845525;
			addChild(lab);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			lab.text = data+"";
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			bgImg.width = width;
			bgImg.height = height;
			lab.width = width;
			lab.height = height;
			lab.y = (height-lab.height)/2
		}
	}
}