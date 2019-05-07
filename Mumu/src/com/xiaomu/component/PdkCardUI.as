package com.xiaomu.component
{
	import com.xiaomu.util.Assets;
	
	import coco.component.Image;
	import coco.component.SkinComponent;
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
		
		private var _isOver:Boolean = false
		
		public function get isOver():Boolean
		{
			return _isOver;
		}
		
		public function set isOver(value:Boolean):void
		{
			_isOver = value;
			invalidateProperties()
		}
		
		private var imageDisplay:Image
		private var overLayer:SkinComponent
		
		override protected function createChildren():void {
			super.createChildren()
			
			imageDisplay = new Image()
			addChild(imageDisplay)
			
			overLayer = new SkinComponent()
			overLayer.radius = 10
			overLayer.borderAlpha = 0
			overLayer.backgroundAlpha = 0.3
			overLayer.backgroundColor = 0xFFFF00
			addChild(overLayer)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			if (!isReverse && card > 0) {
				imageDisplay.source = 'assets/pdk/' + card + '.png'
			} else {
				imageDisplay.source = Assets.getInstane().getAssets('fight_small_card.png')
			}
			
			overLayer.y = selected ? - 17 : 3
			imageDisplay.y = selected ? - 20 : 0
			overLayer.visible = isOver
		}
		
		override protected function measure():void {
			measuredWidth = measuredHeight = 50
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			imageDisplay.width = width
			imageDisplay.height = height
			overLayer.x = 3
			overLayer.width = width - 6
			overLayer.height = height - 6
		}
		
	}
}