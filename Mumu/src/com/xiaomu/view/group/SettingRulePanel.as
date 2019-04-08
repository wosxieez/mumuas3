package com.xiaomu.view.group
{
	import com.xiaomu.component.AppAlert;
	import com.xiaomu.component.AppPanelBig;
	import com.xiaomu.component.CountTool;
	import com.xiaomu.renderer.AddRuleRender;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.ButtonGroup;
	import coco.component.Label;
	import coco.component.TextAlign;
	import coco.component.TextInput;
	import coco.event.UIEvent;
	
	public class SettingRulePanel extends AppPanelBig
	{
		public function SettingRulePanel()
		{
			super();
			
			title = '添加玩法'
		}
		
		private var ruleNameLab:Label//玩法名称
		private var ruleNameInput:TextInput//玩法名称
		private var ruleCountLab:Label//人数
		private var ruleCountBtnGroup:ButtonGroup//人数选择
		private var ruleHXLab:Label//胡息
		private var ruleHXBtnGroup:ButtonGroup;//胡息选择
		private var ruleXFLab:Label//息分
		private var ruleXFTool:CountTool;
		private var ruleNFLab:Label//鸟分
		private var ruleNFTool:CountTool;
		private var ruleFDLab:Label//封顶
		private var ruleFDBtnGroup:ButtonGroup;
		private var ruleTFLab:Label//提成线
		private var ruleTFTool:CountTool;
		private var ruleTCLab:Label//提成值
		private var ruleTCTool:CountTool;
		private var ruleTC2Lab:Label//C2 一级管理员
		private var ruleTC2Tool:CountTool;
		private var ruleTC1Lab:Label//C1  二级管理员
		private var ruleTC1Tool:CountTool;
		
		private var _ruleData:Object
		
		public function get ruleData():Object
		{
			return _ruleData;
		}
		
		public function set ruleData(value:Object):void
		{
			_ruleData = value;
			invalidateProperties()
		}
		
		override protected function createChildren():void {
			super.createChildren()
			
			ruleNameLab = new Label();
			ruleNameLab.textAlign = TextAlign.RIGHT;
			ruleNameLab.fontSize = 24;
			ruleNameLab.color = 0x6f1614;
			ruleNameLab.width = 200;
			ruleNameLab.height = 40;
			ruleNameLab.text = '玩法名:';
			addChild(ruleNameLab);
			
			ruleNameInput = new TextInput();
			ruleNameInput.maxChars = 10;
			ruleNameInput.textAlign = TextAlign.CENTER;
			ruleNameInput.width = 300;
			ruleNameInput.height = 36;
			ruleNameInput.fontSize = 24;
			ruleNameInput.color = 0x6f1614;
			ruleNameInput.radius = 10;
			addChild(ruleNameInput);
			
			ruleCountLab = new Label();
			ruleCountLab.textAlign = TextAlign.RIGHT;
			ruleCountLab.fontSize = 24;
			ruleCountLab.color = 0x6f1614;
			ruleCountLab.width = 200;
			ruleCountLab.height = 40;
			ruleCountLab.text = '人数:';
			addChild(ruleCountLab);
			
			ruleCountBtnGroup = new ButtonGroup();
			ruleCountBtnGroup.dataProvider = [{"name":"二人","value":"2"},{"name":"三人","value":"3"}];
			ruleCountBtnGroup.itemRendererClass = AddRuleRender;
			ruleCountBtnGroup.itemRendererWidth = 150;
			ruleCountBtnGroup.itemRendererHeight = 45;
			ruleCountBtnGroup.gap = 20;
			ruleCountBtnGroup.width = 200*2+10
			ruleCountBtnGroup.addEventListener(UIEvent.CHANGE,ruleCountBtnGroupHandler);
			addChild(ruleCountBtnGroup);
			ruleCountBtnGroup.selectedIndex = 0;
			
			ruleHXLab = new Label();
			ruleHXLab.textAlign = TextAlign.RIGHT;
			ruleHXLab.fontSize = 24;
			ruleHXLab.color = 0x6f1614;
			ruleHXLab.width = 200;
			ruleHXLab.height = 40;
			ruleHXLab.text = '胡息:';
			addChild(ruleHXLab);
			
			ruleHXBtnGroup = new ButtonGroup();
			ruleHXBtnGroup.dataProvider = [{"name":"十胡起胡","value":"10"},{"name":"十五胡起胡","value":"15"}];
			ruleHXBtnGroup.itemRendererClass = AddRuleRender;
			ruleHXBtnGroup.itemRendererWidth = 150;
			ruleHXBtnGroup.itemRendererHeight = 45;
			ruleHXBtnGroup.gap = 20;
			ruleHXBtnGroup.width = 200*2+10
			ruleHXBtnGroup.addEventListener(UIEvent.CHANGE,ruleHXBtnGroupHandler);
			addChild(ruleHXBtnGroup);
			ruleHXBtnGroup.selectedIndex = 1;
			
			ruleXFLab = new Label();
			ruleXFLab.textAlign = TextAlign.RIGHT;
			ruleXFLab.fontSize = 24;
			ruleXFLab.color = 0x6f1614;
			ruleXFLab.width = 200;
			ruleXFLab.height = 40;
			ruleXFLab.text = '息分:';
			addChild(ruleXFLab);
			
			ruleXFTool = new CountTool();
			ruleXFTool.value = 1;
			ruleXFTool.maximum = 100;
			ruleXFTool.minimum =1;
			ruleXFTool.stepSize = 1;
			ruleXFTool.width = 300;
			ruleXFTool.height = 40;
			addChild(ruleXFTool);
			
			ruleNFLab = new Label();
			ruleNFLab.textAlign = TextAlign.RIGHT;
			ruleNFLab.fontSize = 24;
			ruleNFLab.color = 0x6f1614;
			ruleNFLab.width = 200;
			ruleNFLab.height = 40;
			ruleNFLab.text = '鸟分:';
			addChild(ruleNFLab);
			
			ruleNFTool = new CountTool();
			ruleNFTool.value = 0;
			ruleNFTool.stepSize = 10;
			ruleNFTool.maximum = 1000;
			ruleXFTool.minimum = 0;
			ruleNFTool.width = 300;
			ruleNFTool.height = 40;
			addChild(ruleNFTool);
			
			ruleFDLab = new Label();
			ruleFDLab.textAlign = TextAlign.RIGHT;
			ruleFDLab.fontSize = 24;
			ruleFDLab.color = 0x6f1614;
			ruleFDLab.width = 200;
			ruleFDLab.height = 40;
			ruleFDLab.text = '封顶:';
			addChild(ruleFDLab);
			
			ruleFDBtnGroup = new ButtonGroup();
			ruleFDBtnGroup.dataProvider = [{"name":"200息","value":"200"},{"name":"400息","value":"400"}];
			ruleFDBtnGroup.itemRendererClass = AddRuleRender;
			ruleFDBtnGroup.itemRendererWidth = 150;
			ruleFDBtnGroup.itemRendererHeight = 45;
			ruleFDBtnGroup.gap = 20;
			ruleFDBtnGroup.width = 200*2+10
			ruleFDBtnGroup.addEventListener(UIEvent.CHANGE,ruleFDBtnGroupHandler);
			addChild(ruleFDBtnGroup);
			ruleFDBtnGroup.selectedIndex = 0;
			
			ruleTFLab = new Label();
			ruleTFLab.textAlign = TextAlign.RIGHT;
			ruleTFLab.fontSize = 24;
			ruleTFLab.color = 0x6f1614;
			ruleTFLab.width = 200;
			ruleTFLab.height = 40;
			ruleTFLab.text = '提成线:';
			addChild(ruleTFLab);
			
			ruleTFTool = new CountTool();
			ruleTFTool.value = 60;
			ruleTFTool.width = 300;
			ruleTFTool.height = 40;
			ruleTFTool.minimum = 0;
			ruleTFTool.maximum = 10000;
			ruleTFTool.stepSize = 10;
			addChild(ruleTFTool);
			
			ruleTCLab = new Label();
			ruleTCLab.textAlign = TextAlign.RIGHT;
			ruleTCLab.fontSize = 24;
			ruleTCLab.color = 0x6f1614;
			ruleTCLab.width = 200;
			ruleTCLab.height = 40;
			ruleTCLab.text = '提成值:';
			addChild(ruleTCLab);
			
			ruleTCTool = new CountTool();
			ruleTCTool.width = 300;
			ruleTCTool.height = 40;
			ruleTCTool.value = 5;
			ruleTCTool.stepSize = 1;
			addChild(ruleTCTool);
			
			ruleTC1Lab = new Label();
			ruleTC1Lab.textAlign = TextAlign.RIGHT;
			ruleTC1Lab.fontSize = 24;
			ruleTC1Lab.color = 0x6f1614;
			ruleTC1Lab.width = 200;
			ruleTC1Lab.height = 40;
			ruleTC1Lab.text = '二级管理员提成:';
			addChild(ruleTC1Lab);
			
			ruleTC1Tool = new CountTool();
			ruleTC1Tool.width = 300;
			ruleTC1Tool.height = 40;
			ruleTC1Tool.value = 2;
			ruleTC1Tool.stepSize = 0.1;
			addChild(ruleTC1Tool);
			
			ruleTC2Lab = new Label();
			ruleTC2Lab.textAlign = TextAlign.RIGHT;
			ruleTC2Lab.fontSize = 24;
			ruleTC2Lab.color = 0x6f1614;
			ruleTC2Lab.width = 200;
			ruleTC2Lab.height = 40;
			ruleTC2Lab.text = '一级管理员提成:';
			addChild(ruleTC2Lab);
			
			ruleTC2Tool = new CountTool();
			ruleTC2Tool.width = 300;
			ruleTC2Tool.height = 40;
			ruleTC2Tool.value = 1.8;
			ruleTC2Tool.stepSize = 0.1;
			addChild(ruleTC2Tool);
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			ruleNameInput.text = ruleData.rulename
			ruleCountBtnGroup.selectedIndex = 0;
			ruleHXBtnGroup.selectedIndex = 1;
			ruleXFTool.value = ruleData.xf
			ruleNFTool.value = ruleData.nf
			ruleFDBtnGroup.selectedIndex = 0;
			ruleTFTool.value = ruleData.tf
			ruleTCTool.value = ruleData.tc
			ruleTC2Tool.value = ruleData.tc2
			ruleTC1Tool.value = ruleData.tc1
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			var gap:int = 45;
			var topPadding:int = 35;
			ruleNameLab.x=ruleCountLab.x=ruleHXLab.x=ruleXFLab.x=ruleNFLab.x=ruleFDLab.x=ruleTFLab.x=ruleTCLab.x=ruleTC2Lab.x=ruleTC1Lab.x=100
			
			ruleNameLab.y= ruleNameInput.y=topPadding
			ruleCountLab.y= ruleCountBtnGroup.y=topPadding+gap*1
			ruleHXLab.y= ruleHXBtnGroup.y = topPadding+gap*2
			ruleXFLab.y= ruleXFTool.y=topPadding+gap*3
			ruleNFLab.y= ruleNFTool.y=topPadding+gap*4
			ruleFDLab.y= ruleFDBtnGroup.y=topPadding+gap*5
			ruleTFLab.y= ruleTFTool.y=topPadding+gap*6
			ruleTCLab.y= ruleTCTool.y=topPadding+gap*7
			ruleTC2Lab.y= ruleTC2Tool.y=topPadding+gap*8
			ruleTC1Lab.y= ruleTC1Tool.y=topPadding+gap*9
			
			ruleNameInput.x =ruleCountBtnGroup.x= ruleHXBtnGroup.x=ruleXFTool.x=ruleNFTool.x=ruleFDBtnGroup.x=ruleTFTool.x=ruleTCTool.x=ruleTC1Tool.x=ruleTC2Tool.x=320;
		}
		
		/**
		 * 人数
		 */
		protected function ruleCountBtnGroupHandler(event:UIEvent):void
		{
			ruleCountBtnGroup.selectedIndex = 0;
		}
		
		protected function ruleFDBtnGroupHandler(event:UIEvent):void
		{
			ruleFDBtnGroup.selectedIndex = 0;
		}
		
		protected function ruleHXBtnGroupHandler(event:UIEvent):void
		{
			ruleHXBtnGroup.selectedIndex = 1;
		}
		
		override protected function commitButton_clickHandler(event:MouseEvent):void {
			HttpApi.getInstane().updateRule({update: {
				rulename: ruleNameInput.text,
				cc: int(ruleCountBtnGroup.selectedItem.value),
				hx: int(ruleHXBtnGroup.selectedItem.value),
				xf: Number(ruleXFTool.value),
				nf: Number(ruleNFTool.value),
				fd: Number(ruleFDBtnGroup.selectedItem.value),
				tc2: Number(ruleTC2Tool.value),
				tc1: Number(ruleTC1Tool.value),
				tc: Number(ruleTCTool.value),
				tf: Number(ruleTFTool.value)}, query: {id: ruleData.id}},  
				function (e:Event):void {
					try
					{
						var response:Object = JSON.parse(e.currentTarget.data)
						if (response.code == 0) {
							AppAlert.show('更新玩法成功')
							close()
						} else {
							AppAlert.show('更新玩法失败')
						}
					} 
					catch(error:Error) 
					{
						AppAlert.show('更新玩法失败')
					}
				})
		}
	}
}


