package com.xiaomu.component
{
	import flash.events.MouseEvent;
	
	import coco.component.Image;
	import coco.component.SkinComponent;
	
	public class ImageButton extends SkinComponent
	{
		public function ImageButton()
		{
			super();
			
			backgroundAlpha = borderAlpha = 0
			mouseChildren = false
			addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
			addEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
			addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler)
		}
		
		protected function mouseUpHandler(event:MouseEvent):void
		{
			mouseDown = false;
		}
		
		protected function mouseDownHandler(event:MouseEvent):void
		{
			mouseDown = true;
		}
		
		protected function mouseOutHandler(event:MouseEvent):void
		{
			mouseDown = false
		}
		
		private var _mouseDown:Boolean;
		
		public function get mouseDown():Boolean
		{
			return _mouseDown;
		}
		
		public function set mouseDown(value:Boolean):void
		{
			_mouseDown = value;
			invalidateSkin()
		}
		
		private var _upImageSource:String = null
		
		public function get upImageSource():String
		{
			return _upImageSource;
		}
		
		public function set upImageSource(value:String):void
		{
			_upImageSource = value;
			invalidateProperties()
		}
		
		private var _downImageSource:String = null
		
		public function get downImageSource():String
		{
			if (!_downImageSource) {
				return _upImageSource
			}
			return _downImageSource;
		}
		
		public function set downImageSource(value:String):void
		{
			_downImageSource = value;
			invalidateProperties()
		}
		
		private var mouseUpImage:Image;
		private var mouseDwonImage:Image
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			mouseUpImage = new Image();
			mouseUpImage.visible = false
			addChild(mouseUpImage);
			
			mouseDwonImage = new Image();
			mouseDwonImage.visible = false
			addChild(mouseDwonImage)
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			mouseUpImage.source = upImageSource
			mouseDwonImage.source = downImageSource
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			mouseUpImage.width = width;
			mouseUpImage.height = height;
			mouseDwonImage.width = width
			mouseDwonImage.height = height
		}
		
		override protected function drawSkin():void {
//			super.drawSkin();
			
			mouseUpImage.visible = !mouseDown
			mouseDwonImage.visible = mouseDown
		}
		
	}
}