package com.xiaomu.view.login
{
	import com.xiaomu.component.AppAlert;
	import com.xiaomu.component.AppAlertSmall;
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
			width=500*scale;
			height=360*scale;
		}
		private var scale:Number=1.4;
		private var title : Label ;
		private var labNum : Label;
		private var labPsw : Label;
		private var labNum2 : Label;
		private var phoneNumInput : TextInput;
		private var passwordInput : TextInput;
		private var passwordInput2 : TextInput;
		private var registerBtn : ImageButton;
		private var tipLabel:Label
		public var cancelBtn:ImageButton;
		override protected function createChildren():void
		{
			super.createChildren();
			
			title = new Label();
			title.text = '用户名注册';
			title.color = 0xffffff;
			title.fontSize = 24*scale;
			title.width = width;
			addChild(title);
			
			labNum = new Label();
			labNum.color = 0x55555;
			labNum.text = '账号:';
			labNum.fontSize = 24*scale;
			labNum.width = 100*scale;
			labNum.height = 40*scale;
			addChild(labNum);
			
			labPsw = new Label();
			labPsw.color = 0x55555;
			labPsw.text = '密码:';
			labPsw.fontSize = 24*scale;
			labPsw.width = 100*scale;
			labPsw.height = 40*scale;
			addChild(labPsw);
			
			labNum2 = new Label();
			labNum2.color = 0x55555;
			labNum2.text = '手机号:';
			labNum2.fontSize = 24*scale;
			labNum2.width = 100*scale;
			labNum2.height = 40*scale;
			addChild(labNum2);
			
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
			
			passwordInput2 = new TextInput();
			passwordInput2.maxChars = 12;
			passwordInput2.width = 280*scale;
			passwordInput2.height = 40*scale;
			passwordInput2.radius = 8;
			passwordInput2.fontSize = 24*scale;
			passwordInput2.restrict = '0-9'
			addChild(passwordInput2);
			
			tipLabel = new Label()
			tipLabel.width = 300*scale;
			tipLabel.text = '选填 手机号是为了方便找回密码使用'
			tipLabel.color = 0xFF0000
			addChild(tipLabel)
			
			registerBtn = new ImageButton();
			registerBtn.upImageSource = 'assets/login/queding_up.png';
			registerBtn.downImageSource = 'assets/login/queding_down.png';
			registerBtn.width = 216*scale;
			registerBtn.height = 49*scale;
			registerBtn.addEventListener(MouseEvent.CLICK,registerHandler);
			addChild(registerBtn);
			
			cancelBtn = new ImageButton();
			cancelBtn.upImageSource = 'assets/login/fanhuidenglu_up.png';
			cancelBtn.downImageSource = 'assets/login/fanhuidenglu_down.png';
			cancelBtn.width = 118*scale;
			cancelBtn.height = 38*scale;
			addChild(cancelBtn);
		}
		
		override protected function commitProperties():void 
		{
			super.commitProperties()
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
			
			labNum2.x = 20*scale;
			labNum2.y = 224*scale;
			passwordInput2.x = passwordInput.x;
			passwordInput2.y = labNum2.y-3;
			
			registerBtn.x = (width-registerBtn.width)/2;
			registerBtn.y = passwordInput2.y+passwordInput2.height+45;
			
			tipLabel.x = registerBtn.x
			tipLabel.y = passwordInput2.y + passwordInput2.height + 5
			
			cancelBtn.x = registerBtn.x+registerBtn.width+10;
			cancelBtn.y = registerBtn.y+(registerBtn.height-cancelBtn.height)/2;
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
		
		protected function registerHandler(event:MouseEvent):void
		{
			if(!phoneNumInput.text||!passwordInput.text){
				AppAlertSmall.show("请完善账号和密码")
				return
			}
			var phoneArr:Array = phoneNumInput.text.split('');
			var passwordArr:Array = passwordInput.text.split('');
			if(phoneArr.indexOf(" ")!=-1||passwordArr.indexOf(" ")!=-1){
				AppAlertSmall.show("格式有误，请检查是否有空格存在");
				return
			}
			HttpApi.getInstane().addUser({username: phoneNumInput.text, password: passwordInput.text, mobile: passwordInput2.text},
				function(e:Event):void{
					var response:Object = JSON.parse(e.currentTarget.data)
					if(response.code==0){
						AppAlert.show('注册成功');
						AppData.getInstane().username = phoneNumInput.text;
						AppData.getInstane().password = passwordInput.text;
					} else {
						AppAlert.show(response.data);
					}
				},function (e:Event):void {
					AppAlert.show('注册失败, 网络错误')
				});
		}	
	}
}


