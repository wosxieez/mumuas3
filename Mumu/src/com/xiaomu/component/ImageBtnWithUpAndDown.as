package com.xiaomu.component
{
	import flash.events.MouseEvent;
	
	import coco.component.Image;
	import coco.core.UIComponent;
	
	public class ImageBtnWithUpAndDown extends UIComponent
	{
		public function ImageBtnWithUpAndDown()
		{
			super();
			addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
			addEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
		}
		
		protected function mouseUpHandler(event:MouseEvent):void
		{
			mouseDown = false;
		}
		
		protected function mouseDownHandler(event:MouseEvent):void
		{
			mouseDown = true;
		}
		
		private var _mouseDown:Boolean;

		public function get mouseDown():Boolean
		{
			return _mouseDown;
		}

		public function set mouseDown(value:Boolean):void
		{
			_mouseDown = value;
			invalidateProperties();
		}

		
		private var _upImageSource:String;

		public function get upImageSource():String
		{
			return _upImageSource;
		}

		public function set upImageSource(value:String):void
		{
			_upImageSource = value;
		}
		
		private var _downImageSource:String;

		public function get downImageSource():String
		{
			return _downImageSource;
		}

		public function set downImageSource(value:String):void
		{
			_downImageSource = value;
		}

		private var mouseUpImage:Image;
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			mouseUpImage = new Image();
			mouseUpImage.width = width;
			mouseUpImage.height = height;
			
			addChild(mouseUpImage);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if(mouseDown){
				mouseUpImage.source = downImageSource;
			}else{
				mouseUpImage.source = upImageSource;
			}
		}

	}
}