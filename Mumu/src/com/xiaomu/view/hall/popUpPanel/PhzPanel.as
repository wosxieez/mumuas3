package com.xiaomu.view.hall.popUpPanel
{
	import coco.component.Image;
	import coco.component.Label;
	import coco.core.UIComponent;
	
	/**
	 * 跑胡子规则群设置界面
	 */
	public class PhzPanel extends UIComponent
	{
		public function PhzPanel()
		{
			super();
		}
		
		private var lab:Label;
		private var bg:Image;
		override protected function createChildren():void
		{
			super.createChildren();
			
			lab = new Label();
			lab.text = '111';
			addChild(lab);
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xffffff,0.1);
			graphics.drawRect(0,0,width,height*0.8);
			graphics.endFill();
		}
	}
}