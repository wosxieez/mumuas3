package com.xiaomu.itemRender
{
	import coco.component.DefaultItemRenderer;
	import coco.component.TextAlign;
	import coco.util.FontFamily;
	
	/**
	 * 圆形渲染
	 */
	public class CircleItemRender extends DefaultItemRenderer
	{
		public function CircleItemRender()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			labelDisplay.textAlign = TextAlign.RIGHT
			labelDisplay.color = 0x0033CC;
			labelDisplay.fontFamily = FontFamily.MICROSOFT_YAHEI
			labelDisplay.bold = true;
			labelDisplay.fontSize = 15;
			labelDisplay.y = 2;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.lineStyle(1,0x888888);
			graphics.beginFill(selected?0xffffff:0xeeeeee);
			graphics.drawCircle(height/2+0.5,height/2+0.5,height/2-1);
			
			graphics.lineStyle(0,0,0);
			graphics.beginFill(0x00CCFF,selected?1:0);
			graphics.drawCircle(height/2+0.5,height/2+0.5,height/4);
			graphics.endFill();
		}
	}
}