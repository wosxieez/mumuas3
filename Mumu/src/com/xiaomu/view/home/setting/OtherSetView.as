package com.xiaomu.view.home.setting
{
	import coco.component.Label;
	import coco.core.UIComponent;
	
	public class OtherSetView extends UIComponent
	{
		public function OtherSetView()
		{
			super();
		}
		
		private var lab:Label;
		override protected function createChildren():void
		{
			super.createChildren();
			
			lab = new Label();
			lab.text = '其他设置界面';
			addChild(lab);
		}
	}
}