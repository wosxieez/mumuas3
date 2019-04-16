package com.xiaomu.component
{
	import flash.events.Event;
	import flash.geom.Point;
	
	import coco.component.Label;
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	
	public class Recording extends UIComponent
	{
		public function Recording()
		{
			super();
			
			width = 200;
			height = 200;
			
			addEventListener(Event.ENTER_FRAME, this_enterFrameHandler);
		}
		
		private static var instance:Recording;
		
		public static function getInstance():Recording
		{
			if (!instance)
				instance = new Recording();
			
			return instance;
		}
		
		// public properties
		public var degreeGap:Number = 30;
		public var radiusIn:Number = 25;
		public var radiusOut:Number = 50;
		public var edgeLen:Number = 3;
		
		// private properties
		private var degreeStart:Number = 0;
		private var degreeAlpha:Number;
		private var xIn:Number, yIn:Number, xOut:Number, yOut:Number, xDis:Number, yDis:Number;
		private var p1:Point, p2:Point, p3:Point, p4:Point;
		private var currentFrame:int = 0;
		
		private var progressDisplay:Label;
		private var labelDisplay:Label;
		
		private var _text:String;
		
		private var isOk:Boolean = false
		
		public function get text():String
		{
			return _text;
		}
		
		public function set text(value:String):void
		{
			if (_text == value) return;
			
			_text = value;
			invalidateProperties();
		}
		
		private var _value:Number = -1;
		
		public function get value():Number
		{
			return _value;
		}
		
		public function set value(value:Number):void
		{
			if (_value == value) return;
			
			_value = value;
			invalidateProperties();
		}
		
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			progressDisplay = new Label();
			progressDisplay.color = 0xFFFFFF;
			addChild(progressDisplay);
			
			labelDisplay = new Label();
			labelDisplay.color = 0xFFFFFF;
			labelDisplay.height = 50;
			addChild(labelDisplay);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			labelDisplay.text = text;
			
		    if (value >= 0)
				progressDisplay.text = value + "%";
			else
				progressDisplay.text = "";
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			progressDisplay.width = labelDisplay.width = width;
			progressDisplay.height = height;
			labelDisplay.y = height - labelDisplay.height;
		}
		
		public function open():void
		{
			isOk = true
			PopUpManager.addPopUp(this, null, false, true, 0, 0);
			PopUpManager.centerPopUp(this);
		}
		
		public function close():void
		{
			isOk = false
			text = ''
			PopUpManager.removePopUp(this);
		}
		
		protected function this_enterFrameHandler(event:Event):void
		{
			if (!isOk) return
				
			graphics.clear();
			graphics.beginFill(0x000000, .8);
			graphics.drawRoundRect(0, 0, width, height, 14);
			graphics.endFill();
			
			degreeAlpha = 1;
			
			currentFrame++;
			if (currentFrame == 2)
			{
				currentFrame = 0;
				degreeStart += degreeGap;
				degreeStart = degreeStart % 360;
			}
			
			var degreeNum:int = Math.floor(360 / degreeGap);
			for (var i:int = 0; i < degreeNum; i++)
			{
				drawRect(i);
			}
		}
		
		private function drawRect(index:int):void
		{
			var degree:Number = (degreeStart + 360 - index * degreeGap) % 360;
			xIn = Math.sin(degree * Math.PI / 180) * radiusIn;
			yIn = Math.cos(degree * Math.PI / 180) * radiusIn;
			xOut = Math.sin(degree * Math.PI / 180) * radiusOut;
			yOut = Math.cos(degree * Math.PI / 180) * radiusOut;
			xDis = Math.cos(degree * Math.PI / 180) * edgeLen;
			yDis = Math.sin(degree * Math.PI / 180) * edgeLen;
			p1 = new Point(xIn - xDis, -yIn - yDis);
			p2 = new Point(xIn + xDis, -yIn + yDis);
			p3 = new Point(xOut + xDis, -yOut + yDis);
			p4 = new Point(xOut - xDis, -yOut - yDis);
			
			graphics.beginFill(0xFFFFFF, Math.max(degreeAlpha, .3));
			graphics.moveTo(p1.x + width / 2, p1.y + height / 2);
			graphics.lineTo(p2.x + width / 2, p2.y + height / 2);
			graphics.lineTo(p3.x + width / 2, p3.y + height / 2);
			graphics.lineTo(p4.x + width / 2, p4.y + height / 2);
			graphics.endFill();
			
			degreeAlpha *= .8;
		}
		
	}
}