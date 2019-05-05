package com.xiaomu.component
{
	import com.xiaomu.util.Assets;
	
	import coco.component.Image;
	import coco.core.UIComponent;
	
	public class PdkCardUI extends UIComponent
	{
		public function PdkCardUI()
		{
			super();
			
			width = 35
			height = 50
			mouseChildren = false
		}
		
		private var _card:int = 1
		
		public function get card():int
		{
			return _card;
		}
		
		public function set card(value:int):void
		{
			_card = value;
			invalidateProperties()
		}
		
		private var _selected:Boolean = false
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void
		{
			_selected = value;
			invalidateProperties()
		}
		
		private var _isReverse:Boolean = false
		
		public function get isReverse():Boolean
		{
			return _isReverse;
		}
		
		public function set isReverse(value:Boolean):void
		{
			_isReverse = value;
			invalidateProperties()
		}
		
		private var imageDisplay:Image
		private var mask:UIComponent
		
		
		override protected function createChildren():void {
			super.createChildren()
			
			imageDisplay = new Image()
			addChild(imageDisplay)
			
			mask = new UIComponent()
			mask.visible = false
			addChild(mask)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			if (!isReverse && card > 0) {
				imageDisplay.source = 'assets/pdk/' + card + '.png'
			} else {
				imageDisplay.source = Assets.getInstane().getAssets('fight_small_card.png')
			}
			
			mask.visible = selected
		}
		
		override protected function measure():void {
			measuredWidth = measuredHeight = 50
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			imageDisplay.width = width
			imageDisplay.height = height
			
			mask.width = imageDisplay.width
			mask.height = imageDisplay.height
			mask.x = imageDisplay.x
			mask.y = imageDisplay.y
		}
		
		override protected function drawSkin():void {
			super.drawSkin()
			
			mask.graphics.clear()
			mask.graphics.beginFill(0x000000, 0.4)
			mask.graphics.drawRoundRect(0, 0, mask.width, mask.height, 20)
			mask.graphics.endFill()
		}
		
	}
}