package com.xiaomu.renderer
{
	import com.xiaomu.component.CardUI;
	import com.xiaomu.util.Size;
	
	import coco.component.ItemRenderer;
	
	public class SelectRenderer extends ItemRenderer
	{
		public function SelectRenderer()
		{
			super();
		}
		
		private var myGroupCardUIs:Array = []
		
		override public function set data(value:Object):void
		{
			super.data = value;
			invalidateProperties()
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			if (!data) return
			data.cards.sort()
			var oldMyGroupCardUIs:Array = []
			for each(var cardUI: CardUI in myGroupCardUIs) {
				cardUI.visible = false
				oldMyGroupCardUIs.push(cardUI)
			}
			myGroupCardUIs = []
			
			var cardWidth:Number = Size.CHI_CARD_WIDTH
			var cardHeight:Number = Size.CHI_CARD_HEIGHT
			var horizontalGap:Number = 1
			var verticalGap:Number = cardHeight * Size.GAP_RADIO
			var newCardUI:CardUI
			var startX:Number = 2
			for (var j:int = 0; j < data.cards.length; j++) {
				newCardUI = oldMyGroupCardUIs.pop()
				if (!newCardUI) {
					newCardUI = new CardUI()
					addChild(newCardUI)
				}
				newCardUI.isReverse = false
				newCardUI.visible = true
				newCardUI.width = cardWidth
				newCardUI.height = cardHeight
				newCardUI.x = startX
				newCardUI.y = height - newCardUI.height - j * verticalGap - 2
				newCardUI.card = data.cards[j]
				newCardUI.type = CardUI.TYPE_BIG_CARD
				setChildIndex(newCardUI, 0)
				myGroupCardUIs.push(newCardUI)
			}
		}
		
		override protected function drawSkin():void {
			graphics.clear()
			graphics.beginFill(0xFF0000, selected ? 1 : 0)
			graphics.drawRect(0, 0, width, height)
			graphics.endFill()
		}
		
	}
}