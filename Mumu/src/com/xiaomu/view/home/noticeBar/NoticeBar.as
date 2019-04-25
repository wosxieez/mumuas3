package com.xiaomu.view.home.noticeBar
{
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import coco.component.Image;
	import coco.component.Label;
	import coco.core.UIComponent;
	
	public class NoticeBar extends UIComponent
	{
		
		public function NoticeBar()
		{
			super();
		}
		
		private var _notice:String
		
		public function get notice():String
		{
			return _notice;
		}
		
		public function set notice(value:String):void
		{
			_notice = value;
			invalidateProperties()
		}
		
		private var laba:Image;
		private var noticeLab:Label;
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			noticeLab = new Label();
			noticeLab.width = 300;
			noticeLab.height = height;
			noticeLab.x = height
			noticeLab.fontSize = 20;
			noticeLab.color = 0xffffff;
			addChild(noticeLab);
			
			laba = new Image();
			laba.source = 'assets/home/noticeBar/laba.png';
			laba.width = laba.height = 32;
			laba.x = laba.y = 4
			addChild(laba);
			
			getNotice()
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			noticeLab.text = notice
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			noticeLab.width = width - noticeLab.x
		}
		
		override protected function drawSkin():void {
			super.drawSkin()
			
			graphics.clear()
			graphics.beginFill(0x000000, .3)
			graphics.drawRoundRect(0, 0, width, height, 10, 10)
			graphics.endFill()
		}
		
		private function getNotice():void {
			HttpApi.getInstane().getNotice(function (e:Event):void {
				try
				{
					var response:Object = JSON.parse(e.currentTarget.data)
					if (response.code == 0) {
						notice = response.data
					}
				} 
				catch(error:Error) 
				{
				}
			})
			
			// 10分钟刷新一次公告
			setTimeout(getNotice, 600000)
		}
		
	}
}