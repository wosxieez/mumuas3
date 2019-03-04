package com.xiaomu.renderer
{
	import coco.component.DefaultItemRenderer;
	
	public class UserRenderer extends DefaultItemRenderer
	{
		public function UserRenderer()
		{
			super();
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if (data)
			{
				labelDisplay.text = data.username + (data.online ? '  在线' : ' 离线')
			}
			else
				labelDisplay.text = "";
		}
		
	}
}