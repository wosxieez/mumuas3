package com.xiaomu.view
{
	import com.xiaomu.event.ApiEvent;
	import com.xiaomu.util.Api;
	import com.xiaomu.util.Assets;
	
	import coco.component.Image;
	import coco.core.UIComponent;
	
	public class HomeView extends UIComponent
	{
		public function HomeView()
		{
			super();
			
			Api.getInstane().addEventListener(ApiEvent.Notification, onNotificationHandler)
			Api.getInstane().createRoom('001', {count: 3}, 'wosxieez')
		}
		
		private var bg:Image
		
		override protected function createChildren():void {
			super.createChildren()
			
			bg = new Image()
			bg.source = Assets.getInstane().getAssets('fight_bg.png')
			addChild(bg)
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			bg.width = width
			bg.height = height
		}
		
		override protected function drawSkin():void {
			super.drawSkin()
			
			graphics.clear()
			graphics.beginFill(0xFF0000)
			trace(width, height)
			graphics.drawRect(0, 0, width, height)
			graphics.endFill()
		}
		
		protected function onNotificationHandler(event:ApiEvent):void
		{
			trace(JSON.stringify(event.notification))
		}
		
	}
}