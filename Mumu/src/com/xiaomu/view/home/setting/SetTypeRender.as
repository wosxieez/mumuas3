package com.xiaomu.view.home.setting
{
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	
	public class SetTypeRender extends DefaultItemRenderer
	{
		public function SetTypeRender()
		{
			super();
			autoDrawSkin = false
		}
		
		private var _data:Object;

		override public function get data():Object
		{
			return _data;
		}

		override public function set data(value:Object):void
		{
			_data = value;
			invalidateProperties();
		}

		private var image:Image;
		override protected function createChildren():void
		{
			super.createChildren();
			
			image = new Image();
			addChild(image);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			image.width = width;
			image.height = height;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			image.source = 'assets/home/settingPanel/'+data.image+'.png';
		}
		
		
	}
}