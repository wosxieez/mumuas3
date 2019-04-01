package com.xiaomu.view.group
{
	import com.xiaomu.component.AppPanelBig;
	import com.xiaomu.itemRender.GroupRuleRenderer;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Button;
	import coco.component.HGroup;
	import coco.component.List;
	
	public class GroupRulesPanel extends AppPanelBig
	{
		public function GroupRulesPanel()
		{
			super();
			
			title = '玩法管理'
		}
		
		private var rulesList: List
		private var bottomGroup: HGroup
		
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
			rulesList.itemRendererClass = GroupRuleRenderer
			addChild(rulesList)
			
			bottomGroup = new HGroup()
			addChild(bottomGroup)
			
			var addUserButton:Button = new Button()
			addUserButton.label = '添加玩法'
			addUserButton.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
				new AddRulePanel().open()
			})
			bottomGroup.addChild(addUserButton)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			rulesList.dataProvider = rulesData
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			bottomGroup.width = contentWidth
			bottomGroup.height = 50
			bottomGroup.y = contentHeight - bottomGroup.height
			
			rulesList.width = contentWidth
			rulesList.height = bottomGroup.y
		}
		
		override public function open():void {
			super.open()
				
			HttpApi.getInstane().getRule({gid: AppData.getInstane().group.id}, function (e:Event):void {
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
		
	}
}