package com.xiaomu.view.group
{
	import com.xiaomu.component.AppPanelBig;
	import com.xiaomu.itemRender.GroupRuleRenderer;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Button;
	import coco.component.Image;
	import coco.component.List;
	
	public class GroupRulesPanel extends AppPanelBig
	{
		public function GroupRulesPanel()
		{
			super();
			
			title = '玩法管理'
			commitEnabled = false
		}
		
		private var bgImg:Image;
		private var rulesList: List
		private var addUserButton:Button;
		
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
			
			bgImg = new Image();
			bgImg.source = 'assets/guild/guild_diban01.png';
			addChild(bgImg);
			
			rulesList = new List()
			rulesList.itemRendererHeight = 70;
			rulesList.gap = 10;
			rulesList.itemRendererClass = GroupRuleRenderer
			addChild(rulesList)
			
			addUserButton = new Button()
			addUserButton.width = 132;
			addUserButton.height = 51;
			addUserButton.label = '添加玩法'
			addUserButton.radius = 10;
			addUserButton.color = 0x845525;
			addUserButton.backgroundColor = 0xeadab0;
			addUserButton.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
				new AddRulePanel().open()
			})
			addChild(addUserButton)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			rulesList.dataProvider = rulesData
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			addUserButton.x = (contentWidth-addUserButton.width)/2;
			addUserButton.y = contentHeight-addUserButton.height-20;
			
			bgImg.x = 10;
			bgImg.y = 10;
			bgImg.width = contentWidth-20;
			bgImg.height = addUserButton.y-bgImg.y-20;
			
			rulesList.y = bgImg.y+10;
			rulesList.x = bgImg.x+10;
			rulesList.width = contentWidth-40
			rulesList.height = addUserButton.y-rulesList.y-30;
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