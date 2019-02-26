package com.xiaomu.view.user
{
	import coco.component.Label;
	import coco.core.UIComponent;
	
	public class UserInfo extends UIComponent
	{
		public function UserInfo()
		{
			super();
			width = 100;
			height = 30;
		}
		
		private var lab : Label;
		override protected function createChildren():void
		{
			super.createChildren();
			
			lab = new Label();
			lab.text = '左上角用户信息';
			addChild(lab);
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xffffff,1);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
	}
}