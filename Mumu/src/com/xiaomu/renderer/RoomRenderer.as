package com.xiaomu.renderer
{
	import coco.component.Button;
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	
	public class RoomRenderer extends DefaultItemRenderer
	{
		public function RoomRenderer()
		{
			super();
			autoDrawSkin = false;
		}
		
		
		private var tableImg : Image;
		override protected function createChildren():void
		{
			super.createChildren();
			
			tableImg = new Image();
			tableImg.width = 120;
			tableImg.height = 80;
			tableImg.source = 'assets/room/club_table_3.png';
			addChild(tableImg);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
//			if (data)
//			{
//				var users:String
//				labelDisplay.text = data.name + '用户 ' + (data.users ? data.users.join(' , ') : '')
//			}
//			else
//				labelDisplay.text = "";
		}
		
	}
}