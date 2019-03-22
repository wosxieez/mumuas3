package com.xiaomu.component
{
	import com.xiaomu.util.Assets;
	import com.xiaomu.util.Size;
	
	import coco.component.Image;
	import coco.core.UIComponent;
	
	public class BigCardUI extends UIComponent
	{
		public function BigCardUI()
		{
			super();
			
			width = Size.BIG_CARD_WIDTH + border * 2
			height = Size.BIG_CARD_HEIGHT + border * 2
			mouseChildren = false
		}
		
		private var border:Number = 20
		
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
		
		private var _isOut:Boolean 
		
		public function get isOut():Boolean
		{
			return _isOut;
		}
		
		public function set isOut(value:Boolean):void
		{
			_isOut = value;
			invalidateSkin()
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
		
		private var background:Image
		private var imageDisplay:Image
		private var mask:UIComponent
		
		override protected function createChildren():void {
			super.createChildren()
			
			background = new Image()
			background.source = "assets/room/light_gold.png"
			addChild(background)
			
			imageDisplay = new Image()
			addChild(imageDisplay)
			
			mask = new UIComponent()
			mask.visible = false
			addChild(mask)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			if (!isReverse && card > 0) {
				imageDisplay.source = Assets.getInstane().getAssets('fight_' + type + '_' + card + '.png')
			} else {
				imageDisplay.source = Assets.getInstane().getAssets('fight_big_card.png')
			}
			
			mask.visible = !canDeal
		}
		
		override protected function measure():void {
			measuredWidth = measuredHeight = 50
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			background.width = width
			background.height = height
			
			if (border > 0) {
				imageDisplay.width = width - 2 * border
				imageDisplay.height = height - 2 * (border + 1)
				imageDisplay.x = border 
				imageDisplay.y = border + 1
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
			
			if (!isOut) { 
				background.visible = true
			} else {
				background.visible = false
			}
		}
		
	}
}