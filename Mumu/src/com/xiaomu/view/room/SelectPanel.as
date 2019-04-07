package com.xiaomu.view.room
{
	import com.xiaomu.event.SelectEvent;
	import com.xiaomu.renderer.SelectRenderer;
	import com.xiaomu.util.Size;
	
	import coco.component.HorizontalAlign;
	import coco.component.List;
	import coco.component.Panel;
	import coco.component.VerticalAlign;
	import coco.event.UIEvent;
	
	[Event(name="selected", type="com.xiaomu.event.SelectEvent")]
	
	public class SelectPanel extends Panel
	{
		public function SelectPanel()
		{
			super();
			borderColor = 0x000000
			backgroundColor = 0x000000
			backgroundAlpha = 0.6
			titleHeight = 30
			width = 0
			height = Size.CHI_CARD_HEIGHT * 3  - Size.CHI_CARD_HEIGHT * 2 * (1 - Size.GAP_RADIO) + titleHeight + 20 + 4
		}
		
		private var _dataProvider:Array
		
		public function get dataProvider():Array
		{
			return _dataProvider;
		}
		
		public function set dataProvider(value:Array):void
		{
			_dataProvider = value;
			invalidateProperties()
		}
		
		private var selectList: List
		
		override protected function createChildren():void {
			super.createChildren()
			
			selectList = new List()
			selectList.verticalScrollEnabled = selectList.horizontalScrollEnabled = false
			selectList.addEventListener(UIEvent.CHANGE, selectList_changeHandler)
			selectList.itemRendererWidth = Size.CHI_CARD_WIDTH + 4
			selectList.itemRendererHeight = Size.CHI_CARD_HEIGHT * 3  - Size.CHI_CARD_HEIGHT * 2 * (1 - Size.GAP_RADIO) + 4
			selectList.itemRendererRowCount = 1
			selectList.itemRendererClass = SelectRenderer
			selectList.horizontalAlign = HorizontalAlign.CENTER
			selectList.verticalAlign = VerticalAlign.MIDDLE
			addChild(selectList)
		}
		
		private var oldIndex:int = -1
		
		protected function selectList_changeHandler(event:UIEvent):void
		{
			if (selectList.selectedIndex >= 0) {
				oldIndex = selectList.selectedIndex
				var se: SelectEvent = new SelectEvent(SelectEvent.SELECTED)
				se.data = selectList.selectedItem
				dispatchEvent(se)
			} else {
				selectList.selectedIndex = oldIndex
			}
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			titleDisplay.color = 0xFFFFFF
			selectList.dataProvider = dataProvider
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			selectList.width = contentWidth
			selectList.height = contentHeight
		}
		
		
	}
}