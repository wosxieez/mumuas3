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
			
			backgroundAlpha = borderAlpha = 0
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
			
			var oldMyGroupCardUIs:Array = []
			for each(var cardUI: CardUI in myGroupCardUIs) {
				cardUI.visible = false
				oldMyGroupCardUIs.push(cardUI)
			}
			myGroupCardUIs = []
			
			const cardWidth:Number = Size.MIDDLE_CARD_WIDTH / 2
			const cardHeight:Number = Size.MIDDLE_CARD_HEIGHT / 2
			const horizontalGap:Number = 1
			const verticalGap:Number = cardHeight * Size.GAP_RADIO
			var newCardUI:CardUI
			var startX:Number = 0
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
				newCardUI.y = height - newCardUI.height - j * verticalGap
				newCardUI.card = data.cards[j]
				newCardUI.type = CardUI.TYPE_BIG_CARD
				setChildIndex(newCardUI, 0)
				myGroupCardUIs.push(newCardUI)
			}
		}
		
	}
}