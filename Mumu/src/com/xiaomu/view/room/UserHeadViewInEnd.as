package com.xiaomu.view.room
{
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextAlign;
	import coco.core.UIComponent;
	
	public class UserHeadViewInEnd extends UIComponent
	{
		public function UserHeadViewInEnd()
		{
			super();
		}
		
		private var _data:Object;

		public function get data():Object
		{
			return _data;
		}

		public function set data(value:Object):void
		{
			_data = value;
			invalidateProperties();
		}

		private var userNameLab:Label;
		private var userHeadIcon:Image;
		private var daNiaoImg:Image;
		override protected function createChildren():void
		{
			super.createChildren();
			
			userHeadIcon = new Image();
			userHeadIcon.source = 'assets/hall/headIcon.png';
			addChild(userHeadIcon);
			
			userNameLab = new Label();
			userNameLab.text = '测试';
			userNameLab.textAlign = TextAlign.LEFT;
			userNameLab.color = 0x89755c;
			userNameLab.fontSize = 24;
			addChild(userNameLab);
			
			daNiaoImg = new Image();
			daNiaoImg.source = 'assets/endAll/dn.png';
			daNiaoImg.width = daNiaoImg.height = 38;
			addChild(daNiaoImg);
			daNiaoImg.visible =false;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if(data){
				userNameLab.text = data.username;
//				trace("aaa:",JSON.stringify(data));
				daNiaoImg.visible = data.dn;
			}
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			userHeadIcon.width = height;
			userHeadIcon.height = height;
			
			daNiaoImg.x = userHeadIcon.x+userHeadIcon.width-daNiaoImg.width*2/4;
			daNiaoImg.y = userHeadIcon.y-daNiaoImg.height/4;
			
			userNameLab.x = userHeadIcon.x+userHeadIcon.width+10;
			userNameLab.y = 18;
		}
	}
}