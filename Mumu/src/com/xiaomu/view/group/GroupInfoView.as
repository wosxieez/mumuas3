package com.xiaomu.view.group
{
	import flash.events.MouseEvent;
	
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextAlign;
	import coco.component.TextArea;
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	
	/**
	 * 组群信息界面
	 */
	public class GroupInfoView extends UIComponent
	{
		public function GroupInfoView()
		{
			super();
		}
		private var copyGroupInfoData:Object
		
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
		private var settingButton:Image;
		override protected function createChildren():void
		{
			super.createChildren();
			
			titleLab = new Label();
			titleLab.width = 200;
			titleLab.height = 40;
			titleLab.textAlign = TextAlign.LEFT;
			titleLab.fontSize = 20;
			titleLab.color = 0xffffff;
			addChild(titleLab);
			
			adminLab = new Label();
			adminLab.width = 160;
			adminLab.height = 40;
			adminLab.textAlign = TextAlign.LEFT;
			adminLab.fontSize = 20;
			adminLab.color = 0xffffff;
			addChild(adminLab);
			
			remarkLab = new Label();
			remarkLab.width = 80;
			remarkLab.height = 40;
			remarkLab.fontSize = 20;
			remarkLab.color = 0xffffff;
			remarkLab.text = '群介绍: ';
			addChild(remarkLab);
			
			remarkText = new TextArea();
			remarkText.color = 0xffffff;
			remarkText.backgroundAlpha = 0;
			remarkText.borderAlpha = 0;
			remarkText.editable = false;
			remarkText.fontSize = 20;
			addChild(remarkText);
			
			settingButton = new Image()
			settingButton.source = 'assets/room/user_setting.png';
			settingButton.width = settingButton.height = 32
			settingButton.addEventListener(MouseEvent.CLICK, settingButton_clickHandler)
			addChild(settingButton)
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			titleLab.text = groupInfoData?'群名: '+groupInfoData.group_name:'群名: /'
			adminLab.text = groupInfoData?'群主: '+groupInfoData.admin_name:'群主: /'
			remarkText.text = groupInfoData?groupInfoData.remark:'/'
			settingButton.visible = groupInfoData.isNowGroupAdmin///只有群主才能看到设置界面
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			titleLab.x = titleLab.y = 0;
			remarkLab.y = 0;
			remarkLab.x = titleLab.x+titleLab.width;
			adminLab.x = 0
			adminLab.y = titleLab.y+titleLab.height;
			remarkText.width = width-remarkLab.width-remarkLab.x-30;
			remarkText.height = height*1;
			remarkText.x = remarkLab.x+remarkLab.width;
			remarkText.y = remarkLab.y+2;
			
			settingButton.x = width-settingButton.width-5;
			settingButton.y = height-settingButton.height-5;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xffffff,0.1);
			graphics.drawRoundRect(0,0,width,height,10,10);
			graphics.endFill();
		}
		
		protected function settingButton_clickHandler(event:MouseEvent):void
		{
			var settingGroupPanel:SettingGroupPanel;
			if(!settingGroupPanel){
				settingGroupPanel = new SettingGroupPanel();
			}
			settingGroupPanel.data = copyGroupInfoData?copyGroupInfoData:groupInfoData;
			PopUpManager.centerPopUp(PopUpManager.addPopUp(settingGroupPanel,null,true,true,0xffffff,0.4));
		}
	}
}