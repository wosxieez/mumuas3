package com.xiaomu.view
{
	import flash.events.MouseEvent;
	
	import coco.component.Button;
	import coco.core.UIComponent;
	
	public class LoginView extends UIComponent
	{
		public function LoginView()
		{
			super();
		}
		
		override protected function createChildren():void {
			super.createChildren()
			
			var loginButton:Button = new Button()
			loginButton.label = '登录'
			loginButton.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
				MainView.getInstane().pushView(HomeView)
			})
			addChild(loginButton)
		}
		
	}
}