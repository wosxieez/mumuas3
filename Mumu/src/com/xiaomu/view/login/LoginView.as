package com.xiaomu.view.login
{
	import com.xiaomu.util.AppData;
	
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import coco.component.Button;
	import coco.component.TextAlign;
	import coco.component.TextArea;
	import coco.core.UIComponent;
	
	/**
	 *登录注册界面 
	 */
	public class LoginView extends UIComponent
	{
		public function LoginView()
		{
			super();
		}
		
		private var _isloginFlag : Boolean;
		
		private var loginPanel : LoginPanel;
		private var registerPanel : RegisterPanel;
		private var	loginBtn : Button;
		private var bottomLab : TextArea;
		private var NoticeInfo : String = '本网络游戏适合年满16岁以上用户，为了您的健康，请合理控制游戏时间';
		public function get isloginFlag():Boolean
		{
			return _isloginFlag;
		}
		
		public function set isloginFlag(value:Boolean):void
		{
			_isloginFlag = value;
			invalidateProperties();
		}
		
		override protected function createChildren():void{
			super.createChildren();
			
			loginPanel = new LoginPanel()
			addChild(loginPanel)
			loginPanel.regsiterBtn.addEventListener(MouseEvent.CLICK,changeToRegsiterHandler);
			
			registerPanel = new RegisterPanel();
			addChild(registerPanel);
			registerPanel.cancelBtn.addEventListener(MouseEvent.CLICK,changeToLoginHandler);
			registerPanel.visible = false
			
			bottomLab = new TextArea();
			bottomLab.textAlign = TextAlign.CENTER;
			bottomLab.text = NoticeInfo;
			bottomLab.color = 0xffffff;
			bottomLab.backgroundAlpha = 0;
			bottomLab.borderAlpha = 0;
			bottomLab.fontSize = 7;
			addChild(bottomLab);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
		}
		
		override protected function updateDisplayList():void{
			super.updateDisplayList();
			
			loginPanel.x = (width - loginPanel.width) / 2
			loginPanel.y = (height - loginPanel.height) / 2
				
			registerPanel.x = loginPanel.x
			registerPanel.y = loginPanel.y;
			
			bottomLab.x = 10;
			bottomLab.y = height-18;
			bottomLab.width = width-20;
			bottomLab.height = 0;
		}
		
		protected function changeToLoginHandler(event:MouseEvent):void
		{
			loginPanel.visible = true;
			registerPanel.visible = false;
		}
		
		protected function changeToRegsiterHandler(event:MouseEvent):void
		{
			loginPanel.visible = false;
			registerPanel.visible = true;
		}
		
		public function init():void{
			setTimeout(function():void{
				if(AppData.getInstane().username&&AppData.getInstane().password){
					if(loginPanel){
						loginPanel.doLogin();
					}else{
						(new LoginPanel).doLogin();
					}
				}
			},10);
		}
		
	}
}