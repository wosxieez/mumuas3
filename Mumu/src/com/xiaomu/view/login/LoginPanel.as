package com.xiaomu.view.login
{
	import com.xiaomu.component.ImageButton;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	import com.xiaomu.view.MainView;
	import com.xiaomu.view.home.HomeView;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Alert;
	import coco.component.Label;
	import coco.component.TextInput;
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	
	public class LoginPanel extends UIComponent
	{
		public function LoginPanel()
		{
			super();
			width=500;
			height=280;
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
		private var loginBtn : ImageButton;
		public var regsiterBtn:ImageButton;
		override protected function createChildren():void
		{
			super.createChildren();
			
			title = new Label();
			title.text = '手机登录';
			title.color = 0xffffff;
			title.fontSize = 24;
			title.width = width;
			addChild(title);
			
			labNum = new Label();
			labNum.color = 0x55555;
			labNum.text = '账号:';
			labNum.fontSize = 24;
			labNum.width = 80;
			labNum.height = 40;
			addChild(labNum);
			
			labPsw = new Label();
			labPsw.color = 0x55555;
			labPsw.text = '密码:';
			labPsw.fontSize = 24;
			labPsw.width = 80;
			labPsw.height = 40;
			addChild(labPsw);
			
			phoneNumInput =  new TextInput();
			phoneNumInput.maxChars = 11;
			phoneNumInput.width = 280;
			phoneNumInput.height = 40;
			phoneNumInput.radius = 8;
			phoneNumInput.fontSize = 24;
			addChild(phoneNumInput);
			
			passwordInput = new TextInput();
			passwordInput.maxChars = 12;
			passwordInput.width = 280;
			passwordInput.height = 40;
			passwordInput.radius = 8;
			passwordInput.fontSize = 24;
			passwordInput.displayAsPassword = true;
			addChild(passwordInput);
			
			loginBtn = new ImageButton();
			loginBtn.width = 216;
			loginBtn.height = 49;
			loginBtn.upImageSource = 'assets/login/phonedenglu_up.png';
			loginBtn.downImageSource = 'assets/login/phonedenglu_down.png';
			loginBtn.addEventListener(MouseEvent.CLICK,loginHandler);
			addChild(loginBtn);
			
			regsiterBtn = new ImageButton();
			regsiterBtn.width = 118;
			regsiterBtn.height = 38;
			regsiterBtn.upImageSource = 'assets/login/kuaisuzhuce_up.png';
			regsiterBtn.downImageSource = 'assets/login/kuaisuzhuce_down.png';
			addChild(regsiterBtn);
		}
		
		override protected function commitProperties():void 
		{
			super.commitProperties()
			
			var username:String = AppData.getInstane().username
			if (username) {
				phoneNumInput.text = username
			}
			var password:String = AppData.getInstane().password
			if (password) {
				passwordInput.text = password
			}
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			title.y = 6;
			
			labNum.x = 20;
			labNum.y = 80;
			phoneNumInput.x = labNum.x+labNum.width+20;
			phoneNumInput.y = labNum.y-3;
			
			labPsw.x = 20;
			labPsw.y = 152;
			passwordInput.x = phoneNumInput.x;
			passwordInput.y = labPsw.y-3;
			
			loginBtn.x = (width-loginBtn.width)/2;
			loginBtn.y = passwordInput.y+passwordInput.height+20;
			
			regsiterBtn.x = loginBtn.x+loginBtn.width+10;
			regsiterBtn.y = loginBtn.y+(loginBtn.height-regsiterBtn.height)/2;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xffffff);
			graphics.drawRoundRect(0,0,width,height,10,10);
			graphics.beginFill(0x33CCFF);
			graphics.drawRoundRectComplex(0,0,width,40,5,5,0,0);
			graphics.endFill();
		}
		
		protected function loginHandler(event:MouseEvent):void
		{
			doLogin();
		}	
		
		public function doLogin():void
		{
			PopUpManager.removePopUp(this);
			HttpApi.getInstane().getUser({username: phoneNumInput.text, password: passwordInput.text}, 
				function (ee:Event):void {
					try
					{
						var response:Object = JSON.parse(ee.currentTarget.data)
						if (response.code == 0 && response.data.length > 0) {
							AppData.getInstane().user = response.data[0]
							AppData.getInstane().username = phoneNumInput.text
							AppData.getInstane().password = passwordInput.text
							HomeView(MainView.getInstane().pushView(HomeView)).init()
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