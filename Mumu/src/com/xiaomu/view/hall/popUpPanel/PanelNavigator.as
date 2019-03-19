package com.xiaomu.view.hall.popUpPanel
{
	import coco.component.ViewNavigator;
	
	public class PanelNavigator extends ViewNavigator
	{
		public function PanelNavigator()
		{
			super();
		}
		
		private static var instance:PanelNavigator
		
		public static function getInstane(): PanelNavigator {
			if (!instance) {
				instance = new PanelNavigator()
			}
			
			return instance
		}
	}
}