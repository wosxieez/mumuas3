package com.xiaomu.view.home.popUP
{
	import coco.component.Image;
	import coco.core.UIComponent;
	
	public class TongzhiSubView extends UIComponent
	{
		public function TongzhiSubView()
		{
			super();
		}
		
		private var contentImg:Image;
		override protected function createChildren():void
		{
			contentImg = new Image();
			contentImg.source = 'assets/home/popUp/notice_bg_dabing.png';
			addChild(contentImg);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			contentImg.width = width;
			contentImg.height = height;
		}
	}
}