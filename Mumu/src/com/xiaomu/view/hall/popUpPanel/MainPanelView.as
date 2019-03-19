package com.xiaomu.view.hall.popUpPanel
{
	import coco.component.Image;
	import coco.component.List;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	
	public class MainPanelView extends UIComponent
	{
		public function MainPanelView()
		{
			super();
		}
		
		private var list:List
		private var bg:Image;
		override protected function createChildren():void
		{
			super.createChildren();
			
			list = new List();
			list.dataProvider = [{'name':'跑胡子','view':PhzPanel}];
			list.addEventListener(UIEvent.CHANGE,changeHandler);
			list.selectedIndex = 0;
			list.labelField = 'name'
			list.verticalScrollEnabled = false;
			addChild(list);
			
			bg = new Image();
			bg.source = 'assets/testBg.png';
			addChild(bg);
			
			addChild(PanelNavigator.getInstane());
			PanelNavigator.getInstane().pushView(list.selectedItem.view);
		}
		
		private var oldSelectIndex:int;
		protected function changeHandler(event:UIEvent):void
		{
			if(list.selectedIndex!=-1){
				oldSelectIndex = list.selectedIndex;
			}else{
				list.selectedIndex = oldSelectIndex;
				return;
			}
			PanelNavigator.getInstane().pushView(list.selectedItem.view);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			list.x = list.y = 5;
			list.width = 100;
			list.height = height-10;
			PanelNavigator.getInstane().x = list.x+list.width+5;
			PanelNavigator.getInstane().y = list.y;
			PanelNavigator.getInstane().width = width-PanelNavigator.getInstane().x-5;
			PanelNavigator.getInstane().height = height-2*PanelNavigator.getInstane().y;
			bg.x = PanelNavigator.getInstane().x;
			bg.y = PanelNavigator.getInstane().y;
			bg.width = PanelNavigator.getInstane().width;
			bg.height = PanelNavigator.getInstane().height;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xFFFF99);
			graphics.drawRect(0,0,PanelNavigator.getInstane().x,height);
			graphics.endFill();
			
			graphics.beginFill(0xFF9999);
			graphics.drawRect(PanelNavigator.getInstane().x,0,width-PanelNavigator.getInstane().x,height);
			graphics.endFill();
		}
	}
}