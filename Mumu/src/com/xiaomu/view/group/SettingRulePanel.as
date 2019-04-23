package com.xiaomu.view.group
{
	import com.xiaomu.component.AppAlertSmall;
	import com.xiaomu.component.AppPanelBig;
	import com.xiaomu.component.CountTool;
	import com.xiaomu.event.AppManagerEvent;
	import com.xiaomu.manager.AppManager;
	import com.xiaomu.renderer.AddRuleRender;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.ButtonGroup;
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.Scroller;
	import coco.component.TextAlign;
	import coco.component.TextInput;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	
	public class SettingRulePanel extends AppPanelBig
	{
		public function SettingRulePanel()
		{
			super();
		}
		
		private var bgUI:UIComponent;//底部UI
		private var scroller:Scroller;
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
		private var minPlzLab:Label;
		private var minPlzTool:CountTool;///最低疲劳值
		private var titleImg:Image
		
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
				
			scroller = new Scroller();
			scroller.autoDrawSkin = true;
			scroller.verticalScrollEnabled = true;
			scroller.horizontalScrollEnabled = false;
			addChild(scroller);
			
			bgUI = new UIComponent();
			scroller.addChild(bgUI);
			
			ruleNameLab = new Label();
			ruleNameLab.textAlign = TextAlign.RIGHT;
			ruleNameLab.fontSize = 20;
			ruleNameLab.color = 0x6f1614;
			ruleNameLab.width = 380;
			ruleNameLab.height = 40;
			ruleNameLab.text = '玩法名:';
			bgUI.addChild(ruleNameLab);
			ruleNameLab.visible= false;
			
			ruleNameInput = new TextInput();
			ruleNameInput.maxChars = 10;
			ruleNameInput.textAlign = TextAlign.CENTER;
			ruleNameInput.width = 350;
			ruleNameInput.height = 36;
			ruleNameInput.fontSize = 20;
			ruleNameInput.color = 0x6f1614;
			ruleNameInput.radius = 10;
			bgUI.addChild(ruleNameInput);
			ruleNameInput.visible= false;
			
			ruleCountLab = new Label();
			ruleCountLab.textAlign = TextAlign.RIGHT;
			ruleCountLab.fontSize = 20;
			ruleCountLab.color = 0x6f1614;
			ruleCountLab.width = 380;
			ruleCountLab.height = 40;
			ruleCountLab.text = '人数:';
			bgUI.addChild(ruleCountLab);
			
			ruleCountBtnGroup = new ButtonGroup();
			ruleCountBtnGroup.dataProvider = [{"name":"二人","value":"2"},{"name":"三人","value":"3"}];
			ruleCountBtnGroup.itemRendererClass = AddRuleRender;
			ruleCountBtnGroup.itemRendererWidth = 200;
			ruleCountBtnGroup.itemRendererHeight = 45;
			ruleCountBtnGroup.gap = 20;
			ruleCountBtnGroup.width = 200*2+10
			ruleCountBtnGroup.addEventListener(UIEvent.CHANGE,ruleCountBtnGroupHandler);
			bgUI.addChild(ruleCountBtnGroup);
			ruleCountBtnGroup.selectedIndex = 0;
			
			ruleHXLab = new Label();
			ruleHXLab.textAlign = TextAlign.RIGHT;
			ruleHXLab.fontSize = 20;
			ruleHXLab.color = 0x6f1614;
			ruleHXLab.width = 380;
			ruleHXLab.height = 40;
			ruleHXLab.text = '胡息:';
			bgUI.addChild(ruleHXLab);
			
			ruleHXBtnGroup = new ButtonGroup();
			ruleHXBtnGroup.dataProvider = [{"name":"十胡息起胡","value":"10"},{"name":"十五胡息起胡","value":"15"}];
			ruleHXBtnGroup.itemRendererClass = AddRuleRender;
			ruleHXBtnGroup.itemRendererWidth = 200;
			ruleHXBtnGroup.itemRendererHeight = 45;
			ruleHXBtnGroup.gap = 20;
			ruleHXBtnGroup.width = 200*2+10
			ruleHXBtnGroup.addEventListener(UIEvent.CHANGE,ruleHXBtnGroupHandler);
			bgUI.addChild(ruleHXBtnGroup);
			ruleHXBtnGroup.selectedIndex = 1;
			
			ruleXFLab = new Label();
			ruleXFLab.textAlign = TextAlign.RIGHT;
			ruleXFLab.fontSize = 20;
			ruleXFLab.color = 0x6f1614;
			ruleXFLab.width = 380;
			ruleXFLab.height = 40;
			ruleXFLab.text = '息分(一胡息代表的分数):';
			bgUI.addChild(ruleXFLab);
			
			ruleXFTool = new CountTool();
			ruleXFTool.value = 1;
			ruleXFTool.maximum = 100;
			ruleXFTool.minimum =0;
			ruleXFTool.stepSize = 0.1;
			ruleXFTool.width = 350;
			ruleXFTool.height = 40;
			bgUI.addChild(ruleXFTool);
			
			ruleNFLab = new Label();
			ruleNFLab.textAlign = TextAlign.RIGHT;
			ruleNFLab.fontSize = 20;
			ruleNFLab.color = 0x6f1614;
			ruleNFLab.width = 380;
			ruleNFLab.height = 40;
			ruleNFLab.text = '鸟分(0分表示不打鸟):';
			bgUI.addChild(ruleNFLab);
			
			ruleNFTool = new CountTool();
			ruleNFTool.value = 0;
			ruleNFTool.stepSize = 10;
			ruleNFTool.maximum = 1000;
			ruleXFTool.minimum = 0;
			ruleNFTool.width = 350;
			ruleNFTool.height = 40;
			bgUI.addChild(ruleNFTool);
			
			ruleFDLab = new Label();
			ruleFDLab.textAlign = TextAlign.RIGHT;
			ruleFDLab.fontSize = 20;
			ruleFDLab.color = 0x6f1614;
			ruleFDLab.width = 380;
			ruleFDLab.height = 40;
			ruleFDLab.text = '封顶:';
			bgUI.addChild(ruleFDLab);
			
			ruleFDBtnGroup = new ButtonGroup();
			ruleFDBtnGroup.dataProvider = [{"name":"200胡息","value":"200"},{"name":"400胡息","value":"400"}];
			ruleFDBtnGroup.itemRendererClass = AddRuleRender;
			ruleFDBtnGroup.itemRendererWidth = 150;
			ruleFDBtnGroup.itemRendererHeight = 45;
			ruleFDBtnGroup.gap = 20;
			ruleFDBtnGroup.width = 200*2+10
			ruleFDBtnGroup.addEventListener(UIEvent.CHANGE,ruleFDBtnGroupHandler);
			bgUI.addChild(ruleFDBtnGroup);
			ruleFDBtnGroup.selectedIndex = 0;
			
			ruleTFLab = new Label();
			ruleTFLab.textAlign = TextAlign.RIGHT;
			ruleTFLab.fontSize = 20;
			ruleTFLab.color = 0x6f1614;
			ruleTFLab.width = 380;
			ruleTFLab.height = 40;
			ruleTFLab.text = '提成线分(大于该值才会提成):';
			bgUI.addChild(ruleTFLab);
			
			ruleTFTool = new CountTool();
			ruleTFTool.value = 60;
			ruleTFTool.width = 350;
			ruleTFTool.height = 40;
			ruleTFTool.minimum = 0;
			ruleTFTool.maximum = 10000;
			ruleTFTool.stepSize = 10;
			bgUI.addChild(ruleTFTool);
			
			ruleTCLab = new Label();
			ruleTCLab.textAlign = TextAlign.RIGHT;
			ruleTCLab.fontSize = 20;
			ruleTCLab.color = 0x6f1614;
			ruleTCLab.width = 380;
			ruleTCLab.height = 40;
			ruleTCLab.text = '提成分(一局总提成的分数):';
			bgUI.addChild(ruleTCLab);
			
			ruleTCTool = new CountTool();
			ruleTCTool.width = 350;
			ruleTCTool.height = 40;
			ruleTCTool.value = 5;
			ruleTCTool.stepSize = 1;
			bgUI.addChild(ruleTCTool);
			
			ruleTC1Lab = new Label();
			ruleTC1Lab.textAlign = TextAlign.RIGHT;
			ruleTC1Lab.fontSize = 20;
			ruleTC1Lab.color = 0x6f1614;
			ruleTC1Lab.width = 380;
			ruleTC1Lab.height = 40;
			ruleTC1Lab.text = '二级管理员每局提成分:';
			bgUI.addChild(ruleTC1Lab);
			
			ruleTC1Tool = new CountTool();
			ruleTC1Tool.width = 350;
			ruleTC1Tool.height = 40;
			ruleTC1Tool.value = 2;
			ruleTC1Tool.stepSize = 0.1;
			bgUI.addChild(ruleTC1Tool);
			
			ruleTC2Lab = new Label();
			ruleTC2Lab.textAlign = TextAlign.RIGHT;
			ruleTC2Lab.fontSize = 20;
			ruleTC2Lab.color = 0x6f1614;
			ruleTC2Lab.width = 380;
			ruleTC2Lab.height = 40;
			ruleTC2Lab.text = '一级管理员每局提成分:';
			bgUI.addChild(ruleTC2Lab);
			
			ruleTC2Tool = new CountTool();
			ruleTC2Tool.width = 350;
			ruleTC2Tool.height = 40;
			ruleTC2Tool.value = 1.8;
			ruleTC2Tool.stepSize = 0.1;
			bgUI.addChild(ruleTC2Tool);
			
			minPlzLab = new Label();
			minPlzLab.textAlign = TextAlign.RIGHT;
			minPlzLab.fontSize = 20;
			minPlzLab.color = 0x6f1614;
			minPlzLab.width = 380;
			minPlzLab.height = 40;
			minPlzLab.text = '最低分(大于该分才能进入房间):';
			bgUI.addChild(minPlzLab);
			
			minPlzTool = new CountTool();
			minPlzTool.width = 350;
			minPlzTool.height = 40;
			minPlzTool.value = 0;
			minPlzTool.stepSize = 10;
			minPlzTool.maximum = 1000;
			bgUI.addChild(minPlzTool);
			
			titleImg = new Image()
			titleImg.width = 293
			titleImg.height = 86
			titleImg.source = 'assets/group/guild_title_floorSet.png'
			addRawChild(titleImg)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			ruleNameInput.text = ruleData.rulename
			ruleCountBtnGroup.selectedIndex = 0
			ruleHXBtnGroup.selectedIndex = 1
			ruleXFTool.value = ruleData.xf
			ruleNFTool.value = ruleData.nf
			ruleFDBtnGroup.selectedIndex = 0
			ruleTFTool.value = ruleData.tf
			ruleTCTool.value = ruleData.tc
			ruleTC2Tool.value = ruleData.tc2
			ruleTC1Tool.value = ruleData.tc1
			minPlzTool.value = ruleData.plz
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			scroller.y = 10;
			scroller.width = contentWidth;
			scroller.height = contentHeight+10;
			scroller.verticalScrollPosition = contentHeight
			
			bgUI.width = contentWidth;
			bgUI.height = contentHeight+50;
			
			var gap:int = 45;
			var topPadding:int = 10//35;
			ruleNameLab.x=ruleCountLab.x=ruleHXLab.x=ruleXFLab.x=ruleNFLab.x=ruleFDLab.x=ruleTFLab.x=ruleTCLab.x=ruleTC2Lab.x=ruleTC1Lab.x=minPlzLab.x=0
			ruleNameLab.y= ruleNameInput.y=topPadding
			ruleCountLab.y= ruleCountBtnGroup.y=topPadding
			ruleHXLab.y= ruleHXBtnGroup.y = topPadding+gap*1
			ruleXFLab.y= ruleXFTool.y=topPadding+gap*2
			ruleNFLab.y= ruleNFTool.y=topPadding+gap*3
			ruleFDLab.y= ruleFDBtnGroup.y=topPadding+gap*4
			ruleTFLab.y= ruleTFTool.y=topPadding+gap*5
			ruleTCLab.y= ruleTCTool.y=topPadding+gap*6
			ruleTC2Lab.y= ruleTC2Tool.y=topPadding+gap*7
			ruleTC1Lab.y= ruleTC1Tool.y=topPadding+gap*8
			minPlzLab.y = minPlzTool.y = topPadding+gap*9;
			
			ruleNameInput.x =ruleCountBtnGroup.x= ruleHXBtnGroup.x=ruleXFTool.x=ruleNFTool.x=ruleFDBtnGroup.x=ruleTFTool.x=ruleTCTool.x=ruleTC1Tool.x=ruleTC2Tool.x=minPlzTool.x=400;
			
			titleImg.x = (width - titleImg.width) / 2
			titleImg.y = 5
		}
		
		/**
		 * 人数
		 */
		protected function ruleCountBtnGroupHandler(event:UIEvent):void
		{
			ruleCountBtnGroup.selectedIndex = 0;
			AppAlertSmall.show('暂不支持修改', AppAlertSmall.WARNING)
		}
		
		protected function ruleFDBtnGroupHandler(event:UIEvent):void
		{
			ruleFDBtnGroup.selectedIndex = 0;
			AppAlertSmall.show('暂不支持修改', AppAlertSmall.WARNING)
		}
		
		protected function ruleHXBtnGroupHandler(event:UIEvent):void
		{
			ruleHXBtnGroup.selectedIndex = 1;
			AppAlertSmall.show('暂不支持修改', AppAlertSmall.WARNING)
		}
		
		override protected function commitButton_clickHandler(event:MouseEvent):void {
			autoCreateRuleNameByXiFen();///根据息分自动生成玩法名。前提是用户自己不输入玩法
			
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
				tf: Number(ruleTFTool.value),
				plz:Number(minPlzTool.value)}, query: {id: ruleData.id}},  
				function (e:Event):void {
					try
					{
						var response:Object = JSON.parse(e.currentTarget.data)
						if (response.code == 0) {
							AppAlertSmall.show('更新玩法成功')
							close()
							AppManager.getInstance().dispatchEvent(new AppManagerEvent(AppManagerEvent.UPDATE_GROUP_RULES_SUCCESS));
						} else {
							AppAlertSmall.show('更新玩法失败')
						}
					} 
					catch(error:Error) 
					{
						AppAlertSmall.show('更新玩法失败')
					}
				})
		}
		
		private function autoCreateRuleNameByXiFen():void
		{
			var newName:String;
			if(Number(ruleXFTool.value)<1&&Number(ruleXFTool.value)>0){
				newName  = Number(ruleXFTool.value)*10+"毛放炮罚";
			}else{
				newName  = Number(ruleXFTool.value)+"元放炮罚";
			}
			ruleNameInput.text = newName;
		}
	}
}


