package com.xiaomu.itemRender
{
	import com.xiaomu.view.group.GroupRuleMenu;
	
	import flash.events.MouseEvent;
	
	import coco.component.Button;
	import coco.component.DefaultItemRenderer;
	import coco.manager.PopUpManager;
	
	public class GroupRuleRenderer extends DefaultItemRenderer
	{
		public function GroupRuleRenderer()
		{
			super();
			mouseChildren = true
		}
		
		private var manageButton:Button
		
		override protected function createChildren():void {
			super.createChildren()
			
			manageButton = new Button()
			manageButton.label = '管理'
			manageButton.addEventListener(MouseEvent.CLICK, manageButton_clickHandler)
			addChild(manageButton)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			if (data) {
				labelDisplay.text = data.rulename + ' 人数:' + data.cc + ' 胡息:' + data.hx + 
					' 息分:' + data.xf + ' 鸟分:' + data.nf + ' 封顶:' + data.fd + ' 一级提成:' + data.tc2 + 
					' 二级提成:' + data.tc1 + ' 提成:' + data.tc + ' 提成分:' + data.tf
			}
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
				
			manageButton.height = height
			manageButton.width = height * 2
			manageButton.x = width - manageButton.width
		}
		
		protected function manageButton_clickHandler(event:MouseEvent):void
		{
			event.preventDefault()
			event.stopImmediatePropagation()
				
			GroupRuleMenu.getInstane().x = width
			GroupRuleMenu.getInstane().ruleData = data
			PopUpManager.addPopUp(GroupRuleMenu.getInstane(), this, false, true)
		}
		
	}
}