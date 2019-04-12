package com.xiaomu.view.room
{
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
		private var zhuangImage:Image
		private var niaoImage:Image
		private var usernameDisplay:Label
		private var totalhuxiDisplay:Label
		private var huxiDisplay:Label
		private var focusImage:Image
		
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
		
		private var _thx:int = 0 

		public function get thx():int
		{
			return _thx;
		}

		public function set thx(value:int):void
		{
			_thx = value;
			invalidateProperties()
		}

		private var _huxi:int = 0
		
		public function get huxi():int
		{
			return _huxi;
		}

		public function set huxi(value:int):void
		{
			_huxi = value;
			invalidateProperties()
		}
		
		private var _isZhuang:Boolean = false

		public function get isZhuang():Boolean
		{
			return _isZhuang;
		}

		public function set isZhuang(value:Boolean):void
		{
			_isZhuang = value;
			invalidateProperties()
		}
		
		private var _isNiao:Boolean = false

		public function get isNiao():Boolean
		{
			return _isNiao;
		}

		public function set isNiao(value:Boolean):void
		{
			_isNiao = value;
			invalidateProperties()
		}
		
		private var _isFocus:Boolean = false

		public function get isFocus():Boolean
		{
			return _isFocus;
		}

		public function set isFocus(value:Boolean):void
		{
			_isFocus = value;
			invalidateProperties()
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
			icon.source = 'assets/hall/headIcon.png'
			addChild(icon)
			
			focusImage = new Image()
			focusImage.visible = false
			focusImage.width = focusImage.height = 109
			focusImage.x = focusImage.y = -15
			focusImage.source = 'assets/room/headLight.png'
			addChild(focusImage)
			
			zhuangImage = new Image()
			zhuangImage.width = 38
			zhuangImage.height = 38
			zhuangImage.y = 55
			zhuangImage.x = -19
			zhuangImage.visible = false
			zhuangImage.source = 'assets/room/Z_zhuang.png'
			addChild(zhuangImage)
			
			niaoImage = new Image()
			niaoImage.width = 38
			niaoImage.height = 38
			niaoImage.x = 61
			niaoImage.y = -13
			niaoImage.visible = false
			niaoImage.source = 'assets/room/dn.png'
			addChild(niaoImage)
			
			usernameDisplay = new Label()
			usernameDisplay.y = 85
			usernameDisplay.color = 0xFFFFFF
			usernameDisplay.fontSize = 15
			usernameDisplay.width = 80
			usernameDisplay.height = 25
			addChild(usernameDisplay)
			
			totalhuxiDisplay = new Label()
			totalhuxiDisplay.y = 110
			totalhuxiDisplay.color = 0xFFFF33
			totalhuxiDisplay.fontSize = 20
			totalhuxiDisplay.width = 80
			totalhuxiDisplay.height = 25
			addChild(totalhuxiDisplay)
			
			huxiDisplay = new Label()
			huxiDisplay.y = 135
			huxiDisplay.color = 0xFFFFFF
			huxiDisplay.fontSize = 18
			huxiDisplay.width = 80
			huxiDisplay.height = 25
			addChild(huxiDisplay)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
				
			usernameDisplay.text = username
			totalhuxiDisplay.text = ""+thx
			huxiDisplay.text = '胡息:' + huxi
				
			zhuangImage.visible = isZhuang
			niaoImage.visible = isNiao
				
			focusImage.visible = isFocus
		}
		
	}
}