package com.xiaomu.component
{
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextAlign;
	import coco.component.TextInput;
	import coco.core.UIComponent;
	
	public class ImgBtn extends UIComponent
	{
		public function ImgBtn()
		{
			super();
		}
		
		private var bgImg:Image;
		private var lab:Label;
		private var _labText:String;

		public function get labText():String
		{
			return _labText;
		}

		public function set labText(value:String):void
		{
			_labText = value;
			invalidateProperties();
		}

		private var _imgSource : String;

		public function get imgSource():String
		{
			return _imgSource;
		}

		public function set imgSource(value:String):void
		{
			_imgSource = value;
			invalidateProperties()
		}
		
		private var _labFontSize:Number = 10;

		public function get labFontSize():Number
		{
			return _labFontSize;
		}

		public function set labFontSize(value:Number):void
		{
			_labFontSize = value;
			invalidateProperties();
		}
		
		private var _labColor:uint=0x000000;

		public function get labColor():uint
		{
			return _labColor;
		}

		public function set labColor(value:uint):void
		{
			_labColor = value;
			invalidateProperties();
		}
		

		
		override protected function createChildren():void
		{
			super.createChildren();
			
			bgImg = new Image();
			addChild(bgImg);
			
			lab = new Label();
			lab.textAlign = TextAlign.CENTER;
			addChild(lab);
			
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			bgImg.source = imgSource;
			bgImg.width = lab.width = width;
			bgImg.height = lab.height = height;
			
			lab.fontSize = labFontSize;
			lab.text = labText;
			lab.color = labColor;
		}

	}
}