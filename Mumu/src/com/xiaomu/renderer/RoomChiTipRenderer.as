package com.xiaomu.renderer
{
	import com.xiaomu.component.CardUI;
	
	import coco.component.ItemRenderer;
	
	public class RoomChiTipRenderer extends ItemRenderer
	{
		public function RoomChiTipRenderer()
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
			
			const cardWidth:Number = 24
			const cardHeight:Number = 30
			const horizontalGap:Number = 1
			const verticalGap:Number = 21
			var newCardUI:CardUI
			var startX:Number = 0
			for (var j:int = 0; j < data.length; j++) {
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
				newCardUI.card = data[j]
				newCardUI.type = CardUI.TYPE_BIG_CARD
				setChildIndex(newCardUI, 0)
				myGroupCardUIs.push(newCardUI)
			}
		}
		
	}
}