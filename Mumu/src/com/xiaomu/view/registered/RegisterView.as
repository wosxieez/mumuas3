package com.xiaomu.view.registered
{
	import com.xiaomu.util.Assets;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Button;
	import coco.component.Image;
	import coco.core.UIComponent;
	
	/**
	 *登录注册界面 
	 */
	public class RegisterView extends UIComponent
	{
		public function RegisterView()
		{
			super();
			Assets.getInstane().addEventListener(Event.COMPLETE,loadCompleteHandler)
		}
		
		protected function loadCompleteHandler(event:Event):void
		{
			bg.source = Assets.getInstane().getAssets('SC_bj.jpg')
		}
		
		private var _isloginFlag : Boolean;
		
		private var loginPanel : LoginPanel;
		private var registerPanel : RegisterPanel;
		private var exchangeBtn : Button;
		private var bg : Image;

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
			addChild(bg)
			
			loginPanel = new LoginPanel();
			addChild(loginPanel);
			
			registerPanel = new RegisterPanel();
			addChild(registerPanel);
			registerPanel.visible = false;
			
			exchangeBtn = new Button();
			exchangeBtn.width = 100;
			exchangeBtn.height = 20;
			exchangeBtn.addEventListener(MouseEvent.CLICK,clickHandler);
			addChild(exchangeBtn);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if(isloginFlag){
				exchangeBtn.label = '返回登录';
			}else{
				exchangeBtn.label = '没有账号-立即注册';
			}
			loginPanel.visible =!isloginFlag;
			registerPanel.visible = isloginFlag;
		}
		
		protected function clickHandler(event:MouseEvent):void
		{
			isloginFlag = !isloginFlag
		}
		
		override protected function updateDisplayList():void{
			super.updateDisplayList();
			
			bg.width = width;
			bg.height = height;
			
			exchangeBtn.x = (width-exchangeBtn.width)/2
			exchangeBtn.y = height-exchangeBtn.height-20
			
			loginPanel.x = (width-loginPanel.width)/2;
			loginPanel.y = exchangeBtn.y-20-loginPanel.height;
			
			registerPanel.x = (width-registerPanel.width)/2;
			registerPanel.y = exchangeBtn.y-20-registerPanel.height;
			
			
		}
	}
}