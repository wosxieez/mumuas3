package com.xiaomu.renderer
{
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	
	public class TabBarRender extends DefaultItemRenderer
	{
		public function TabBarRender()
		{
			super();
			autoDrawSkin = false;
		}
		
		private var _selected :Boolean;

		override public function get selected():Boolean
		{
			return _selected;
		}

		override public function set selected(value:Boolean):void
		{
			_selected = value;
			invalidateProperties();
		}
		
		private var img:Image;
		override protected function createChildren():void
		{
			super.createChildren();
			
			labelDisplay.visible = false;
			
			img = new Image();
			addChild(img);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			img.source = 'assets/guild/'+data.value+(selected?'_p':'_n')+'.png'
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			img.width = width;
			img.height = height;
			img.x = (width-img.width)/2;
			img.y = (height-img.height)/2;
		}
	}
}