package com.xiaomu.view.userBarView
{
	import coco.component.Image;
	import coco.component.Label;
	import coco.core.UIComponent;
	
	public class UserInfoBar extends UIComponent
	{
		public function UserInfoBar()
		{
			super();
		}
		
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
			
			userIcon = new Image
			userIcon.source = 'assets/hall/usericon.png'
			userIcon.width = userIcon.height = 26
			userIcon.x = userIcon.y = 2
			addChild(userIcon)
			
			userNameLab = new Label()
			userNameLab.x = 30
			userNameLab.height = 30
			userNameLab.color = 0xFFFFFF
			addChild(userNameLab)
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			userNameLab.text = userName
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