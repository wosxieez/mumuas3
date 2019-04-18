package com.xiaomu.renderer
{
	import flash.events.MouseEvent;
	
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	import coco.component.Label;
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
		
		private var bgImg:Image;
		private var onlineIcon : Image;
		private var offlineIcon : Image;
		private var settingButton:Image
		private var adminIcon:Image;
		private var nameLab:Label;
		override protected function createChildren():void
		{
			super.createChildren();
			
			labelDisplay.visible = false;
			
			bgImg = new Image();
			bgImg.source = 'assets/user/club_black_mem_bg.png';
			addChild(bgImg);
			
			onlineIcon = new Image();
			onlineIcon.source = 'assets/room/online.png';
			addChild(onlineIcon);
			onlineIcon.visible = false;
			
			offlineIcon = new Image();
			offlineIcon.source = 'assets/room/offline.png';
			addChild(offlineIcon);
			offlineIcon.visible = false;
			
			settingButton = new Image()
			settingButton.source = 'assets/room/user_setting1.png';
			settingButton.addEventListener(MouseEvent.CLICK, settingButton_clickHandler)
			addChild(settingButton)
			
			adminIcon = new Image();
			adminIcon.source = 'assets/room/admin.png';
			addChild(adminIcon)
			
			nameLab = new Label();
			nameLab.color = 0x6f1614;
			addChild(nameLab);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			bgImg.width = width;
			bgImg.height = height;
			onlineIcon.width = onlineIcon.height = height*0.8;
			offlineIcon.width = offlineIcon.height = height*0.8;
			settingButton.width = settingButton.height = height*0.8
			adminIcon.width = adminIcon.height = 32
			
			onlineIcon.x = offlineIcon.x = 5;
			onlineIcon.y = offlineIcon.y = (height-onlineIcon.height)/2;
			
			adminIcon.x = settingButton.x = width - settingButton.width-4;
			adminIcon.y = settingButton.y =(height-settingButton.height)/2;
			
			nameLab.fontSize = 28;
			nameLab.height = 40;
			nameLab.textAlign = TextAlign.LEFT;
			nameLab.x = onlineIcon.x+onlineIcon.width+8;
			nameLab.y = 10;
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
				nameLab.text = data.allowSetFlag?(data.subname?data.subname:data.username):data.username
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
				nameLab.text = "";
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xffffff,1);
			graphics.drawRoundRect(0,0,width,height,10,10);
			graphics.endFill();
		}
		
		protected function settingButton_clickHandler(event:MouseEvent):void
		{
			SettingMemberPanel.getInstane().open(data)
		}
		
	}
}