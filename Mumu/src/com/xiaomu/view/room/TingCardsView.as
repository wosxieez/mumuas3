package com.xiaomu.view.room
{
	import com.xiaomu.component.CardUI;
	import com.xiaomu.util.Size;
	
	import coco.component.Image;
	import coco.core.UIComponent;
	
	public class TingCardsView extends UIComponent
	{
		public function TingCardsView()
		{
			super();
			
			width = 200
			height = 96
		}
		
		private var bg:Image
		private var icon:Image
		
		private var _tingCards:Array
		
		public function get tingCards():Array
		{
			return _tingCards;
		}
		
		public function set tingCards(value:Array):void
		{
			_tingCards = value;
			invalidateProperties()
			if (tingCards) {
				width = 96 + (Size.SMALL_CARD_WIDTH + 10) * tingCards.length +  15
			}
		}
		
		private var myPassCardUIs:Array = []
		
		
		override protected function createChildren():void {
			super.createChildren()
			
			bg = new Image()
			bg.source = 'assets/room/phz_ting_bj.png'
			bg.scaleGrid = [20, 20, 20, 20]
			addChild(bg)
			
			icon = new Image()
			icon.width = icon.height = 66
			icon.x = icon.y = 15
			icon.source = 'assets/room/tingpai.png'
			addChild(icon)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			if (!tingCards) {
				visible = false
				return
			} {
				visible = true
			}
			var oldMyPassCardUIs:Array = []
			for each(var cardUI: CardUI in myPassCardUIs) {
				cardUI.visible = false
				oldMyPassCardUIs.push(cardUI)
			}
			myPassCardUIs = []
			var cardWidth:Number = Size.SMALL_CARD_WIDTH
			var cardHeight:Number = Size.SMALL_CARD_HEIGHT
			var horizontalGap:Number = 10
			var newCardUI:CardUI
			var startX:Number = 96
			for (var i:int = 0; i < tingCards.length; i++) {
				newCardUI = oldMyPassCardUIs.pop()
				if (!newCardUI) {
					newCardUI = new CardUI()
					addChild(newCardUI)
				}
				newCardUI.visible = true
				newCardUI.width = cardWidth
				newCardUI.height = cardHeight
				newCardUI.x = startX + i * (newCardUI.width + horizontalGap)
				newCardUI.y = (height - cardHeight) / 2
				newCardUI.card = tingCards[i]
				newCardUI.type = CardUI.TYPE_SMALL_CARD
				myPassCardUIs.push(newCardUI)
			}
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			bg.width = width
			bg.height = height
		}
		
	}
}