package com.xiaomu.view.room
{
	import com.xiaomu.component.AppAlert;
	import com.xiaomu.component.ImageButton;
	import com.xiaomu.event.AppManagerEvent;
	import com.xiaomu.manager.AppManager;
	import com.xiaomu.util.AppData;
	import com.xiaomu.view.home.setting.SettingPanelView;
	
	import flash.events.MouseEvent;
	
	import coco.component.Alert;
	import coco.component.Image;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	import coco.manager.PopUpManager;
	
	public class RoomSettingPanel extends UIComponent
	{
		public function RoomSettingPanel()
		{
			super();
			width = 1280;
			height = 720;
		}
		
		private var bg:Image;
		private var closeBtn:ImageButton;
		private var gameSetBtn:ImageButton;
		private var changeTableBtn:ImageButton;
		private var fixBtn:ImageButton;
		private var leaveRoomBtn:ImageButton;
		private var leaveForceBtn:ImageButton;
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			bg = new Image();
			bg.source = 'assets/room/floor_ct.png';
			bg.addEventListener(MouseEvent.CLICK,bgHandler);
			addChild(bg);
			
			closeBtn = new ImageButton();
			closeBtn.upImageSource='assets/room/btn_zk_normal.png';
			closeBtn.downImageSource='assets/room/btn_zk_press.png';
			closeBtn.width = 69;
			closeBtn.height = 68;
			closeBtn.addEventListener(MouseEvent.CLICK,closeBtnHandler);
			addChild(closeBtn);
			
			gameSetBtn = new ImageButton();
			gameSetBtn.upImageSource = 'assets/room/Z_setup.png';
			gameSetBtn.downImageSource = 'assets/room/Z_setup_p.png';
			gameSetBtn.width = 168;
			gameSetBtn.height = 68;
			gameSetBtn.addEventListener(MouseEvent.CLICK,gameSetBtnHandler);
			addChild(gameSetBtn);
			
			changeTableBtn = new ImageButton();
			changeTableBtn.upImageSource = 'assets/room/btn_ghzb_normal.png';
			changeTableBtn.downImageSource = 'assets/room/btn_ghzb_press.png';
			changeTableBtn.width = 168;
			changeTableBtn.height = 68;
			changeTableBtn.addEventListener(MouseEvent.CLICK,changeTableBtnHandler);
			addChild(changeTableBtn);
			
			fixBtn = new ImageButton();
			fixBtn.upImageSource = 'assets/room/btn_yjxf_normal.png';
			fixBtn.downImageSource = 'assets/room/btn_yjxf_press.png';
			fixBtn.width = 168;
			fixBtn.height = 68;
			fixBtn.addEventListener(MouseEvent.CLICK, fixBtn_clickHandler)
			addChild(fixBtn);
			
			leaveRoomBtn = new ImageButton();
			leaveRoomBtn.upImageSource = 'assets/room/btn_tcfj5_normal.png';
			leaveRoomBtn.downImageSource = 'assets/room/btn_tcfj5_press.png';
			leaveRoomBtn.width = 168;
			leaveRoomBtn.height = 68;
			leaveRoomBtn.addEventListener(MouseEvent.CLICK,leaveRoomBtnHandler);
			addChild(leaveRoomBtn);
			
			leaveForceBtn = new ImageButton();
			leaveForceBtn.upImageSource = 'assets/room/btn_qztc_normal.png';
			leaveForceBtn.downImageSource = 'assets/room/btn_qztc_press.png';
			leaveForceBtn.width = 168;
			leaveForceBtn.height = 68;
			leaveForceBtn.addEventListener(MouseEvent.CLICK,leaveForceBtnHandler);
			addChild(leaveForceBtn);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			bg.width = width;
			bg.height = height;
			
			closeBtn.x = width-closeBtn.width-20;
			closeBtn.y = 10;
			
			gameSetBtn.x = width-gameSetBtn.width-20;
			gameSetBtn.y = closeBtn.y+closeBtn.height+30;
			
			changeTableBtn.x = width-changeTableBtn.width-20;
			changeTableBtn.y = gameSetBtn.y+gameSetBtn.height+30;
			
			leaveForceBtn.x = changeTableBtn.x;
			leaveForceBtn.y = changeTableBtn.y+changeTableBtn.height+30;
			
			fixBtn.x = width-fixBtn.width-20;
			fixBtn.y = leaveForceBtn.y+leaveForceBtn.height+30;
			
			leaveRoomBtn.x = width-leaveRoomBtn.width-20;
			leaveRoomBtn.y = fixBtn.y+fixBtn.height+30;
			
			
		}
		
		protected function closeBtnHandler(event:MouseEvent):void
		{
			PopUpManager.removePopUp(this);
		}
		
		protected function bgHandler(event:MouseEvent):void
		{
			PopUpManager.removePopUp(this);
		}
		
		protected function gameSetBtnHandler(event:MouseEvent):void
		{
			SettingPanelView.getInstane().hideSignOutBtn = true;
			PopUpManager.centerPopUp(PopUpManager.addPopUp(SettingPanelView.getInstane(),null,true,false,0x000000,0.8));
		}
		
		protected function changeTableBtnHandler(event:MouseEvent):void
		{
			///切换桌布。最新数据存储本地下次直接获取
			if(parseInt(AppData.getInstane().roomTableIndex)<AppData.getInstane().roomTableImgsArr.length-1){
				AppData.getInstane().roomTableIndex = (parseInt(AppData.getInstane().roomTableIndex)+1)+""
			}else{
				AppData.getInstane().roomTableIndex ='0'
			}
			AppManager.getInstance().dispatchEvent(new AppManagerEvent(AppManagerEvent.CHANGE_ROOM_TABLE_IMG));
		}
		
		protected function leaveRoomBtnHandler(event:MouseEvent):void
		{
			AppManager.getInstance().dispatchEvent(new AppManagerEvent(AppManagerEvent.LEAVE_GROUP_ROOM));
			PopUpManager.removePopUp(this);
		}
		
		protected function fixBtn_clickHandler(event:MouseEvent):void
		{
			AppManager.getInstance().dispatchEvent(new AppManagerEvent(AppManagerEvent.FIX_ROOM));
			PopUpManager.removePopUp(this);
		}
		
		protected function leaveForceBtnHandler(event:MouseEvent):void
		{
			PopUpManager.removePopUp(this);
			AppAlert.show('是否确定强制退出', '',Alert.OK|Alert.CANCEL, function (e:UIEvent):void {
				if (e.detail == Alert.OK) {
					trace("强制退出");
					closeSelf();
					AppManager.getInstance().dispatchEvent(new AppManagerEvent(AppManagerEvent.FORCE_LEAVE));
				}},null);
		}
		
		private function closeSelf():void
		{
			PopUpManager.removePopUp(this);
		}
	}
}