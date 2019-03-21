package com.xiaomu.view.newGroup
{
	import coco.component.Button;
	import coco.component.Image;
	import coco.component.List;
	import coco.core.UIComponent;
	
	public class ChangePlayRuleListView extends UIComponent
	{
		public function ChangePlayRuleListView()
		{
			super();
		}
		
		private var _playRuleData:Array=[]
		public function get playRuleData():Array
		{
			return _playRuleData;
		}

		public function set playRuleData(value:Array):void
		{
			_playRuleData = value;
			invalidateProperties();
		}
		
		private var bgImg:Image
		private var changePlayRuleList:List;
		private var addRuleBtn:Button;
		override protected function createChildren():void
		{
			super.createChildren();
			
			changePlayRuleList = new List();
			changePlayRuleList.itemRendererHeight = 20;
			changePlayRuleList.labelField = 'name';
			addChild(changePlayRuleList);
			
			addRuleBtn = new Button();
			addRuleBtn.label = '+';
			addChild(addRuleBtn);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			trace(width,height)
			addRuleBtn.width = width;
			addRuleBtn.height = 20;
			changePlayRuleList.width = width;
			changePlayRuleList.height = height-addRuleBtn.height;
			changePlayRuleList.y = 0;
			addRuleBtn.y = height-addRuleBtn.height;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			changePlayRuleList.dataProvider = playRuleData;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xffffff,0.3);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
		
		
	}
}