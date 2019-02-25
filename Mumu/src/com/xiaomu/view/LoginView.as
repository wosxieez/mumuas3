package com.xiaomu.view
{
	import com.xiaomu.util.Api;
	
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
			loginButton.label = '创建房间'
			loginButton.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
				Api.getInstane().createRoom('001', {count: 3}, 'wosxieez' + new Date().getMilliseconds())
				MainView.getInstane().pushView(HomeView)
			})
			addChild(loginButton)
			
			var joinButton:Button = new Button()
			joinButton.x = 100
			joinButton.label = '加入房间'
			joinButton.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
				Api.getInstane().joinRoom('001', 'wosxieez' + new Date().getMilliseconds())
				MainView.getInstane().pushView(HomeView)
			})
			addChild(joinButton)
		}
		
	}
}