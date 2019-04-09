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
		
		public  static function show(title:String='',time:Number=1):void{
			var sv:AppSmallAlertView = new AppSmallAlertView();
			sv.text = title;
			sv.time = time;
			PopUpManager.centerPopUp(PopUpManager.addPopUp(sv,null,false,false,0,0));
		}
	}
}