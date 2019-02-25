package com.xiaomu.component
{
	import com.xiaomu.util.Assets;
	
	import coco.component.Image;
	import coco.core.UIComponent;
	
	public class CardUI extends UIComponent
	{
		public function CardUI()
		{
			super();
			
			width = 35
			height = 50
			mouseChildren = false
		}
		
		
		public static const TYPE_FULL_CARD:String = 'full_card'
		public static const TYPE_BIG_CARD:String = 'big_card'
		public static const TYPE_SMALL_CARD:String = 'small_card'
		
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
		
		private var _type:String = TYPE_FULL_CARD
		
		public function get type():String
		{
			return _type;
		}
		
		public function set type(value:String):void
		{
			_type = value;
			invalidateProperties()
		}
		
		private var imageDisplay:Image
		
		
		override protected function createChildren():void {
			super.createChildren()
			
			imageDisplay = new Image()
			addChild(imageDisplay)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			if (card > 0) {
				imageDisplay.source = Assets.getInstane().getAssets('fight_' + type + '_' + card + '.png')
			}
		}
		
		override protected function measure():void {
			measuredWidth = measuredHeight = 50
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			imageDisplay.width = width
			imageDisplay.height = height
		}
		
	}
}