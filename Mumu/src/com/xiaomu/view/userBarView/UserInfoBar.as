package com.xiaomu.view.userBarView
{
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextAlign;
	import coco.core.UIComponent;
	
	public class UserInfoBar extends UIComponent
	{
		public function UserInfoBar()
		{
			super();
			height = 94;
			width = 306;
		}
		private var headBg:Image;
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
			
			userIcon = new Image();
			userIcon.source = 'assets/hall/headIcon.png'
			userIcon.width = userIcon.height = 94*0.8
			userIcon.x = userIcon.y = (94-userIcon.height)/2
			addChild(userIcon);
			
			userNameLab = new Label()
			userNameLab.textAlign = TextAlign.LEFT;
			userNameLab.leading = 5;
			userNameLab.x = headBg.x+headBg.width+5
			userNameLab.height = 94*0.9
			userNameLab.fontSize = 24
			userNameLab.color = 0xFFFFFF
			addChild(userNameLab)
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			userNameLab.text = userName
			userNameLab.y = 12;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
//			graphics.clear();
//			graphics.beginFill(0x000000,0.3);
//			graphics.drawRect(0,0,width,height);
//			graphics.endFill();
		}
	}
}