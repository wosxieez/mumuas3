package com.xiaomu.itemRender
{
	import com.xiaomu.component.AppSmallAlert;
	import com.xiaomu.component.ImageButton;
	
	import flash.events.MouseEvent;
	
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	
	public class ShopRender extends DefaultItemRenderer
	{
		public function ShopRender()
		{
			super();
			mouseChildren = true
			backgroundAlpha = 0.3
			borderAlpha = 0
			radius = 10
		}
		
		private var bgImg:Image;
		private var button:ImageButton
		
		override protected function createChildren():void {
			super.createChildren()
			
			bgImg = new Image();
			addChild(bgImg);
			
			button = new ImageButton()
			button.width = 106
			button.height = 35
			button.upImageSource = 'assets/home/duihuan_up.png'
			button.downImageSource = 'assets/home/duihuan_down.png'
			button.addEventListener(MouseEvent.CLICK, button_clickHandler)
			addChild(button)
		}
		
		protected function button_clickHandler(event:MouseEvent):void
		{
			event.stopImmediatePropagation()
			event.preventDefault()
				
			AppSmallAlert.show('您的金币不足，无法兑换', AppSmallAlert.WARNING)
		}
		
		override protected function commitProperties():void {
			bgImg.source = data.url
			labelDisplay.text = String(data.name).substr(0, String(data.name).length - 4)
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			bgImg.x = 40
			bgImg.y = 40
			bgImg.width = width - 80
			bgImg.height = height - 80
				
			labelDisplay.height = 40
				
			button.x = (width - button.width) / 2
			button.y = height - 40
		}
		
	}
}