package com.xiaomu.component
{
	import coco.component.Image;
	import coco.component.Panel;
	import coco.manager.PopUpManager;
	
	public class AppPanel extends Panel
	{
		public function AppPanel()
		{
			super();
			
			
			backgroundAlpha = borderAlpha = 0
			titleHeight = 120
		}
		
		override public function set width(value:Number):void {
			// do nothing
		}
		
		override public function set height(value:Number):void {
			// do nothing
		}
		
		protected var background:Image
		
		override protected function createChildren():void {
			super.createChildren()
				
			titleDisplay.fontSize = 30
			titleDisplay.bold = true
			
			background = new Image()
			background.source = 'assets/home/popUp/bac_04.png'
			addRawChildAt(background, 0)
		}
		
		override protected function measure():void {
			measuredWidth = 915
			measuredHeight = 518
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			background.width = width
			background.height = height
				
			titleDisplay.y = 57
			titleDisplay.height = titleHeight - titleDisplay.y
			
			realView.x = 115
			realView.y = titleHeight + 10
			realView.width = 680
			realView.height = 370
		}
		
		public function open():void {
			PopUpManager.centerPopUp(PopUpManager.addPopUp(this, null, true, true, 0x000000,0.5))
		}
		
		public function close():void {
			PopUpManager.removePopUp(this)
		}
		
	}
}