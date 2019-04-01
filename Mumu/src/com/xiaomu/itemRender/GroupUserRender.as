package com.xiaomu.itemRender
{
	import com.xiaomu.view.group.GroupUserMenu;
	
	import flash.events.MouseEvent;
	
	import coco.component.Button;
	import coco.component.DefaultItemRenderer;
	import coco.manager.PopUpManager;
	
	public class GroupUserRender extends DefaultItemRenderer
	{
		public function GroupUserRender()
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
				var flag:String
				switch(data.ll)
				{
					case 4:
					{
						flag = '馆长'
						break;
					}
					case 3:
					{
						flag = '副馆长'
						break;
					}
					case 2:
					{
						flag = '一级管理员'
						break;
					}
					case 1:
					{
						flag = '二级管理员'
						break;
					}
					default:
					{
						flag = '普通成员'
						break;
					}
				}
				
				labelDisplay.text = data.username + ' 积分 ' + data.fs + ' 职位' + flag
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
				
			GroupUserMenu.getInstane().x = width
			GroupUserMenu.getInstane().targetUser = data
			PopUpManager.addPopUp(GroupUserMenu.getInstane(), this, false, true)
		}
		
	}
}