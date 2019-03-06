package com.xiaomu.view.room
{
	import com.xiaomu.component.CardUI;
	import com.xiaomu.util.CardUtil;
	
	import coco.core.UIComponent;
	
	public class RoomResultItem extends UIComponent
	{
		public function RoomResultItem()
		{
			super();
			
			width = 200
			height = 60
		}
		
		
		private var myGroupCardUIs:Array = []
		
		private var _data:Object
		
		public function get data():Object
		{
			return _data;
		}
		
		public function set data(value:Object):void
		{
			_data = value;
			invalidateProperties()
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
				
			if (!data) return
				
			const groups:Array = data.groupCards
			const riffles:Array = CardUtil.getInstane().riffle(data.handCards)
				
			var resultGroups:Array = []
			for each(var group:Object in groups) {
				resultGroups.push(group.cards)
			}
			for each(var riffle:Array in riffles) {
				resultGroups.push(riffle)
			}
			
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
			for (var i:int = 0; i < resultGroups.length; i++) {
				var groupCards:Array = resultGroups[i]
				var cardsLength:int = groupCards.length
				for (var j:int = 0; j < cardsLength; j++) {
					newCardUI = oldMyGroupCardUIs.pop()
					if (!newCardUI) {
						newCardUI = new CardUI()
						addChild(newCardUI)
					}
					newCardUI.isReverse = false
					newCardUI.visible = true
					newCardUI.width = cardWidth
					newCardUI.height = cardHeight
					newCardUI.x = startX + i * (newCardUI.width + horizontalGap)
					newCardUI.y = height - newCardUI.height - j * verticalGap
					newCardUI.card = groupCards[j]
					newCardUI.type = CardUI.TYPE_SMALL_CARD
					setChildIndex(newCardUI, 0)
					myGroupCardUIs.push(newCardUI)
				}
			}
		}
		
	}
}