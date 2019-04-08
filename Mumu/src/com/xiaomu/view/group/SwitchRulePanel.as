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
		private var bgImg:Image;
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
			
			bgImg = new Image();
			bgImg.source = 'assets/guild/guild_diban01.png';
			addChild(bgImg);
			
			introduceLab = new Label();
			introduceLab.textAlign = TextAlign.LEFT;
			introduceLab.text = '';
			introduceLab.fontSize = 24;
			introduceLab.color = 0x845525;
			introduceLab.text = '以下是群主设定的本群玩法，请选择一种作为【创建房间】的玩法';
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
			
			bgImg.x = 10;
			bgImg.y = 70;
			bgImg.width = contentWidth-20;
			bgImg.height = contentHeight-bgImg.y-20;
			
			rulesList.y = bgImg.y+10;
			rulesList.x = bgImg.x+10
			rulesList.width = bgImg.width-20
			rulesList.height = bgImg.height-20;
			
			
			titleImg.x = (contentWidth-titleImg.width)/2;
			titleImg.y = -60;
		}
		
		protected function rulesList_changeHandler(event:UIEvent):void
		{
			AppData.getInstane().rule = rulesList.selectedItem
//			close()
		}
		
	}
}