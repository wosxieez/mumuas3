package com.xiaomu.view.room
{
	import com.xiaomu.component.CardUI;
	import com.xiaomu.util.Size;
	
	import coco.component.Image;
	import coco.core.UIComponent;
	
	public class WinCards extends UIComponent
	{
		public function WinCards()
		{
			super();
			
			width = 300
			height = 160
		}
		
		private var myGroupCardUIs:Array = []
		private var myGroupFlags:Array = []
		
		private var _data:Object
		
		public function get data():Object
		{
			return _data;
		}
		
		/**
		 * groupcards 
		 * @param value
		 * 
		 */		
		public function set data(value:Object):void
		{
			_data = value;
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
			
			var oldMyGroupFlags:Array = []
			for each(var flag: Image in myGroupFlags) {
				flag.visible = false
				oldMyGroupFlags.push(flag)
			}
			myGroupFlags = []
			
			var cardWidth:Number = Size.SMALL_CARD_WIDTH
			var cardHeight:Number = Size.SMALL_CARD_HEIGHT
			var horizontalGap:Number = 10
			var verticalGap:Number = Size.SMALL_CARD_HEIGHT * Size.GAP_RADIO
			var newCardUI:CardUI, newFlag:Image
			var startX:Number = 10
			for (var i:int = 0; i < data.length; i++) {
				var group:Object = data[i]
				var cardsLength:int = group.cards.length
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
					newCardUI.y = height - newCardUI.height - j * verticalGap
					newCardUI.card = group.cards[j]
					newCardUI.type = CardUI.TYPE_SMALL_CARD
					setChildIndex(newCardUI, 0)
					myGroupCardUIs.push(newCardUI)
				}
				
				newFlag = oldMyGroupFlags.pop()
				if (!newFlag) {
					newFlag = new Image()
					addChild(newFlag)
				}
				newFlag.visible = true
				newFlag.width = newFlag.height = Size.SMALL_CARD_WIDTH
				newFlag.x = startX + i * (newFlag.width + horizontalGap)
				newFlag.source = 'assets/room/type_' + group.name + '.png'
				myGroupFlags.push(newFlag)
			}
		}
		
	}
}