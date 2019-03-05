package com.xiaomu.component
{
	import coco.component.List;
	
	public class UserStatusList extends List
	{
		public function UserStatusList()
		{
			super();
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xffffff,.2);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
	}
}