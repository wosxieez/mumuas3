package com.xiaomu.view.userBarView
{
	import flash.events.MouseEvent;
	
	import coco.core.UIComponent;
	
	public class UserInfoView extends UIComponent
	{
		public function UserInfoView()
		{
			super();
			height = 80;
			width = 300
		}
		
		private var userinfoBar : UserInfoBar
		private var goldBar : GoldOrCardShowBar;
		private var roomCardBar : GoldOrCardShowBar;
		private var _userInfoData:Object;
		
		public function get userInfoData():Object
		{
			return _userInfoData;
		}
		
		public function set userInfoData(value:Object):void
		{
			_userInfoData = value;
			invalidateProperties();
			invalidateDisplayList();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			userinfoBar = new UserInfoBar();
			addChild(userinfoBar);
			
			goldBar = new GoldOrCardShowBar();
			goldBar.width = 200;
			goldBar.height = 50;
			goldBar.iconWidthHeight = [goldBar.height,goldBar.height];
			goldBar.typeSource = 'assets/user/icon_jinbi_01.png';
			goldBar.addEventListener(MouseEvent.CLICK,addGoldHandler);
			addChild(goldBar);
			
			roomCardBar = new GoldOrCardShowBar();
			roomCardBar.width = 200;
			roomCardBar.height = 50;
			roomCardBar.iconWidthHeight = [roomCardBar.height,roomCardBar.height];
			roomCardBar.typeSource = 'assets/user/icon_yuanbao_01.png';
			addChild(roomCardBar);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			//			goldBar.visible = roomCardBar.visible = false;
			userinfoBar.x = userinfoBar.y = 5;
			goldBar.y = roomCardBar.y = 20;
			goldBar.visible = roomCardBar.visible = true;
			roomCardBar.x = userinfoBar.x+userinfoBar.width+20
			goldBar.x = roomCardBar.x+roomCardBar.width+30
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			goldBar.count = userInfoData?(userInfoData.jb?userInfoData.jb:"0"):"0"
			roomCardBar.count = userInfoData?(userInfoData.fc?userInfoData.fc:"0"):"0"
			userinfoBar.userName = userInfoData?userInfoData.username:"/"
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			/*graphics.clear();
			graphics.beginFill(0xff0000,1);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();*/
		}
		
		protected function addGoldHandler(event:MouseEvent):void
		{
			
		}
		
	}
}