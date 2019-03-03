package com.xiaomu.view.registered
{
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	import com.xiaomu.view.HallView;
	import com.xiaomu.view.MainView;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Button;
	import coco.component.Label;
	import coco.component.TextInput;
	import coco.core.UIComponent;
	
	public class LoginPanel extends UIComponent
	{
		public function LoginPanel()
		{
			super();
			width=200;
			height=100;
		}
		
		private var labNum : Label;
		private var labPsw : Label;
		private var phoneNumInput : TextInput;
		private var passwordInput : TextInput;
		private var loginBtn : Button;
		override protected function createChildren():void
		{
			super.createChildren();
			
			labNum = new Label();
			labNum.color = 0xffffff;
			labNum.text = '账号:';
			addChild(labNum);
			
			labPsw = new Label();
			labPsw.color = 0xffffff;
			labPsw.text = '密码:';
			addChild(labPsw);
			
			phoneNumInput =  new TextInput();
			phoneNumInput.text = '2'
			phoneNumInput.maxChars = 11;
			phoneNumInput.width = 100;
			phoneNumInput.height = 20;
			phoneNumInput.radius = 8;
			addChild(phoneNumInput);
			
			
			passwordInput = new TextInput();
			passwordInput.text = '2'
			passwordInput.maxChars = 12;
			passwordInput.width = 100;
			passwordInput.height = 20;
			passwordInput.radius = 8;
			passwordInput.displayAsPassword = true;
			addChild(passwordInput);
			
			loginBtn = new Button();
			loginBtn.width = 60;
			loginBtn.height = 20;
			loginBtn.label = '登录';
			loginBtn.addEventListener(MouseEvent.CLICK,loginHandler);
			addChild(loginBtn);
		}
		
		protected function loginHandler(event:MouseEvent):void
		{
			HttpApi.getInstane().login(phoneNumInput.text, passwordInput.text, function (ee:Event):void {
				try
				{
					const response:Object = JSON.parse(ee.currentTarget.data)
					trace(JSON.stringify(response))
					if (response.result == 0 && response.message.length > 0) {
						AppData.getInstane().user = response.message[0]
						HallView(MainView.getInstane().pushView(HallView)).init()
					} 
				} 
				catch(error:Error) 
				{
				}
			}, function (ee:Event):void {
			})
		}		
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			labNum.x = 10;
			labNum.y = 14;
			phoneNumInput.x = labNum.x+40;
			phoneNumInput.y = labNum.y-5;
			
			labPsw.x = 10;
			labPsw.y = 54;
			passwordInput.x = labPsw.x+40;
			passwordInput.y = labPsw.y-5;
			
			loginBtn.x = (width-loginBtn.width)/2;
			loginBtn.y = passwordInput.y+passwordInput.height+10;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			//			graphics.clear();
			//			graphics.beginFill(0xff0000,0.2);
			//			graphics.drawRect(0,0,width,height);
			//			graphics.endFill();
		}
	}
}