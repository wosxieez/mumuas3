package com.xiaomu.view.group
{
	import coco.component.Label;
	import coco.component.TextAlign;
	import coco.component.TextArea;
	import coco.core.UIComponent;
	
	/**
	 * 组群信息界面
	 */
	public class GroupInfoView extends UIComponent
	{
		public function GroupInfoView()
		{
			super();
		}

		private var _groupInfoData:Object;

		public function get groupInfoData():Object
		{
			return _groupInfoData;
		}

		public function set groupInfoData(value:Object):void
		{
			_groupInfoData = value;
			invalidateProperties();
		}

		
		private var titleLab:Label;
		private var remarkLab:Label;
		private var adminLab:Label;
		private var remarkText:TextArea;
		override protected function createChildren():void
		{
			super.createChildren();
			
			titleLab = new Label();
			titleLab.width = 80;
			titleLab.height = 20;
			titleLab.textAlign = TextAlign.LEFT;
			titleLab.fontSize = 10;
			titleLab.color = 0xffffff;
			addChild(titleLab);
			
			adminLab = new Label();
			adminLab.width = 80;
			adminLab.height = 20;
			adminLab.textAlign = TextAlign.LEFT;
			adminLab.fontSize = 10;
			adminLab.color = 0xffffff;
			addChild(adminLab);
			
			remarkLab = new Label();
			remarkLab.width = 40;
			remarkLab.height = 20;
			remarkLab.fontSize = 10;
			remarkLab.color = 0xffffff;
			remarkLab.text = '群介绍: ';
			addChild(remarkLab);
			
			remarkText = new TextArea();
			remarkText.color = 0xffffff;
			remarkText.backgroundAlpha = 0;
			remarkText.borderAlpha = 0;
			remarkText.editable = false;
			remarkText.fontSize = 10;
			addChild(remarkText);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
//			trace('groupInfoData:',JSON.stringify(groupInfoData));
			titleLab.text = groupInfoData?'群名: '+groupInfoData.groupName:'群名: /'
			adminLab.text = groupInfoData?'群主: '+groupInfoData.admin_name:'群主: /'
			remarkText.text = groupInfoData?groupInfoData.remark:'/'
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			titleLab.x = titleLab.y = 0;
			remarkLab.y = 0;
			remarkLab.x = titleLab.x+titleLab.width;
			adminLab.x = 0
			adminLab.y = titleLab.y+titleLab.height;
			remarkText.width = width-remarkLab.width-remarkLab.x-10;
			remarkText.height = height*1.2;
			remarkText.x = remarkLab.x+remarkLab.width;
			remarkText.y = remarkLab.y-3;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xffffff,0.1);
			graphics.drawRoundRect(0,0,width,height,10,10);
			graphics.endFill();
		}
	}
}