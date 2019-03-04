package com.xiaomu.view.registered
{
	import com.xiaomu.util.Assets;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Button;
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextAlign;
	import coco.component.TextArea;
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	
	/**
	 *登录注册界面 
	 */
	public class RegisterView extends UIComponent
	{
		public function RegisterView()
		{
			super();
			//			Assets.getInstane().addEventListener(Event.COMPLETE,loadCompleteHandler)
		}
		
		/*protected function loadCompleteHandler(event:Event):void
		{
		bg.source = Assets.getInstane().getAssets('SC_bj.jpg')
		}*/
		
		private var _isloginFlag : Boolean;
		
		private var loginPanel : LoginPanel;
		private var registerPanel : RegisterPanel;
		private var	loginBtn : Button;
		private var bg : Image;
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
			
			bg = new Image()
			bg.source = 'assets/login/login_bg_1.png';
			addChild(bg)
			
			loginBtn = new Button();
			loginBtn.width = 40;
			loginBtn.height = 16;
			loginBtn.label = '登录';
			loginBtn.addEventListener(MouseEvent.CLICK,loginBtnClickHandler);
			addChild(loginBtn);
			
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
			
			bg.width = width;
			bg.height = height;
			
			loginBtn.x = (width-(loginBtn.width))/2;
			loginBtn.y = height-loginBtn.height-30;
			
			bottomLab.x = 10;
			bottomLab.y = height-18;
			bottomLab.width = width-20;
			bottomLab.height = 0;
		}
		
		protected function loginBtnClickHandler(event:MouseEvent):void
		{
			var loginPanel : LoginPanel = new LoginPanel();
			PopUpManager.addPopUp(loginPanel);
			PopUpManager.centerPopUp(loginPanel);
		}
		
	}
}