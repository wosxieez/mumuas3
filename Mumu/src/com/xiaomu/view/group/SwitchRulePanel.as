package com.xiaomu.view.group
{
	import com.xiaomu.component.AppPanelSmall;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	
	import coco.component.List;
	import coco.event.UIEvent;
	
	public class SwitchRulePanel extends AppPanelSmall
	{
		public function SwitchRulePanel()
		{
			super();
			
			title = '切换玩法'
			commitEnabled = false
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
			rulesList.addEventListener(UIEvent.CHANGE, rulesList_changeHandler)
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
		
		protected function rulesList_changeHandler(event:UIEvent):void
		{
			AppData.getInstane().rule = rulesList.selectedItem
			close()
		}
		
	}
}