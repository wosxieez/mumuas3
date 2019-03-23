package com.xiaomu.view.room
{
	import com.xiaomu.event.SelectEvent;
	import com.xiaomu.util.Size;
	
	import coco.component.HGroup;
	import coco.component.HorizontalAlign;
	import coco.manager.PopUpManager;
	
	[Event(name="selected", type="com.xiaomu.event.SelectEvent")]
	
	/**
	 * 吃法选择视图 
	 * @author coco
	 * 
	 */	
	public class ChiSelectView extends HGroup
	{
		public function ChiSelectView()
		{
			super();
			
			height = 800
			width = 400
			padding = 0
			paddingRight = 30
			horizontalAlign = HorizontalAlign.RIGHT
		}
		
		private static var instance:ChiSelectView
		
		public static function getInstane(): ChiSelectView {
			if (!instance) {
				instance = new ChiSelectView()
			}
			
			return instance
		}
		
		private var chiPanel:SelectPanel
		private var biPanel:SelectPanel
		private var bi2Panel:SelectPanel
		private var chiData:Object
		private var biData:Object
		private var bi2Data:Object
		
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
		
		
		override protected function createChildren():void {
			super.createChildren()
			
			bi2Panel = new SelectPanel()
			bi2Panel.title = '比牌'
			bi2Panel.addEventListener(SelectEvent.SELECTED, bi2Panel_selectedHandler)
			addChild(bi2Panel)
			
			biPanel = new SelectPanel()
			biPanel.title = '比牌'
			biPanel.addEventListener(SelectEvent.SELECTED, biPanel_selectedHandler)
			addChild(biPanel)
			
			chiPanel = new SelectPanel()
			chiPanel.title = '吃牌'
			chiPanel.addEventListener(SelectEvent.SELECTED, chiPanel_selectedHandler)
			addChild(chiPanel)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			bi2Panel.visible = biPanel.visible = false
			chiData = biData = bi2Data = null
			chiPanel.dataProvider = dataProvider
			if (dataProvider) {
				chiPanel.width = Math.max(dataProvider.length * (Size.MIDDLE_CARD_WIDTH / 2 + 4) + 20, 54)
			}
		}
		
		public function open(data):void {
			dataProvider = data
			PopUpManager.addPopUp(this)
		}
		
		public function close():void {
			PopUpManager.removePopUp(this)
		}
		
		protected function chiPanel_selectedHandler(event:SelectEvent):void
		{
			biPanel.visible = bi2Panel.visible = false
			bi2Data = bi2Data = null
			if (event.data) {
				chiData = {name: event.data.name, cards: event.data.cards}
				if (event.data.bi) {
					// 有比牌数据
					biPanel.width = Math.max(event.data.bi.length * (Size.MIDDLE_CARD_WIDTH / 2 + 4) + 20, 54)
					biPanel.dataProvider = event.data.bi
					biPanel.visible = true
				} else {
					var ee:SelectEvent = new SelectEvent(SelectEvent.SELECTED)
					ee.data = [chiData]
					dispatchEvent(ee)
				}
			}
		}
		
		protected function biPanel_selectedHandler(event:SelectEvent):void
		{
			bi2Panel.visible = false
			bi2Data = null
			if (event.data) {
				biData = {name: event.data.name, cards: event.data.cards}
				if (event.data.bi) {
					// 有比牌数据
					bi2Panel.width = Math.max(event.data.bi.length * (Size.MIDDLE_CARD_WIDTH / 2 + 4) + 20, 54)
					bi2Panel.dataProvider = event.data.bi
					bi2Panel.visible = true
				} else {
					var ee:SelectEvent = new SelectEvent(SelectEvent.SELECTED)
					ee.data = [chiData, biData]
					dispatchEvent(ee)
				}
			}
		}
		
		protected function bi2Panel_selectedHandler(event:SelectEvent):void
		{
			if (event.data) {
				bi2Data = {name: event.data.name, cards: event.data.cards}
				if (event.data.bi) {
					// 2比了，没有第三比了
				} else {
					var ee:SelectEvent = new SelectEvent(SelectEvent.SELECTED)
					ee.data = [chiData, biData, bi2Data]
					dispatchEvent(ee)
				}
			}
		}
		
	}
}