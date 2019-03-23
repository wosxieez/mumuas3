package com.xiaomu.component
{
	import com.xiaomu.util.Assets;
	
	import coco.component.Image;
	import coco.core.UIComponent;
	
	public class BigCardUI extends UIComponent
	{
		public function BigCardUI()
		{
			super();
			
			width = 157
			height = 317
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
		
		private var background:Image
		private var imageDisplay:Image
		
		override protected function createChildren():void {
			super.createChildren()
			
			background = new Image()
			background.source = "assets/room/light_gold.png"
			addChild(background)
			
			imageDisplay = new Image()
			addChild(imageDisplay)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			if (card > 0) {
				imageDisplay.source = Assets.getInstane().getAssets('fight_' + type + '_' + card + '.png')
			}
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			background.width = width
			background.height = height
			
			imageDisplay.x = 40
			imageDisplay.y = 40
			imageDisplay.width = width - 2 * imageDisplay.x
			imageDisplay.height = height - 2 * imageDisplay.y
			
		}
		
		override protected function drawSkin():void {
			super.drawSkin()
			if (!isOut) { 
				background.visible = true
			} else {
				background.visible = false
			}
		}
		
	}
}