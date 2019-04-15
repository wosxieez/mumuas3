package com.xiaomu.component
{
	import coco.component.Label;
	
	public class LabelhasBg extends Label
	{
		public function LabelhasBg()
		{
			super();
		}
		
		private var _bgcolor:uint=0xffffff;

		public function get bgcolor():uint
		{
			return _bgcolor;
		}

		public function set bgcolor(value:uint):void
		{
			_bgcolor = value;
			invalidateProperties();
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(bgcolor);
			graphics.drawRoundRectComplex(0,0,width,height,10,0,10,0);
			graphics.endFill();
		}
	}
}