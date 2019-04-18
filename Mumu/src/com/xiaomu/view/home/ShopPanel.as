package com.xiaomu.view.home
{
	import com.xiaomu.component.AppPanelBig;
	import com.xiaomu.itemRender.ShopRender;
	
	import flash.filesystem.File;
	
	import coco.component.List;
	
	public class ShopPanel extends AppPanelBig
	{
		public function ShopPanel()
		{
			super();
		}
		
		
		private static var instance:ShopPanel
		
		public static function getInstane(): ShopPanel {
			if (!instance) {
				instance = new ShopPanel()
			}
			
			return instance
		}
		
		private var list:List
		
		override protected function createChildren():void {
			super.createChildren()
			
			list = new List()
			list.itemRendererColumnCount = 4
			list.gap = list.padding = 10
			list.itemRendererHeight = 200
			list.itemRendererClass = ShopRender
			addChild(list)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
				
			var file:File = File.applicationDirectory.resolvePath('assets/home/shop')
			if (file.exists && file.isDirectory) {
				list.dataProvider = file.getDirectoryListing()
			}
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			list.width = contentWidth
			list.height = contentHeight
		}
		
	}
}