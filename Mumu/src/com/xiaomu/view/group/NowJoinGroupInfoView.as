package com.xiaomu.view.group
{
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextArea;
	import coco.core.UIComponent;
	
	/**
	 * 当前进入的群的信息界面
	 */
	public class NowJoinGroupInfoView extends UIComponent
	{
		public function NowJoinGroupInfoView()
		{
			super();
			width = 453;
			height = 100-10;
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
		
		private var bgImg:Image;
		private var groupName:Label;
		private var adminName:Label;
		private var groupId:Label;
		private var chengyuanNumber:Label;
		override protected function createChildren():void
		{
			super.createChildren();
			
			bgImg = new Image();
			bgImg.source = 'assets/guild/guild2_diban2.png';
			addChild(bgImg);
			
			groupName = new Label();
			groupName.fontSize = 18;
			groupName.color = 0xffffff;
			addChild(groupName);
			
			adminName = new Label();
			adminName.fontSize = 18;
			adminName.color = 0xffffff;
			addChild(adminName);
			
			groupId = new Label();
			groupId.fontSize = 18;
			groupId.color = 0xffffff;
			addChild(groupId);
			
			chengyuanNumber = new Label();
			chengyuanNumber.fontSize = 18;
			chengyuanNumber.color = 0xffffff;
			addChild(chengyuanNumber);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			trace("当前群：",JSON.stringify(data));
			if(data){
				groupName.text =  data.groupname;
				adminName.text = "群主："+data.adminName;
				groupId.text = "群ID："+data.id;
				chengyuanNumber.text = "成员："+data.userArr.length
			}
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			bgImg.width = width;
			bgImg.height = height;
			
			groupName.x = 10;
			groupName.y = 10;
			
			adminName.x = groupName.x;
			adminName.y = 50;
			
			groupId.x = width/2;
			groupId.y = groupName.y;
			
			chengyuanNumber.x = groupId.x;
			chengyuanNumber.y = adminName.y;
		}
	}
}