package com.xiaomu.view.home.popUp1
{
	import com.xiaomu.component.AppPanelSmall;
	import com.xiaomu.component.AppSmallAlert;
	
	import flash.events.MouseEvent;
	import flash.system.System;
	
	import coco.component.Image;
	import coco.component.TextArea;
	import coco.util.FontFamily;
	
	/**
	 * 皮皮官方弹出提示界面---按钮为复制的特殊情况
	 */
	public class OfficalNoticeViewOfCopy extends AppPanelSmall
	{
		public function OfficalNoticeViewOfCopy()
		{
			super();
			//			width = 915;
			//			height = 518;
		}
		
		private var _showText:String="测试数据。测试数据。测试数据。测试数据。测试数据。测试数据。测试数据。测试数据。测试数据。测试数据。测试数据。测试数据。vv";
		
		public function get showText():String
		{
			return _showText;
		}
		
		public function set showText(value:String):void
		{
			_showText = value;
			invalidateProperties();
		}
		
		private var _normalStyle:Boolean=true;
		
		public function get normalStyle():Boolean
		{
			return _normalStyle;
		}
		
		public function set normalStyle(value:Boolean):void
		{
			_normalStyle = value;
			invalidateDisplayList();
		}
		
		private var _copyText:String = 'wxniuniu007';
		
		public function get copyText():String
		{
			return _copyText;
		}
		
		public function set copyText(value:String):void
		{
			_copyText = value;
			invalidateDisplayList();
		}
		
		private var titleImg:Image;
		private var lab:TextArea;
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			titleImg = new Image();
			titleImg.source = 'assets/home/popUp/Tishi.png';
			titleImg.width = 293;
			titleImg.height = 86;
			addChild(titleImg);
			
			lab = new TextArea();
			lab.leading = 10;
			lab.editable = false;
			lab.fontSize = 24;
			lab.fontFamily = FontFamily.MICROSOFT_YAHEI;
			lab.backgroundAlpha = 0;
			lab.borderAlpha = 0;
			lab.color = 0x6f1614;
			addChild(lab);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			lab.text = showText+copyText;
			
			titleImg.x = (contentWidth-titleImg.width)/2;
			titleImg.y = -120;
			
			lab.width = contentWidth*0.7;
			lab.height = contentHeight*0.5;
			lab.x = (contentWidth-lab.width)/2;
			lab.y = 0;
		}
		
		override protected function commitButton_clickHandler(event:MouseEvent):void {
			System.setClipboard(copyText);
			AppSmallAlert.show("复制成功",3.5)
			close();
		}
		
	}
}