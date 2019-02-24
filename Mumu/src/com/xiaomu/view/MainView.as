package com.xiaomu.view
{
	import coco.component.ViewNavigator;
	
	public class MainView extends ViewNavigator
	{
		public function MainView()
		{
			super();
		}
		
		private static var instance:MainView
		
		public static function getInstane(): MainView {
			if (!instance) {
				instance = new MainView()
			}
			
			return instance
		}
		
	}
}