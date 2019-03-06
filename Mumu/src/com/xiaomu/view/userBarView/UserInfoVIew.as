package com.xiaomu.view.userBarView
{
	import coco.core.UIComponent;
	
	public class UserInfoVIew extends UIComponent
	{
		public function UserInfoVIew()
		{
			super();
		}
		
		private var userinfoBar : UserInfoBar
		private var goldBar : GoldOrCardShowBar;
		private var roomCardBar : GoldOrCardShowBar;
		private var _userInfoData:Object;
		private var _inRoomFlag:Boolean=true;

		public function get inRoomFlag():Boolean
		{
			return _inRoomFlag;
		}

		public function set inRoomFlag(value:Boolean):void
		{
			_inRoomFlag = value;
			invalidateDisplayList();
		}


		public function get userInfoData():Object
		{
			return _userInfoData;
		}

		public function set userInfoData(value:Object):void
		{
			_userInfoData = value;
			invalidateProperties();
		}

		
		override protected function createChildren():void
		{
			super.createChildren();
			
			userinfoBar = new UserInfoBar;
			userinfoBar.width = 100;
			userinfoBar.height = 30;
			addChild(userinfoBar);
			
			goldBar = new GoldOrCardShowBar();
			goldBar.width = 65;
			goldBar.height = 20;
			goldBar.iconWidthHeight = [20,20];
			goldBar.typeSource = 'assets/user/gold_coin.png';
			addChild(goldBar);
			goldBar.visible = false;
			
			roomCardBar = new GoldOrCardShowBar();
			roomCardBar.width = 80;
			roomCardBar.height = 20;
			roomCardBar.iconWidthHeight = [32,20];
			roomCardBar.typeSource = 'assets/user/room_card.png';
			addChild(roomCardBar);
			roomCardBar.visible = false;
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			userinfoBar.x = userinfoBar.y = 5;
			goldBar.y = roomCardBar.y = 10;
			if(inRoomFlag){
				/*goldBar.x = userinfoBar.x+userinfoBar.width+20;
				goldBar.y = 10;
				roomCardBar.x = goldBar.x+goldBar.width+20;
				roomCardBar.y = 10;*/
				goldBar.visible = true;
				roomCardBar.visible = false;
				goldBar.x = userinfoBar.x+userinfoBar.width+20
			}else{
				goldBar.visible = false;
				roomCardBar.visible = true;
				roomCardBar.x = userinfoBar.x+userinfoBar.width+20
			}
			
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			goldBar.count = userInfoData?userInfoData.gold:"0"
			roomCardBar.count = userInfoData?userInfoData.roomCard:"0"
			userinfoBar.userName = userInfoData?userInfoData.userName:"test"
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xffffff,0.2);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
	}
}