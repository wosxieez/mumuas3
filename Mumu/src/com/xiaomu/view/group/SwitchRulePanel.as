package com.xiaomu.view.group
{
	import com.xiaomu.component.AppPanelBig;
	import com.xiaomu.renderer.RulesListRender;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.List;
	import coco.component.TextAlign;
	import coco.event.UIEvent;
	
	public class SwitchRulePanel extends AppPanelBig
	{
		public function SwitchRulePanel()
		{
			super();
			
//			title = '切换玩法'
			commitEnabled = false
		}
		
		private var titleImg:Image;
		private var introduceLab:Label;
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
				
			titleImg = new Image();
			titleImg.source = 'assets/guild/guild_title_choose.png';
			titleImg.width = 293;
			titleImg.height = 86;
			addChild(titleImg);
			
			introduceLab = new Label();
			introduceLab.textAlign = TextAlign.LEFT;
			introduceLab.text = '';
			introduceLab.fontSize = 24;
			introduceLab.color = 0x845525;
			introduceLab.text = '以下是群主设定的本群玩法，请选择一种作为【快速开始】的玩法';
			addChild(introduceLab);
			
			rulesList = new List()
			rulesList.labelField = 'rulename'
			rulesList.itemRendererHeight = 70;
			rulesList.gap = 10;
			rulesList.itemRendererClass = RulesListRender;
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
			
			introduceLab.width = contentWidth;
			introduceLab.y = 30;
			
			rulesList.width = contentWidth
			rulesList.height = contentHeight-60-40;
			rulesList.y = 60;
			
			titleImg.x = (contentWidth-titleImg.width)/2;
			titleImg.y = -(titleImg.height)/2-20;
		}
		
		protected function rulesList_changeHandler(event:UIEvent):void
		{
			AppData.getInstane().rule = rulesList.selectedItem
//			close()
		}
		
	}
}