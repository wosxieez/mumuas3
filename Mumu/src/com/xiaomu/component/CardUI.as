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
		
		public var border:Number = 0
		
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
		
		private var _canDeal:Boolean = true 
			
		public function get canDeal():Boolean
		{
			return _canDeal;
		}

		public function set canDeal(value:Boolean):void
		{
			_canDeal = value;
			invalidateProperties()
			invalidateSkin()
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
		
		private var _tingCards:Array

		public function get tingCards():Array
		{
			return _tingCards;
		}

		public function set tingCards(value:Array):void
		{
			_tingCards = value;
			invalidateProperties()
		}

		private var imageDisplay:Image
		private var tingIcon:Image
		private var mask:UIComponent
		
		override protected function createChildren():void {
			super.createChildren()
			
			imageDisplay = new Image()
			addChild(imageDisplay)
			
			tingIcon = new Image()
			tingIcon.source = 'assets/room/ting.png'
			addChild(tingIcon)
			
			mask = new UIComponent()
			mask.visible = false
			addChild(mask)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			if (!isReverse && card > 0) {
				imageDisplay.source = Assets.getInstane().getAssets('fight_' + type + '_' + card + '.png')
			} else {
				imageDisplay.source = Assets.getInstane().getAssets('fight_small_card.png')
			}
			
			mask.visible = !canDeal
			tingIcon.visible = canDeal && tingCards
		}
		
		override protected function measure():void {
			measuredWidth = measuredHeight = 50
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			if (border > 0) {
				imageDisplay.width = width - 2 * border
				imageDisplay.height = height - 2 * border
				imageDisplay.x = imageDisplay.y = border
			} else {
				imageDisplay.width = width
				imageDisplay.height = height
			}
			
			mask.width = imageDisplay.width
			mask.height = imageDisplay.height
			mask.x = imageDisplay.x
			mask.y = imageDisplay.y
		}
		
		override protected function drawSkin():void {
			super.drawSkin()
				
			mask.graphics.clear()
			mask.graphics.beginFill(0x000000, 0.4)
			mask.graphics.drawRoundRect(0, 0, mask.width, mask.height, 2)
			mask.graphics.endFill()
			
			if (border > 0) {
				graphics.clear()
				graphics.beginFill(0xFF0000)
				graphics.drawRoundRect(0, 0, width, height, 4)
				graphics.endFill()
			}
		}
		
	}
}