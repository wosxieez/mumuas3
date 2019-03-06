package com.xiaomu.view.room
{
	import com.xiaomu.renderer.RoomChiTipRenderer;
	
	import coco.component.HorizontalAlign;
	import coco.component.List;
	import coco.component.VerticalAlign;
	
	public class RoomChiTipList extends List
	{
		public function RoomChiTipList()
		{
			super();
			
			width = 100
			height = 71
			gap = 5
			padding = 10
			itemRendererWidth = 24
			itemRendererHeight = 51
			horizontalAlign = HorizontalAlign.CENTER
			verticalAlign = VerticalAlign.MIDDLE
			radius = 5
			backgroundColor = 0x000000
			backgroundAlpha = 0.8
			borderAlpha = 0
			verticalScrollEnabled = horizontalScrollEnabled = false
			itemRendererRowCount = 1
			itemRendererClass = RoomChiTipRenderer
		}
		
		private static var instance:RoomChiTipList
		
		public static function getInstane(): RoomChiTipList {
			if (!instance) {
				instance = new RoomChiTipList()
			}
			
			return instance
		}
		
		
		override public function set dataProvider(value:Array):void {
			super.dataProvider = value
				
			if (dataProvider) {
				width = dataProvider.length * itemRendererWidth + (dataProvider.length - 1) * gap + 2 * padding
			}
		}
		
	}
}