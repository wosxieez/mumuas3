package com.xiaomu.view.home.popUp1
{
	import flash.events.MouseEvent;
	import flash.system.System;
	
	import coco.component.Image;
	import coco.component.TextArea;
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	import coco.util.FontFamily;
	
	/**
	 * 皮皮官方弹出提示界面---按钮为复制的特殊情况
	 */
	public class OfficalNoticeViewOfCopy extends UIComponent
	{
		public function OfficalNoticeViewOfCopy()
		{
			super();
			width = 915;
			height = 518;
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
			invalidateProperties();
		}

		private var _copyText:String = 'wxniuniu007';

		public function get copyText():String
		{
			return _copyText;
		}

		public function set copyText(value:String):void
		{
			_copyText = value;
			invalidateProperties();
		}

		private var bgImg:Image;
		private var titleImg:Image;
		private var copyImg:Image;
		private var lab:TextArea;
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			bgImg = new Image();
			bgImg.source = 'assets/home/popUp/bac_04.png';
			bgImg.width = width;
			bgImg.height = height;
			addChild(bgImg);
			
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
			lab.width = width*0.7;
			lab.height = height*0.5;
			lab.backgroundAlpha = 0;
			lab.borderAlpha = 0;
			lab.color = 0x6f1614;
			addChild(lab);
			
			copyImg = new Image();
			copyImg.source = 'assets/home/popUp/copy.png';
			copyImg.width = 88;
			copyImg.height = 41;
			copyImg.addEventListener(MouseEvent.CLICK,copyHandler);
			addChild(copyImg);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			lab.text = showText+copyText;
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			bgImg.x = bgImg.y = 0;
			titleImg.x = (width-titleImg.width)/2;
			titleImg.y = 0;
			
			lab.x = (width-lab.width)/2;
			lab.y = height/3;
			
			copyImg.x = (width-copyImg.width)/2;
			copyImg.y = height-copyImg.height-20
		}
		
		protected function copyHandler(event:MouseEvent):void
		{
			PopUpManager.removePopUp(this);
			System.setClipboard(copyText);
		}
		
	}
}