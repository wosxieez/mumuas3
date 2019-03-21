package com.xiaomu.view.login
{
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Alert;
	import coco.component.Button;
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextInput;
	import coco.core.UIComponent;
	
	public class RegisterPanel extends UIComponent
	{
		public function RegisterPanel()
		{
			super();
			width=220;
			height=130;
		}
		
		private var title : Label ;
		private var labNum : Label;
		private var labPsw : Label;
		private var phoneNumInput : TextInput;
		private var passwordInput : TextInput;
		private var registerBtn : Image;
		public var cancelBtn:Image;
		override protected function createChildren():void
		{
			super.createChildren();
			
			title = new Label();
			title.text = '手机注册';
			title.color = 0xffffff;
			title.fontSize = 10;
			title.width = width;
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
			phoneNumInput.width = 120;
			phoneNumInput.height = 20;
			phoneNumInput.radius = 8;
			addChild(phoneNumInput);
			
			passwordInput = new TextInput();
			passwordInput.maxChars = 12;
			passwordInput.width = 120;
			passwordInput.height = 20;
			passwordInput.radius = 8;
			passwordInput.displayAsPassword = true;
			addChild(passwordInput);
			
			registerBtn = new Image();
			registerBtn.source = 'assets/login/queding_up.png';
			registerBtn.width = 216*0.4;
			registerBtn.height = 49*0.4;
			registerBtn.addEventListener(MouseEvent.CLICK,registerHandler);
			addChild(registerBtn);
			
			cancelBtn = new Image();
			cancelBtn.source = 'assets/login/fanhuidenglu_up.png';
			cancelBtn.width = 118*0.4;
			cancelBtn.height = 38*0.4;
			addChild(cancelBtn);
		}
		
		override protected function commitProperties():void 
		{
			super.commitProperties()
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			title.y = 3;
			
			labNum.x = 10;
			labNum.y = 40;
			phoneNumInput.x = labNum.x+40;
			phoneNumInput.y = labNum.y-3;
			
			labPsw.x = 10;
			labPsw.y = 76;
			passwordInput.x = labPsw.x+40;
			passwordInput.y = labPsw.y-3;
			
			registerBtn.x = (width-registerBtn.width)/2;
			registerBtn.y = passwordInput.y+passwordInput.height+10;
			
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
			graphics.drawRoundRectComplex(0,0,width,20,5,5,0,0);
			graphics.endFill();
		}
		
		protected function registerHandler(event:MouseEvent):void
		{
			if(!phoneNumInput.text&&!passwordInput.text){
				return
			}
			HttpApi.getInstane().getUserInfoByName(phoneNumInput.text,function(e:Event):void{
				if((JSON.parse(e.currentTarget.data).message as Array).length==0){
					trace('该账号名可以用');
					HttpApi.getInstane().addUser(phoneNumInput.text,passwordInput.text,function(e:Event):void{
						if(JSON.parse(e.currentTarget.data).result==0){
							Alert.show('注册成功');
							AppData.getInstane().username = phoneNumInput.text;
							AppData.getInstane().password = passwordInput.text;
							trace(AppData.getInstane().username,AppData.getInstane().password);
						}
					},null);
				}else{
					Alert.show('该账号名已经存在');
				}
			},null);
		}	
	}
}


