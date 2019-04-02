package com.xiaomu.view.userBarView
{
	import coco.component.Image;
	import coco.component.Label;
	import coco.core.UIComponent;
	import coco.util.FontFamily;
	
	public class UserInfoBar extends UIComponent
	{
		public function UserInfoBar()
		{
			super();
			height = 94;
			width = 306;
		}
		private var headBg:Image;
		private var contentBg:Image;
		private var userIcon: Image
		private var userNameLab : Label
		private var userGold:Label
		
		private var _userName:String='测试数据';
		
		public function get userName():String
		{
			return _userName;
		}
		
		public function set userName(value:String):void
		{
			_userName = value;
			invalidateProperties();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			headBg = new Image()
			headBg.source = 'assets/user/headback.png'
			headBg.width = headBg.height = 94
			headBg.x = headBg.y = 0
			addChild(headBg)
			
			contentBg = new Image()
			contentBg.source = 'assets/user/HeadBk.png'
			contentBg.height = 78
			contentBg.width = 212
			contentBg.x = headBg.x+headBg.width-5;
			contentBg.y = (headBg.height-contentBg.height)/2;
			addChild(contentBg)
			
			userIcon = new Image();
			userIcon.source = 'assets/hall/headIcon.png'
			userIcon.width = userIcon.height = 94*0.8
			userIcon.x = userIcon.y = (94-userIcon.height)/2
			addChild(userIcon);
			
			userNameLab = new Label()
			userNameLab.x = headBg.x+headBg.width+5
			userNameLab.height = 94*0.9
			userNameLab.fontSize = 24
			userNameLab.fontFamily = FontFamily.MICROSOFT_YAHEI
			userNameLab.color = 0xFFFFFF
			addChild(userNameLab)
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			userNameLab.text = "ID: "+userName
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			/*graphics.clear();
			graphics.beginFill(0xffffff,0.2);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();*/
		}
	}
}