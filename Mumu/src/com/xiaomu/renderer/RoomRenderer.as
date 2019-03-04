package com.xiaomu.renderer
{
	import coco.component.DefaultItemRenderer;
	
	public class RoomRenderer extends DefaultItemRenderer
	{
		public function RoomRenderer()
		{
			super();
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if (data)
			{
				var users:String
				labelDisplay.text = data.name + '用户 ' + (data.users ? data.users.join(' , ') : '')
			}
			else
				labelDisplay.text = "";
		}
		
	}
}