package com.xiaomu.view.group
{
	import com.xiaomu.component.AppPanelBig;
	import com.xiaomu.component.TitleTextInput;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Alert;
	import coco.layout.VerticalLayout;
	
	public class SettingRulePanel extends AppPanelBig
	{
		public function SettingRulePanel()
		{
			super();
			
			title = '玩法设置'
			var vl:VerticalLayout = new VerticalLayout()
			layout = vl
		}
		
		private var ruleNameInput:TitleTextInput
		private var ruleCountInput:TitleTextInput
		private var ruleHXInput:TitleTextInput
		private var ruleXFInput:TitleTextInput
		private var ruleNFInput:TitleTextInput
		private var ruleFDInput:TitleTextInput
		private var ruleTFInput:TitleTextInput
		private var ruleTCInput:TitleTextInput
		private var ruleTC2Input:TitleTextInput
		private var ruleTC1Input:TitleTextInput
		
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
			
			ruleNameInput = new TitleTextInput()
			ruleNameInput.width = 500
			ruleNameInput.title = '玩法名称'
			addChild(ruleNameInput)
			
			ruleCountInput = new TitleTextInput()
			ruleCountInput.title = '人数'
			ruleCountInput.width = 500
			addChild(ruleCountInput)
			
			ruleHXInput = new TitleTextInput()
			ruleHXInput.title = '胡息'
			ruleHXInput.width = 500
			addChild(ruleHXInput)
			
			ruleXFInput = new TitleTextInput()
			ruleXFInput.title = '息分'
			ruleXFInput.width = 500
			addChild(ruleXFInput)
			
			ruleNFInput = new TitleTextInput()
			ruleNFInput.title = '鸟分'
			ruleNFInput.width = 500
			addChild(ruleNFInput)
			
			ruleFDInput = new TitleTextInput()
			ruleFDInput.title = '封顶'
			ruleFDInput.width = 500
			addChild(ruleFDInput)
			
			ruleTFInput = new TitleTextInput()
			ruleTFInput.title = '提成分'
			ruleTFInput.width = 500
			addChild(ruleTFInput)
			
			ruleTCInput = new TitleTextInput()
			ruleTCInput.title = '提成'
			ruleTCInput.width = 500
			addChild(ruleTCInput)
			
			ruleTC2Input = new TitleTextInput()
			ruleTC2Input.title = '一级管理员提成'
			ruleTC2Input.width = 500
			addChild(ruleTC2Input)
			
			ruleTC1Input = new TitleTextInput()
			ruleTC1Input.title = '二级管理员提成'
			ruleTC1Input.width = 500
			addChild(ruleTC1Input)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			ruleNameInput.text = ruleData.rulename
			ruleCountInput.text = ruleData.cc
			ruleHXInput.text = ruleData.hx
			ruleXFInput.text = ruleData.xf
			ruleNFInput.text = ruleData.nf
			ruleFDInput.text = ruleData.fd
			ruleTFInput.text = ruleData.tf
			ruleTCInput.text = ruleData.tc
			ruleTC2Input.text = ruleData.tc2
			ruleTC1Input.text = ruleData.tc1
		}
		
		override protected function commitButton_clickHandler(event:MouseEvent):void {
			HttpApi.getInstane().updateRule({update: {
				rulename: ruleNameInput.text,
				cc: int(ruleCountInput.text),
				hx: int(ruleHXInput.text),
				xf: Number(ruleXFInput.text),
				nf: Number(ruleNFInput.text),
				fd: Number(ruleFDInput.text),
				tc2: Number(ruleTC2Input.text),
				tc1: Number(ruleTC1Input.text),
				tc: Number(ruleTCInput.text),
				tf: Number(ruleTFInput.text)}, query: {id: ruleData.id}},  
				function (e:Event):void {
					try
					{
						var response:Object = JSON.parse(e.currentTarget.data)
						if (response.code == 0) {
							Alert.show('更新玩法成功')
							close()
						} else {
							Alert.show('更新玩法失败')
						}
					} 
					catch(error:Error) 
					{
						Alert.show('更新玩法失败')
					}
				})
		}
		
	}
}