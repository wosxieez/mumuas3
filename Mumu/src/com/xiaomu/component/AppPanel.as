package com.xiaomu.component
{
	import flash.events.MouseEvent;
	
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
		
		private var _commitEnabled:Boolean = true
		
		public function get commitEnabled():Boolean
		{
			return _commitEnabled;
		}
		
		public function set commitEnabled(value:Boolean):void
		{
			_commitEnabled = value;
			invalidateProperties()
			invalidateDisplayList()
		}
		
		private var _closeEnabled:Boolean = true
		
		public function get closeEnabled():Boolean
		{
			return _closeEnabled;
		}

		public function set closeEnabled(value:Boolean):void
		{
			_closeEnabled = value;
			invalidateProperties()
			invalidateDisplayList()
		}

		private var commitButton:ImageButton
		private var closeButton:ImageButton
		protected var background:Image
		
		override protected function createChildren():void {
			super.createChildren()
			
			titleDisplay.bold = true
			titleDisplay.color = 0x6f1614
			titleDisplay.fontSize = 24
			
			background = new Image()
			background.source = 'assets/home/popUp/bac_04.png'
			addRawChildAt(background, 0)
			
			commitButton = new ImageButton()
			commitButton.width = 166
			commitButton.height = 70
			commitButton.upImageSource = 'assets/component/Z_queding1.png'
			commitButton.downImageSource = 'assets/component/Z_queding1_h.png'
			commitButton.addEventListener(MouseEvent.CLICK, commitButton_clickHandler)
			addRawChild(commitButton)
			
			closeButton = new ImageButton()
			closeButton.width = closeButton.height = 64
			closeButton.upImageSource = 'assets/component/pdk_btn_close.png'
			closeButton.downImageSource = 'assets/component/pdk_btn_close_press.png'
			closeButton.addEventListener(MouseEvent.CLICK, closeButton_clickHandler)
			addRawChild(closeButton)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
				
			closeButton.visible = closeEnabled
			commitButton.visible = commitEnabled
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
			realView.height = commitEnabled ? 270 : 370
				
			commitButton.x = (width - commitButton.width) / 2
			commitButton.y = height - commitButton.height - 15
				
			closeButton.x = width - closeButton.width - 100
			closeButton.y = 57
		}
		
		public function open():void {
			PopUpManager.centerPopUp(PopUpManager.addPopUp(this, null, true, false, 0x000000,0.5))
		}
		
		public function close():void {
			PopUpManager.removePopUp(this)
		}
		
		protected function closeButton_clickHandler(event:MouseEvent):void
		{
			close()
		}
		
		protected function commitButton_clickHandler(event:MouseEvent):void
		{
			close()
		}
		
	}
}