/**
 * Copyright (c) 2014-present, ErZhuan(coco) Xie
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */
package com.xiaomu.component
{
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	
	import coco.component.Image;
	import coco.component.TextInput;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	
	
	
	[Event(name="ui_change", type="coco.event.UIEvent")]
	
	
	public class CountTool extends UIComponent
	{
		public function CountTool()
		{
			super();
		}
		
		//----------------------------------------------------------------------------------------------------------------
		//
		//  Properties
		//
		//----------------------------------------------------------------------------------------------------------------
		
		//---------------------------------
		// maximum
		//--------------------------------- 
		
		private var maxChanged:Boolean = false;
		private var _maximum:Number = 100;
		
		public function get maximum():Number
		{
			return _maximum;
		}
		
		public function set maximum(value:Number):void
		{
			if (_maximum == value) return;
			_maximum = value;
			maxChanged = true;
			invalidateProperties();
		}
		
		
		//---------------------------------
		// minimum
		//--------------------------------- 
		
		private var _minimum:Number = 0;
		
		public function get minimum():Number
		{
			return _minimum;
		}
		
		public function set minimum(value:Number):void
		{
			if (_minimum == value) return;
			_minimum = value;
			invalidateProperties();
		}
		
		
		//---------------------------------
		// stepSize
		//--------------------------------- 
		
		private var _stepSize:Number = 1;
		
		public function get stepSize():Number
		{
			return _stepSize;
		}
		
		public function set stepSize(value:Number):void
		{
			if (_stepSize == value) return;
			_stepSize = value;
		}
		
		
		//---------------------------------
		// value
		//--------------------------------- 
		
		private var _value:Number = 0;
		
		public function get value():Number
		{
			if (isNaN(_value))
				return minimum;
			
			if (_value < minimum)
				return minimum;
			else if (_value > maximum)
				return maximum;
			else
				return _value;
		}
		
		public function set value(newValue:Number):void
		{
			if (_value == newValue) return;
			_value = newValue;
			invalidateProperties();
		}
		
		//---------------------------------
		// editable
		//--------------------------------- 
		
		private var _editable:Boolean = true;
		
		public function get editable():Boolean
		{
			return _editable;
		}
		
		public function set editable(value:Boolean):void
		{
			if (_editable == value) return;
			_editable = value;
			invalidateProperties();
		}
		
		private var bgImg:Image;
		protected var decrementButton:ImageButton;
		protected var textinput:TextInput;
		protected var incrementButton:ImageButton;
		
		//----------------------------------------------------------------------------------------------------------------
		//
		//  Methods
		//
		//----------------------------------------------------------------------------------------------------------------
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			bgImg = new Image();
			bgImg.source = 'assets/component/floor01.png';
			addChild(bgImg);
			
			textinput = new TextInput();
			textinput.color = 0x6f1614;
			textinput.backgroundAlpha = textinput.borderAlpha = 0;
			textinput.textAlign = "center";
			textinput.restrict = "0-9.";
			textinput.addEventListener(FocusEvent.FOCUS_OUT, this_focusOutHandler);
			textinput.addEventListener(UIEvent.RESIZE, textinput_resizeHandler);
			addChild(textinput);
			
			decrementButton = new ImageButton();
			decrementButton.upImageSource = 'assets/component/btn_jian_normal.png';
			decrementButton.downImageSource = 'assets/component/btn_jian_press.png';
			decrementButton.addEventListener(MouseEvent.CLICK, decrementButton_clickHandler);
			addChild(decrementButton);
			
			incrementButton = new ImageButton();
			incrementButton.upImageSource = 'assets/component/btn_jia_normal.png';
			incrementButton.downImageSource = 'assets/component/btn_jia_press.png';
			incrementButton.addEventListener(MouseEvent.CLICK, incrementButton_clickHandler);
			addChild(incrementButton);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if (minimum > maximum)
			{
				if (maxChanged)
					_maximum = _minimum;
				else
					_minimum = _maximum;
			}
			
			textinput.editable = editable;
			textinput.text = value.toString();
		}
		
		override protected function measure():void
		{
			super.measure();
			
			measuredHeight = 40;
			measuredWidth = 3 * measuredHeight;
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			
			bgImg.width = width;
			bgImg.height = height;
			
			incrementButton.width=decrementButton.width = width/3;
			incrementButton.height=decrementButton.height = height;
			
			incrementButton.x = width-incrementButton.width;
			
			textinput.width = width/3+10;
			textinput.height = height*0.9;
			textinput.x = width/3-5
			textinput.y = (height-textinput.height)/2
		}
		
		protected function textinput_resizeHandler(event:UIEvent):void
		{
			invalidateSize();
			invalidateDisplayList();
		}
		
		protected function incrementButton_clickHandler(event:MouseEvent):void
		{
			value = getNextValue(true);
			dispatchEvent(new UIEvent(UIEvent.CHANGE));
		}
		
		protected function decrementButton_clickHandler(event:MouseEvent):void
		{
			value = getNextValue(false);
			dispatchEvent(new UIEvent(UIEvent.CHANGE));
		}
		
		protected function this_focusOutHandler(event:FocusEvent):void
		{
			value = int(textinput.text);
			dispatchEvent(new UIEvent(UIEvent.CHANGE));
		}
		
		protected function getNextValue(increment:Boolean):Number
		{
			if(isNaN(value))
				return 0;
			
			if (stepSize == 0)
				return value;
			
			var newValue:Number;
			
			// 解决精度问题
			// 如果stepSize为小数，先进行缩放
			// 如stepSize为0.1 则先把value跟stepSize放大10倍再计算,计算完再缩小10倍
			var scale:Number = 1;
			if (stepSize != Math.round(stepSize))
			{
				const parts:Array = stepSize.toString().split("."); 
				scale = Math.pow(10, parts[1].length);
			}
			
			if (increment)
				newValue =  (scale * value + scale * stepSize) / scale;
			else
				newValue = (scale * value - scale * stepSize) / scale;
			
			return newValue;
		}
		
	}
}