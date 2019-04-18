package com.xiaomu.view.userBarView
{
	import com.xiaomu.event.AppDataEvent;
	import com.xiaomu.util.AppData;
	
	import coco.core.UIComponent;
	
	public class UserInfoView extends UIComponent
	{
		public function UserInfoView()
		{
			super();
			height = 80;
			width = 300
			
			AppData.getInstane().addEventListener(AppDataEvent.USER_DATA_CHAGNED, user_dataChangedHandler)
		}
		
		private var userinfoBar : UserInfoBar
		private var goldBar : GoldOrCardShowBar;
		private var roomCardBar : GoldOrCardShowBar;
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			userinfoBar = new UserInfoBar();
			addChild(userinfoBar);
			
			goldBar = new GoldOrCardShowBar();
			goldBar.width = 240;
			goldBar.height = 50;
			goldBar.iconWidthHeight = [goldBar.height,goldBar.height];
			goldBar.typeSource = 'assets/user/icon_jinbi_01.png';
			addChild(goldBar);
			
			roomCardBar = new GoldOrCardShowBar();
			roomCardBar.width = 240;
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
			goldBar.x = roomCardBar.x+roomCardBar.width+60
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if (AppData.getInstane().user) {
				goldBar.count = AppData.getInstane().user.jb
				roomCardBar.count = AppData.getInstane().user.fc
				userinfoBar.userName = AppData.getInstane().user.username+"\rid:"+AppData.getInstane().user.id
			} else {
				goldBar.count = "0"
				roomCardBar.count = "0"
				userinfoBar.userName = "\rid:"
			}
		}
		
		protected function user_dataChangedHandler(event:AppDataEvent):void
		{
			invalidateProperties()
		}
		
	}
}