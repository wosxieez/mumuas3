package com.xiaomu.component
{
	import coco.component.Label;
	
	public class Ball extends Label
	{
		public function Ball()
		{
			super();
			
			color = 0xFFFFFF
			this.bold = true
			this.fontSize = 25
			backgroundColor = 0xFF0000
		}
		
		override protected function measure():void {
			measuredWidth = 80
			measuredHeight = 80
		}
		
		override protected function drawSkin():void
		{
			graphics.clear();
			graphics.beginFill(backgroundColor, backgroundAlpha);
			graphics.drawCircle(width / 2, width / 2, width / 2)
			graphics.endFill();
		}
		
	}
}