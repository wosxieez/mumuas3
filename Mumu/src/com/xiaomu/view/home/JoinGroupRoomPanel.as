package com.xiaomu.view.home
{
	import com.xiaomu.component.AppPanelBig;
	import com.xiaomu.util.Api;
	import com.xiaomu.util.AppData;
	
	import flash.events.MouseEvent;
	
	import coco.component.Button;
	import coco.component.TextInput;
	
	public class JoinGroupRoomPanel extends AppPanelBig
	{
		public function JoinGroupRoomPanel()
		{
			super();
		}
		
		private var groupidInput:TextInput
		private var okButton:Button
		
		override protected function createChildren():void {
			super.createChildren()
				
			groupidInput = new TextInput()
			addChild(groupidInput)
			
			okButton = new Button()
			okButton.y = 50
			okButton.label = '确定'
			okButton.addEventListener(MouseEvent.CLICK, okButton_clickHandler)
			addChild(okButton)
		}
		
		protected function okButton_clickHandler(event:MouseEvent):void
		{
			Api.getInstane().joinGroupRoom(AppData.getInstane().user.username, groupidInput.text)
		}
		
	}
}