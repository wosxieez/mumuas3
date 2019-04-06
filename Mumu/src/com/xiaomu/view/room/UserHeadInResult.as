package com.xiaomu.view.room
{
	import coco.component.Image;
	import coco.component.Label;
	import coco.core.UIComponent;
	
	/**
	 * 一把游戏结束后的用户头像组件
	 */
	public class UserHeadInResult extends UIComponent
	{
		public function UserHeadInResult()
		{
			super();
		}
		
		private var _username:String;
		
		public function get username():String
		{
			return _username;
		}
		
		public function set username(value:String):void
		{
			_username = value;
			invalidateProperties();
		}
		
		private var _isZhuang:Boolean;
		
		public function get isZhuang():Boolean
		{
			return _isZhuang;
		}
		
		public function set isZhuang(value:Boolean):void
		{
			_isZhuang = value;
			invalidateProperties();
		}
		
		private var bgImg:Image;
		private var frameImg:Image;
		private var headImg:Image;
		private var userNameLab:Label;
		private var zhuangIcon:Image;
		override protected function createChildren():void
		{
			super.createChildren();
			
			bgImg = new Image();
			bgImg.source = 'assets/guild/guild2_icon.png';
			addChild(bgImg);
			
			headImg = new Image();
			headImg.source = 'assets/hall/headIcon.png';
			addChild(headImg);
			
			frameImg = new Image();
			frameImg.source = 'assets/guild/guild2_icon_frame.png';
			addChild(frameImg);
			
			zhuangIcon = new Image();
			zhuangIcon.source = 'assets/room/Z_zhuang.png';
			addChild(zhuangIcon);
			
			userNameLab = new Label();
			userNameLab.fontSize = 20;
			userNameLab.color = 0x333333;
			userNameLab.bold = true;
			addChild(userNameLab);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			userNameLab.text = username;
			zhuangIcon.visible = isZhuang;
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			frameImg.x = bgImg.x = 10;
			frameImg.y = bgImg.y = 0;
			frameImg.width = bgImg.width = 100;
			frameImg.height = bgImg.height = 100;
			
			headImg.width = bgImg.width-15;
			headImg.height = bgImg.height-15;
			headImg.x =  bgImg.x +(bgImg.width-headImg.width)/2;
			headImg.y =  bgImg.y +(bgImg.height-headImg.height)/2;
			
			zhuangIcon.width = zhuangIcon.height = 30;
			zhuangIcon.x =  bgImg.x+(bgImg.width-zhuangIcon.width)/2;
			zhuangIcon.y =  bgImg.y +bgImg.height-zhuangIcon.height/2
			
			userNameLab.x = bgImg.x+bgImg.x+bgImg.width+20
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xffffff,0.1);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
	}
}