package com.xiaomu.view.home.noticeBar
{
	import coco.component.Image;
	import coco.component.Label;
	import coco.core.UIComponent;
	
	public class NoticeBar extends UIComponent
	{
		
		public function NoticeBar()
		{
			super();
		}
		
		private var laba:Image;
		private var bgImg:Image;
		private var noticeLab:Label;
		override protected function createChildren():void
		{
			super.createChildren();
			
			bgImg = new Image();
			bgImg.source = 'assets/home/noticeBar/bgBar.png';
			bgImg.width = width;
			bgImg.height = height;
			bgImg.alpha = 0.3;
			addChild(bgImg);
			
			noticeLab = new Label();
			noticeLab.text = "测试测试测试测试测试测试测试测试测试测试测试测试测试测试。"
			noticeLab.width = 300;
			noticeLab.height = height;
			noticeLab.fontSize = 20;
			noticeLab.color = 0xffffff;
			addChild(noticeLab);
			
			laba = new Image();
			laba.source = 'assets/home/noticeBar/laba.png';
			laba.width = height;
			laba.height = height;
			addChild(laba);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			laba.x = 0;
			laba.y = 0;
			
			bgImg.x = 0;
			bgImg.y = 0;
		}
		
	}
}