package com.xiaomu.view.group
{
	import com.xiaomu.component.AppPanelBig;
	import com.xiaomu.event.AppManagerEvent;
	import com.xiaomu.itemRender.GroupRuleRenderer;
	import com.xiaomu.manager.AppManager;
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
			AppManager.getInstance().addEventListener(AppManagerEvent.UPDATE_GROUP_RULES_SUCCESS,updateGroupRulesHandler);
		}
		
		private var bgImg:Image;
		private var rulesList: List
		private var addUserButton:Button;
		private var titleImg:Image
		
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
			rulesList.itemRendererHeight = 100;
			rulesList.gap = 10;
			rulesList.itemRendererClass = GroupRuleRenderer
			addChild(rulesList)
			
			addUserButton = new Button()
			addUserButton.width = 132;
			addUserButton.height = 51;
			addUserButton.label = '添加玩法'
			addUserButton.bold = true;
			addUserButton.fontSize = 24;
			addUserButton.radius = 10;
			addUserButton.color = 0x845525;
			addUserButton.backgroundColor = 0xeadab0;
			addUserButton.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
				new AddRulePanel().open()
			})
			addChild(addUserButton)
			
			titleImg = new Image()
			titleImg.width = 293
			titleImg.height = 86
			titleImg.source = 'assets/group/guild_title_floorSet.png'
			addRawChild(titleImg)
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
			
			titleImg.x = (width - titleImg.width) / 2
			titleImg.y = 5
		}
		
		override public function open():void {
			super.open()
			
			getRuleData();
		}
		
		private function getRuleData():void
		{
			trace("玩法管理界面，获取玩法数据");
			HttpApi.getInstane().getRule({gid: AppData.getInstane().group.id}, function (e:Event):void {
				try
				{
					var response:Object = JSON.parse(e.currentTarget.data)
					if (response.code == 0) {
						trace("获取显示待选的玩法:::::::",JSON.stringify(response.data));
						trace("当前选中的玩法：",JSON.stringify(AppData.getInstane().rule));
						if((response.data as Array).length>0){
							var existFlag:Boolean = false;
							for each (var i:Object in (response.data as Array)) 
							{
								if(i.id==AppData.getInstane().rule.id){
									existFlag = true;
								}
							}
							if(!existFlag){
								AppData.getInstane().rule = (response.data as Array)[0]
								NowSelectedPlayRuleView.getInstance().data = AppData.getInstane().rule;
							}
						}
						
						rulesData = response.data
						AppData.getInstane().allRules = response.data;
						if(JSON.stringify(response.data)=="[]"){
							AppData.getInstane().rule = null;
							trace("没有待选的玩法了xxxxxxxxxxxxxxxxxxxxx");
							NowSelectedPlayRuleView.getInstance().data = null;
						}
					} else {
					}
				} 
				catch(error:Error) 
				{
				}
			})
		}
		
		protected function updateGroupRulesHandler(event:AppManagerEvent):void
		{
			getRuleData();
		}
		
	}
}