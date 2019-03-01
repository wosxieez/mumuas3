package com.xiaomu.view
{
	import com.xiaomu.component.CardUI;
	
	import coco.component.Panel;
	
	public class WinPanel extends Panel
	{
		public function WinPanel()
		{
			super();
			
			width = 200
			height = 150
		}
		
		
		private static var instance:WinPanel
		
		public static function getInstane(): WinPanel {
			if (!instance) {
				instance = new WinPanel()
			}
			
			return instance
		}
		
		
		private var myGroupCardUIs:Array = []
		
		private var _winGroupCards:Array
		
		public function get winGroupCards():Array
		{
			return _winGroupCards;
		}
		
		public function set winGroupCards(value:Array):void
		{
			_winGroupCards = value;
			invalidateProperties()
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			var oldMyGroupCardUIs:Array = []
			for each(var cardUI: CardUI in myGroupCardUIs) {
				cardUI.visible = false
				oldMyGroupCardUIs.push(cardUI)
			}
			myGroupCardUIs = []
			const cardWidth:Number = 16
			const cardHeight:Number = 20
			const horizontalGap:Number = 1
			const verticalGap:Number = 14
			var newCardUI:CardUI
			var startX:Number = 10
			for (var i:int = 0; i < winGroupCards.length; i++) {
				var group:Object = winGroupCards[i]
				var groupCards:Array = group.cards
				var cardsLength:int = groupCards.length
				for (var j:int = 0; j < cardsLength; j++) {
					newCardUI = oldMyGroupCardUIs.pop()
					if (!newCardUI) {
						newCardUI = new CardUI()
						addChild(newCardUI)
					}
					newCardUI.isReverse = false
					if (group.name == 'ti' || group.name == 'wei') newCardUI.isReverse = true
					if (j == (cardsLength - 1)) newCardUI.isReverse = false
					newCardUI.visible = true
					newCardUI.width = cardWidth
					newCardUI.height = cardHeight
					newCardUI.x = startX + i * (newCardUI.width + horizontalGap)
					newCardUI.y = height - newCardUI.height - j * verticalGap - 45
					newCardUI.card = groupCards[j]
					newCardUI.type = CardUI.TYPE_SMALL_CARD
					setChildIndex(newCardUI, 0)
					myGroupCardUIs.push(newCardUI)
				}
			}
		}
		
	}
}