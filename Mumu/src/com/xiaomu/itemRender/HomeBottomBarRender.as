package com.xiaomu.itemRender
{
	import flash.events.MouseEvent;
	
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	
	public class HomeBottomBarRender extends DefaultItemRenderer
	{
		public function HomeBottomBarRender()
		{
			super();
			
			width = 63;
			height = 30;
			
			autoDrawSkin = false;
			mouseChildren = true;
			this.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler)
			this.addEventListener(MouseEvent.MOUSE_UP,mouseUpHandler)
			this.addEventListener(MouseEvent.MOUSE_OUT,mouseUpHandler)
		}
		
		protected function mouseDownHandler(event:MouseEvent):void
		{
			mouseDown = true;
		}
		
		protected function mouseUpHandler(event:MouseEvent):void
		{
			mouseDown =  false;
		}
		
		private var _mouseDown:Boolean;

		public function get mouseDown():Boolean
		{
			return _mouseDown;
		}

		public function set mouseDown(value:Boolean):void
		{
			_mouseDown = value;
			invalidateDisplayList();
		}

		
		private var _data:Object;

		override public function get data():Object
		{
			return _data;
		}

		override public function set data(value:Object):void
		{
			_data = value;
			invalidateDisplayList();
		}

		private var coverImage:Image;
		override protected function createChildren():void
		{
			super.createChildren();
			
			coverImage = new Image();
			addChild(coverImage);
			labelDisplay.visible = false;
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			coverImage.width = width*0.8;
			coverImage.height = height*0.8;
			coverImage.x = (width-coverImage.width)/2;
			coverImage.y = (height-coverImage.height)/2;
			
			if(mouseDown){
				coverImage.source = 'assets/home/bottomBar/'+data.image+'_down.png';
			}else{
				coverImage.source = 'assets/home/bottomBar/'+data.image+'_up.png';
			}
			
		}
		
		
	}
}