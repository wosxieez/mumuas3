package com.xiaomu.view.login
{
	import com.xiaomu.component.AppAlert;
	import com.xiaomu.component.AppSmallAlert;
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
			height=280*scale;
		}
		private var scale:Number=1.4;
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
			graphics.beginFill(0x3982c7);
			graphics.drawRoundRectComplex(0,0,width,40*scale,5,5,0,0);
			graphics.endFill();
		}
		
		protected function registerHandler(event:MouseEvent):void
		{
			if(!phoneNumInput.text||!passwordInput.text){
				AppSmallAlert.show("请完善账号和密码")
				return
			}
			var phoneArr:Array = phoneNumInput.text.split('');
			var passwordArr:Array = passwordInput.text.split('');
			if(phoneArr.indexOf(" ")!=-1||passwordArr.indexOf(" ")!=-1){
				AppSmallAlert.show("格式有误，请检查是否有空格存在");
				return
			}
			HttpApi.getInstane().addUser({username: phoneNumInput.text, password: passwordInput.text},
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


