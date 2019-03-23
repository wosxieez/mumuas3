package com.xiaomu.renderer
{
	import com.xiaomu.view.group.SettingMemberPanel;
	
	import flash.events.MouseEvent;
	
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	import coco.component.TextAlign;
	
	public class UserRenderer extends DefaultItemRenderer
	{
		public function UserRenderer()
		{
			super();
			mouseChildren = true
		}
		private var _data : Object;

		override public function get data():Object
		{
			return _data;
		}

		override public function set data(value:Object):void
		{
			_data = value;
			invalidateProperties()
		}

		private var onlineIcon : Image;
		private var offlineIcon : Image;
		private var settingButton:Image
		private var adminIcon:Image;
		override protected function createChildren():void
		{
			super.createChildren();
			
			onlineIcon = new Image();
			onlineIcon.source = 'assets/room/online.png';
			onlineIcon.width = onlineIcon.height = 40;
			addChild(onlineIcon);
			onlineIcon.visible = false;
			
			offlineIcon = new Image();
			offlineIcon.source = 'assets/room/offline.png';
			offlineIcon.width = offlineIcon.height = 40;
			addChild(offlineIcon);
			offlineIcon.visible = false;
			
			labelDisplay.color = 0xFFFFFF
				
			settingButton = new Image()
			settingButton.source = 'assets/room/user_setting.png';
			settingButton.width = settingButton.height = 32
			settingButton.addEventListener(MouseEvent.CLICK, settingButton_clickHandler)
			addChild(settingButton)
			
			adminIcon = new Image();
			adminIcon.source = 'assets/room/admin.png';
			adminIcon.width = adminIcon.height = 32
			addChild(adminIcon)
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			onlineIcon.x = offlineIcon.x = 5;
			onlineIcon.y = offlineIcon.y = (height-onlineIcon.height)/2;
			
			adminIcon.x = settingButton.x = width - settingButton.width-4;
			adminIcon.y = settingButton.y =(height-settingButton.height)/2;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if (data)
			{
				var group_info_arr : Array = JSON.parse(data.group_info) as Array;
				for each (var i:Object in group_info_arr) 
				{
					if(i.group_id==data.group_id){
						data.subname = i.subname
					}
				}
				labelDisplay.text = data.allowSetFlag?(data.subname?data.subname:data.username):data.username
				labelDisplay.fontSize = 28;
				labelDisplay.height = 30;
				labelDisplay.textAlign = TextAlign.LEFT;
				labelDisplay.x = onlineIcon.x+onlineIcon.width+8;
				labelDisplay.y = (height-labelDisplay.height)/2
				if(data.online){
					onlineIcon.visible = true;
					offlineIcon.visible = false;
				}else{
					onlineIcon.visible = false;
					offlineIcon.visible = true;
				}
				settingButton.visible = data.allowSetFlag
				adminIcon.visible = data.allowSetFlag?false:data.isAdmin;
			}
			else
				labelDisplay.text = "";
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xffffff,0.1);
			graphics.drawRoundRect(0,0,width,height,10,10);
			graphics.endFill();
		}
		
		protected function settingButton_clickHandler(event:MouseEvent):void
		{
			SettingMemberPanel.getInstane().open(data)
		}
		
	}
}