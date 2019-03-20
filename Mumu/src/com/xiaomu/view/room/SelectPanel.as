package com.xiaomu.view.room
{
	import com.xiaomu.event.SelectEvent;
	import com.xiaomu.renderer.SelectRenderer;
	
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
			
			titleHeight = 20
			width = 0
			height = 81
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
			selectList.addEventListener(UIEvent.CHANGE, selectList_changeHandler)
			selectList.itemRendererWidth = 24
			selectList.itemRendererHeight = 51
			selectList.itemRendererRowCount = 1
			selectList.itemRendererClass = SelectRenderer
			selectList.horizontalAlign = HorizontalAlign.CENTER
			selectList.verticalAlign = VerticalAlign.MIDDLE
			addChild(selectList)
		}
		
		protected function selectList_changeHandler(event:UIEvent):void
		{
			var se: SelectEvent = new SelectEvent(SelectEvent.SELECTED)
			se.data = selectList.selectedItem
			dispatchEvent(se)
			
			selectList.selectedIndex = -1
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			selectList.dataProvider = dataProvider
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			selectList.width = contentWidth
			selectList.height = contentHeight
		}
		
		
	}
}