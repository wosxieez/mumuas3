package com.xiaomu.view.room
{
	import com.xiaomu.util.Assets;
	
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.SkinComponent;
	
	public class RoomUserHead extends SkinComponent
	{
		public function RoomUserHead()
		{
			super();
			
			width = 80
			height = 160
			radius = 10
			backgroundColor = 0x000000
			backgroundAlpha = 0.5
			borderAlpha = 0
		}
		
		private var headBg:Image
		private var icon:Image
		private var usernameDisplay:Label
		
		private var _username:String
		
		public function get username():String
		{
			return _username;
		}

		public function set username(value:String):void
		{
			_username = value;
			invalidateProperties()
		}

		private var _huxi:String
		
		public function get huxi():String
		{
			return _huxi;
		}

		public function set huxi(value:String):void
		{
			_huxi = value;
		}

		override protected function createChildren():void {
			super.createChildren()
				
			headBg = new Image()
			headBg.width = headBg.height = 80
			headBg.source = 'assets/room/head_80x80.png'
			addChild(headBg)
			
			icon = new Image()
			icon.width = icon.height = 72
			icon.x = icon.y = 4
			icon.source = Assets.getInstane().getAssets('avatar1.png')
			addChild(icon)
			
			usernameDisplay = new Label()
			usernameDisplay.y = 80
			usernameDisplay.color = 0xFFFFFF
			usernameDisplay.fontSize = 15
			usernameDisplay.width = usernameDisplay.height = 80
			addChild(usernameDisplay)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
				
			usernameDisplay.text = username
		}
		
		
	}
}