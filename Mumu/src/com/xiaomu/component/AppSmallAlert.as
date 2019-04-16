package com.xiaomu.component
{
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	
	/**
	 * 自动消失的提示
	 */
	public class AppSmallAlert extends UIComponent
	{
		public function AppSmallAlert()
		{
			super();
		}
		
		public static var NORMAL:String = 'normal';
		public static var SUCCESS:String = 'success';
		public static var WARNING:String = 'warning';
		
		public  static function show(title:String='',type:String='normal',time:Number=1.5):void{
			var sv:AppSmallAlertView = new AppSmallAlertView();
			sv.text = title;
			sv.time = time;
			sv.type = type;
			PopUpManager.centerPopUp(PopUpManager.addPopUp(sv,null,false,false,0,0));
		}
	}
}