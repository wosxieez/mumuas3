package com.xiaomu.renderer
{
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	import coco.component.TextAlign;
	
	public class UserRenderer extends DefaultItemRenderer
	{
		public function UserRenderer()
		{
			super();
		}
		
		private var onlineIcon : Image;
		private var offlineIcon : Image;
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
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			onlineIcon.x = offlineIcon.x = 5;
			onlineIcon.y = offlineIcon.y = (height-onlineIcon.height)/2;
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
			}
			else
				labelDisplay.text = "";
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(selected?0xeeeeee:0xffffff);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
		
	}
}