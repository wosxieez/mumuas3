package com.xiaomu.view.group
{
	import com.xiaomu.component.MyDropDownList;
	import com.xiaomu.renderer.PlayRuleRender;
	
	import coco.component.DropDownList;
	import coco.core.UIComponent;
	
	/**
	 * 切换玩法功能组件
	 */
	public class ChangePlayRuleView extends UIComponent
	{
		public function ChangePlayRuleView()
		{
			super();
		}
		
		private var ruleList:MyDropDownList;
		override protected function createChildren():void
		{
			ruleList = new MyDropDownList();
			ruleList.dataProvider = [1,2,3,4];
			addChild(ruleList);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			ruleList.width = width;
			ruleList.height = height;
			ruleList.list.itemRendererHeight = height;
			ruleList.list.height = 3*height;
		}
	}
}