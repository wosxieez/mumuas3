package com.xiaomu.view.group
{
	import com.xiaomu.component.AppPanel;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.List;
	
	public class SwitchRulePanel extends AppPanel
	{
		public function SwitchRulePanel()
		{
			super();
			
			title = '切换玩法'
		}
		
		private var rulesList:List
		
		private var _rulesData:Array
		
		public function get rulesData():Array
		{
			return _rulesData;
		}
		
		public function set rulesData(value:Array):void
		{
			_rulesData = value;
			invalidateProperties()
		}
		
		override protected function createChildren():void {
			super.createChildren()
			
			rulesList = new List()
			rulesList.labelField = 'rulename'
			addChild(rulesList)
			
			HttpApi.getInstane().getRule({gid: AppData.getInstane().group.id}, 
				function (e:Event):void {
					try
					{
						var response:Object = JSON.parse(e.currentTarget.data)
						if (response.code == 0) {
							rulesData = response.data
						} else {
						}
					} 
					catch(error:Error) 
					{
					}
				})
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			rulesList.dataProvider = rulesData
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			rulesList.width = contentWidth
			rulesList.height = contentHeight
		}
		
		override protected function commitButton_clickHandler(event:MouseEvent):void {
			
		}
		
	}
}