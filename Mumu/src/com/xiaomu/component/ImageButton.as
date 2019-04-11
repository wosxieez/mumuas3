package com.xiaomu.component
{
	import com.xiaomu.util.Audio;
	
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
			Audio.getInstane().playButton()
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
		
		private var _upImageSource:Object = null
		
		public function get upImageSource():Object
		{
			return _upImageSource;
		}
		
		public function set upImageSource(value:Object):void
		{
			_upImageSource = value;
			invalidateProperties()
		}
		
		private var _downImageSource:Object = null
		
		public function get downImageSource():Object
		{
			if (!_downImageSource) {
				return _upImageSource
			}
			return _downImageSource;
		}
		
		public function set downImageSource(value:Object):void
		{
			_downImageSource = value;
			invalidateProperties()
		}
		
		public var value:Object;
		
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