package com.xiaomu.view.group
{
	import com.xiaomu.component.AppPanel;
	import com.xiaomu.component.TitleTextInput;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Alert;
	import coco.layout.VerticalLayout;
	
	public class AddRulePanel extends AppPanel
	{
		public function AddRulePanel()
		{
			super();
			
			title = '添加玩法'
			var vl:VerticalLayout = new VerticalLayout()
			layout = vl
		}
		
		private var ruleNameInput:TitleTextInput
		private var ruleCountInput:TitleTextInput
		
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
		}
		
		override protected function commitButton_clickHandler(event:MouseEvent):void {
			HttpApi.getInstane().addRule(AppData.getInstane().group.id, ruleNameInput.text, int(ruleCountInput.text), 
				function (e:Event):void {
					try
					{
						var response:Object = JSON.parse(e.currentTarget.data)
						if (response.code == 0) {
							Alert.show('添加玩法成功')
							close()
						} else {
							Alert.show('添加玩法成功')
						}
					} 
					catch(error:Error) 
					{
						Alert.show('添加玩法成功')
					}
				})
		}
		
	}
}