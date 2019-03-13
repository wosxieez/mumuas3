package com.xiaomu.view.userBarView
{
	import com.xiaomu.util.AppData;
	
	import flash.events.MouseEvent;
	
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	
	public class UserInfoView extends UIComponent
	{
		public function UserInfoView()
		{
			super();
			height = 30;
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
			
			userinfoBar = new UserInfoBar;
			userinfoBar.width = 70;
			userinfoBar.height = 30;
			addChild(userinfoBar);
			
			goldBar = new GoldOrCardShowBar();
			goldBar.width = 65;
			goldBar.height = 20;
			goldBar.iconWidthHeight = [20,20];
			goldBar.typeSource = 'assets/user/gold_coin.png';
			goldBar.addEventListener(MouseEvent.CLICK,addGoldHandler);
			addChild(goldBar);
			
			roomCardBar = new GoldOrCardShowBar();
			roomCardBar.width = 80;
			roomCardBar.height = 20;
			roomCardBar.iconWidthHeight = [32,20];
			roomCardBar.typeSource = 'assets/user/room_card.png';
			addChild(roomCardBar);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			goldBar.visible = roomCardBar.visible = false;
			userinfoBar.x = userinfoBar.y = 5;
			goldBar.y = roomCardBar.y = 10;
			if(AppData.getInstane().inGroupView){
				if(AppData.getInstane().isNowGroupAdmin){
					goldBar.visible = roomCardBar.visible = true;
					//					goldBar.x = userinfoBar.x+userinfoBar.width+20
					//					roomCardBar.x = goldBar.x+goldBar.width+20
					roomCardBar.x = userinfoBar.x+userinfoBar.width+20
					goldBar.x = roomCardBar.x+roomCardBar.width+20
				}else{
					goldBar.visible = true;
					roomCardBar.visible = false;
					goldBar.x = userinfoBar.x+userinfoBar.width+20
				}
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
			
			/*graphics.clear();
			graphics.beginFill(0xff0000,0.1);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();*/
		}
		
		protected function addGoldHandler(event:MouseEvent):void
		{
			if(AppData.getInstane().isNowGroupAdmin){
				var goldSettingPanel:SettingGoldPanel;
				if(!goldSettingPanel){
					goldSettingPanel = new SettingGoldPanel();
				}
				goldSettingPanel.data = userInfoData;
				PopUpManager.centerPopUp(PopUpManager.addPopUp(goldSettingPanel,null,true,true,0xffffff,0.4));
			}
		}
		
		public function reset():void{
			roomCardBar.visible=goldBar.visible=false
		}
	}
}