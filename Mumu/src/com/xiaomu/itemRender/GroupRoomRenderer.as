package com.xiaomu.itemRender
{
	import coco.component.DefaultItemRenderer;
	
	public class GroupRoomRenderer extends DefaultItemRenderer
	{
		public function GroupRoomRenderer()
		{
			super();
			mouseChildren = true
		}
		
		override protected function createChildren():void {
			super.createChildren()
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			if (data) {
				labelDisplay.text = JSON.stringify(data)
			}
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
		}
		
	}
}