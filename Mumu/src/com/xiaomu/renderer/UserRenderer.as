package com.xiaomu.renderer
{
	import com.xiaomu.view.group.SettingMemberPanel;
	
	import flash.events.MouseEvent;
	
	import coco.component.Button;
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
		private var settingButton:Button
		override protected function createChildren():void
		{
			super.createChildren();
			
			onlineIcon = new Image();
			onlineIcon.source = 'assets/room/online.png';
			onlineIcon.width = onlineIcon.height = 20;
			addChild(onlineIcon);
			onlineIcon.visible = false;
			
			offlineIcon = new Image();
			offlineIcon.source = 'assets/room/offline.png';
			offlineIcon.width = offlineIcon.height = 20;
			addChild(offlineIcon);
			offlineIcon.visible = false;
			
			labelDisplay.color = 0xFFFFFF
				
			settingButton = new Button()
			settingButton.label = 'Setting'
			settingButton.width = settingButton.height = 20
			settingButton.addEventListener(MouseEvent.CLICK, settingButton_clickHandler)
			addChild(settingButton)
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			onlineIcon.x = offlineIcon.x = 5;
			onlineIcon.y = offlineIcon.y = (height-onlineIcon.height)/2;
			
			settingButton.x = width - settingButton.width
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if (data)
			{
				labelDisplay.text = data.username
				labelDisplay.fontSize = 8;
				labelDisplay.textAlign = TextAlign.LEFT;
				labelDisplay.x = onlineIcon.x+onlineIcon.width+8;
				if(data.online){
					onlineIcon.visible = true;
					offlineIcon.visible = false;
				}else{
					onlineIcon.visible = false;
					offlineIcon.visible = true;
				}
				settingButton.visible = data.allowSetFlag
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