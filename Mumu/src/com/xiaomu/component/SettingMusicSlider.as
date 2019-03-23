/**
 * Copyright (c) 2014-present, ErZhuan(coco) Xie
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */
package com.xiaomu.component
{
	import flash.events.MouseEvent;
	
	import coco.component.Image;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	
	[Event(name="ui_change", type="coco.event.UIEvent")]
	
	/**
	 * ---|----------
	 * 
	 * 滑块组件
	 */	
	public class SettingMusicSlider extends UIComponent
	{
		public function SettingMusicSlider()
		{
			super();
		}
		
		//---------------------------------------------------------------------------------------------------------------------
		//
		// Vars
		//
		//---------------------------------------------------------------------------------------------------------------------
		
		protected var thumbImage:Image;
		private var coverImage:Image;
		private var sliderBarImage:Image;
		private var thumbMaxX:Number = 0;
		
		private var oldMouseX:Number;
		private var oldThumbX:Number = 0;
		private var valuePerX:Number = 0;
		
		private var _minValue:Number = 0;
		
		public function get minValue():Number
		{
			return _minValue;
		}
		
		public function set minValue(value:Number):void
		{
			_minValue = value;
			
			invalidateDisplayList();
		}
		
		private var _maxValue:Number = 0;
		
		public function get maxValue():Number
		{
			return _maxValue;
		}
		
		public function set maxValue(value:Number):void
		{
			_maxValue = value;
			
			invalidateDisplayList();
		}
		
		private var _value:Number = 0;
		
		public function get value():Number
		{
			if (_value < minValue)
				return minValue;
			else if (_value > maxValue)
				return maxValue;
			else
				return _value;
		}
		
		public function set value(value:Number):void
		{
			_value = value;
			
			invalidateDisplayList();
		}
		
		private var _sliderBarImageSource:String;
		
		public function get sliderBarImageSource():String
		{
			return _sliderBarImageSource;
		}
		
		public function set sliderBarImageSource(value:String):void
		{
			_sliderBarImageSource = value;
			invalidateProperties();
		}
		
		private var _sliderCoverImageSource:String;
		
		public function get sliderCoverImageSource():String
		{
			return _sliderCoverImageSource;
		}
		
		public function set sliderCoverImageSource(value:String):void
		{
			_sliderCoverImageSource = value;
			invalidateProperties();
		}
		
		private var _sliderBtnSource:String;
		
		public function get sliderBtnSource():String
		{
			return _sliderBtnSource;
		}
		
		public function set sliderBtnSource(value:String):void
		{
			_sliderBtnSource = value;
			invalidateProperties();
		}
		
		//---------------------------------------------------------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------------------------------------------------------
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			sliderBarImage = new Image();
			sliderBarImage.height = height;
			sliderBarImage.width = width;
			addChild(sliderBarImage);
			
			coverImage = new Image();
			coverImage.height = height;
			coverImage.width = width;
			addChild(coverImage);
			
			thumbImage = new Image();
			thumbImage.width = 58
			thumbImage.height = 60;
			thumbImage.addEventListener(MouseEvent.MOUSE_DOWN, thumbImage_mouseDownHandler);
			addChild(thumbImage);
		}
		
		override protected function measure():void
		{
			measuredWidth = 100;
			measuredHeight = 40;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			sliderBarImage.source = sliderBarImageSource;
			coverImage.source = sliderCoverImageSource;
			thumbImage.source = sliderBtnSource;
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			sliderBarImage.x = thumbImage.width/2;
			sliderBarImage.width = width-thumbImage.width;
			coverImage.x = thumbImage.width/2;
			thumbMaxX = width - thumbImage.width;
			valuePerX = (maxValue - minValue) / thumbMaxX;
			thumbImage.x = (value - minValue) / valuePerX;
			thumbImage.y = (height-thumbImage.height)/2;
			
			coverImage.width = (width-thumbImage.width)*value/100;
		}
		
		protected function thumbImage_mouseDownHandler(event:MouseEvent):void
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, this_mouseMoveHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, this_mouseUpHandler);
			oldMouseX = mouseX;
			oldThumbX = thumbImage.x;
		}
		
		protected function this_mouseUpHandler(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, this_mouseMoveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, this_mouseUpHandler);
		}
		
		protected function this_mouseMoveHandler(event:MouseEvent):void
		{
			var newThumbX:Number = oldThumbX + mouseX - oldMouseX;
			if (newThumbX < 0)
				newThumbX = 0;
			else if (newThumbX > thumbMaxX)
				newThumbX = thumbMaxX;
			thumbImage.x = newThumbX;
			_value = newThumbX * valuePerX + minValue;
			dispatchEvent(new UIEvent(UIEvent.CHANGE));
			invalidateDisplayList();
		}
		
	}
}