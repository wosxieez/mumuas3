package com.xiaomu.view.login
{
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	import com.xiaomu.view.MainView;
	import com.xiaomu.view.hall.HallView;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Alert;
	import coco.component.Button;
	import coco.component.Label;
	import coco.component.TextInput;
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	
	public class LoginPanel extends UIComponent
	{
		public function LoginPanel()
		{
			super();
			width=200;
			height=130;
		}
		
		private var _visible:Boolean;

		override public function get visible():Boolean
		{
			return _visible;
		}

		override public function set visible(value:Boolean):void
		{
			_visible = value;
			invalidateProperties();
		}
		
		private var title : Label ;
		private var labNum : Label;
		private var labPsw : Label;
		private var phoneNumInput : TextInput;
		private var passwordInput : TextInput;
		private var loginBtn : Button;
		public var regsiterBtn:Button;
		override protected function createChildren():void
		{
			super.createChildren();
			
			title = new Label();
			title.text = '手机登录';
			title.color = 0xffffff;
			title.fontSize = 10;
			addChild(title);
			
			labNum = new Label();
			labNum.color = 0x55555;
			labNum.text = '账号:';
			addChild(labNum);
			
			labPsw = new Label();
			labPsw.color = 0x55555;
			labPsw.text = '密码:';
			addChild(labPsw);
			
			phoneNumInput =  new TextInput();
			phoneNumInput.maxChars = 11;
			phoneNumInput.width = 100;
			phoneNumInput.height = 20;
			phoneNumInput.radius = 8;
			addChild(phoneNumInput);
			
			passwordInput = new TextInput();
			passwordInput.maxChars = 12;
			passwordInput.width = 100;
			passwordInput.height = 20;
			passwordInput.radius = 8;
			passwordInput.displayAsPassword = true;
			addChild(passwordInput);
			
			loginBtn = new Button();
			loginBtn.width = 30;
			loginBtn.height = 20;
			loginBtn.label = '登录';
			loginBtn.fontSize = 10;
			loginBtn.addEventListener(MouseEvent.CLICK,loginHandler);
			addChild(loginBtn);
			
			regsiterBtn = new Button();
			regsiterBtn.width = 50;
			regsiterBtn.height = 20;
			regsiterBtn.label = '立即注册';
			regsiterBtn.fontSize = 10;
			addChild(regsiterBtn);
		}
		
		override protected function commitProperties():void 
		{
			super.commitProperties()
			
			const username:String = AppData.getInstane().username
			if (username) {
				phoneNumInput.text = username
			}
			const password:String = AppData.getInstane().password
			if (password) {
				passwordInput.text = password
			}
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			title.x = 75;
			title.y = 3;
			
			labNum.x = 10;
			labNum.y = 40;
			phoneNumInput.x = labNum.x+40;
			phoneNumInput.y = labNum.y-3;
			
			labPsw.x = 10;
			labPsw.y = 76;
			passwordInput.x = labPsw.x+40;
			passwordInput.y = labPsw.y-3;
			
			loginBtn.x = (width-loginBtn.width)/2;
			loginBtn.y = passwordInput.y+passwordInput.height+10;
			
			regsiterBtn.x = loginBtn.x+loginBtn.width+10;
			regsiterBtn.y = passwordInput.y+passwordInput.height+10;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xffffff);
			graphics.drawRoundRect(0,0,width,height,10,10);
			graphics.beginFill(0x33CCFF);
			graphics.drawRoundRectComplex(0,0,width,20,5,5,0,0);
			graphics.endFill();
		}
		
		protected function loginHandler(event:MouseEvent):void
		{
			doLogin();
		}	
		
		public function doLogin():void
		{
			PopUpManager.removePopUp(this);
			HttpApi.getInstane().login(phoneNumInput.text, passwordInput.text, function (ee:Event):void {
				try
				{
					const response:Object = JSON.parse(ee.currentTarget.data)
					if (response.result == 0 && response.message.length > 0) {
						AppData.getInstane().user = response.message[0]
//						trace(JSON.stringify(response.message[0]))
//						trace(phoneNumInput.text,passwordInput.text);
						AppData.getInstane().username = phoneNumInput.text
						AppData.getInstane().password = passwordInput.text
						HallView(MainView.getInstane().pushView(HallView)).init()
					}  else {
						Alert.show('登录失败 用户名密码错误')
					}
				} 
				catch(error:Error) 
				{
				}
			}, function (ee:Event):void {
			})
			
		}
	}
}