package com.xiaomu.view.home.popUp
{
	import com.xiaomu.view.MainView;
	
	import coco.component.ViewNavigator;
	
	/**
	 * 用户公告栏内部的界面切换
	 */
	public class InnerView extends ViewNavigator
	{
		public function InnerView()
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