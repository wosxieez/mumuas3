package com.xiaomu.view.login
{
	import com.xiaomu.component.AppAlert;
	import com.xiaomu.component.ImageButton;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Label;
	import coco.component.TextInput;
	import coco.core.UIComponent;
	
	public class RegisterPanel extends UIComponent
	{
		public function RegisterPanel()
		{
			super();
			width=500;
			height=260;
		}
		
		private var title : Label ;
		private var labNum : Label;
		private var labPsw : Label;
		private var phoneNumInput : TextInput;
		private var passwordInput : TextInput;
		private var registerBtn : ImageButton;
		public var cancelBtn:ImageButton;
		override protected function createChildren():void
		{
			super.createChildren();
			
			title = new Label();
			title.text = '手机注册';
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
			
			registerBtn = new ImageButton();
			registerBtn.upImageSource = 'assets/login/queding_up.png';
			registerBtn.downImageSource = 'assets/login/queding_down.png';
			registerBtn.width = 216;
			registerBtn.height = 49;
			registerBtn.addEventListener(MouseEvent.CLICK,registerHandler);
			addChild(registerBtn);
			
			cancelBtn = new ImageButton();
			cancelBtn.upImageSource = 'assets/login/fanhuidenglu_up.png';
			cancelBtn.downImageSource = 'assets/login/fanhuidenglu_down.png';
			cancelBtn.width = 118;
			cancelBtn.height = 38;
			addChild(cancelBtn);
		}
		
		override protected function commitProperties():void 
		{
			super.commitProperties()
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
			
			registerBtn.x = (width-registerBtn.width)/2;
			registerBtn.y = passwordInput.y+passwordInput.height+20;
			
			cancelBtn.x = registerBtn.x+registerBtn.width+10;
			cancelBtn.y = registerBtn.y+(registerBtn.height-cancelBtn.height)/2;
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
		
		protected function registerHandler(event:MouseEvent):void
		{
			if(!phoneNumInput.text&&!passwordInput.text){
				return
			}
			HttpApi.getInstane().addUser({username: phoneNumInput.text, password: passwordInput.text},
				function(e:Event):void{
					if(JSON.parse(e.currentTarget.data).code==0){
						AppAlert.show('注册成功');
						AppData.getInstane().username = phoneNumInput.text;
						AppData.getInstane().password = passwordInput.text;
					} else {
						AppAlert.show('注册失败');
					}
				},null);
		}	
	}
}


