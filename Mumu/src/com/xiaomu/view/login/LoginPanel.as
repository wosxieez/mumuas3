package com.xiaomu.view.login
{
	import com.xiaomu.component.AppAlert;
	import com.xiaomu.component.ImageButton;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	import com.xiaomu.view.MainView;
	import com.xiaomu.view.home.HomeView;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Label;
	import coco.component.TextInput;
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	
	public class LoginPanel extends UIComponent
	{
		public function LoginPanel()
		{
			super();
			width=500*scale;
			height=280*scale;
		}
		private var scale:Number=1.4;
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
			title.text = '用户名登录';
			title.color = 0xffffff;
			title.fontSize = 24*scale;
			title.width = width;
			addChild(title);
			
			labNum = new Label();
			labNum.color = 0x55555;
			labNum.text = '账号:';
			labNum.fontSize = 24*scale;
			labNum.width = 80*scale;
			labNum.height = 40*scale;
			addChild(labNum);
			
			labPsw = new Label();
			labPsw.color = 0x55555;
			labPsw.text = '密码:';
			labPsw.fontSize = 24*scale;
			labPsw.width = 80*scale;
			labPsw.height = 40*scale;
			addChild(labPsw);
			
			phoneNumInput =  new TextInput();
			phoneNumInput.maxChars = 11;
			phoneNumInput.width = 280*scale;
			phoneNumInput.height = 40*scale;
			phoneNumInput.radius = 8;
			phoneNumInput.fontSize = 24*scale;
			addChild(phoneNumInput);
			
			passwordInput = new TextInput();
			passwordInput.maxChars = 12;
			passwordInput.width = 280*scale;
			passwordInput.height = 40*scale;
			passwordInput.radius = 8;
			passwordInput.fontSize = 24*scale;
			passwordInput.displayAsPassword = true;
			addChild(passwordInput);
			
			loginBtn = new ImageButton();
			loginBtn.width = 216*scale;
			loginBtn.height = 49*scale;
			loginBtn.upImageSource = 'assets/login/phonedenglu_up.png';
			loginBtn.downImageSource = 'assets/login/phonedenglu_down.png';
			loginBtn.addEventListener(MouseEvent.CLICK,loginHandler);
			addChild(loginBtn);
			
			regsiterBtn = new ImageButton();
			regsiterBtn.width = 118*scale;
			regsiterBtn.height = 38*scale;
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
			
			title.y = 6*scale;
			
			labNum.x = 20*scale;
			labNum.y = 80*scale;
			phoneNumInput.x = labNum.x+labNum.width+20;
			phoneNumInput.y = labNum.y-3;
			
			labPsw.x = 20*scale;
			labPsw.y = 152*scale;
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
			graphics.beginFill(0x3982c7);
			graphics.drawRoundRectComplex(0,0,width,40*scale,5,5,0,0);
			graphics.endFill();
		}
		
		protected function loginHandler(event:MouseEvent):void
		{
//			if(!phoneNumInput.text||!passwordInput.text){
//				AppSmallAlert.show("请完善账号和密码");
//				return;
//			}
			doLogin();
		}	
		
		public function doLogin():void
		{
			PopUpManager.removePopUp(this);
			HttpApi.getInstane().login({un: phoneNumInput.text, pwd: passwordInput.text, vn: AppData.getInstane().versionNum}, 
				function (ee:Event):void {
					try
					{
						var response:Object = JSON.parse(ee.currentTarget.data)
						if (response.code == 0 && response.ss && response.us && response.us.length > 0) {
							AppData.getInstane().user = response.us[0]
							if (response.hasOwnProperty('ss')) AppData.getInstane().serverHost = response.ss
							if (response.hasOwnProperty('hs')) AppData.getInstane().webUrl = response.hs
							AppData.getInstane().username = phoneNumInput.text
							AppData.getInstane().password = passwordInput.text
							HomeView(MainView.getInstane().pushView(HomeView)).init()
						}  else {
							AppAlert.show(response.data)
						}
					} 
					catch(error:Error) 
					{
						AppAlert.show('登录失败')
					}
				}, function (ee:Event):void {
					AppAlert.show('登录失败, 网络错误')
				})
			
		}
	}
}