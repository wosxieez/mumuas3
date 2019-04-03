package com.xiaomu.view.room
{
	import com.xiaomu.component.ImageButton;
	import com.xiaomu.util.Actions;
	import com.xiaomu.util.Api;
	
	import flash.events.MouseEvent;
	
	import coco.component.HGroup;
	import coco.component.HorizontalAlign;
	import coco.component.VerticalAlign;
	import coco.manager.PopUpManager;
	
	public class DaNiaoNoticePanel extends HGroup
	{
		public function DaNiaoNoticePanel()
		{
			super();
			width = 600
			height = 100
			gap = 40
			verticalAlign = VerticalAlign.MIDDLE
			horizontalAlign = HorizontalAlign.CENTER
		}
		
		private var bdnButton:ImageButton
		private var dnButton:ImageButton
		
		override protected function createChildren():void {
			super.createChildren()
			
			bdnButton = new ImageButton()
			bdnButton.width = 226
			bdnButton.height = 97
			bdnButton.upImageSource = 'assets/room/btn_bdn_normal.png'
			bdnButton.downImageSource = 'assets/room/btn_bdn_press.png'
			bdnButton.addEventListener(MouseEvent.CLICK, bdnButton_clickHandler)
			addChild(bdnButton)
			
			dnButton = new ImageButton()
			dnButton.width = 226
			dnButton.height = 97
			dnButton.upImageSource = 'assets/room/btn_dn_normal.png'
			dnButton.downImageSource = 'assets/room/btn_dn_press.png'
			dnButton.addEventListener(MouseEvent.CLICK, dnButton_clickHandler)
			addChild(dnButton)
		}
		
		protected function bdnButton_clickHandler(event:MouseEvent):void
		{
			var action:Object = { name: Actions.Dn, data: false }
			Api.getInstane().sendAction(action)
			close()
		}
		
		protected function dnButton_clickHandler(event:MouseEvent):void
		{
			var action:Object = { name: Actions.Dn, data: true }
			Api.getInstane().sendAction(action)
			close()
		}
		
		public function open():void {
			PopUpManager.centerPopUp(PopUpManager.addPopUp(this, null, true))
		}
		
		public function close():void {
			PopUpManager.removePopUp(this)
		}
		
	}
}