package com.xiaomu.view.room
{
	import com.xiaomu.component.ImageButton;
	
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
			addChild(bdnButton)
			
			dnButton = new ImageButton()
			dnButton.width = 226
			dnButton.height = 97
			dnButton.upImageSource = 'assets/room/btn_dn_normal.png'
			dnButton.downImageSource = 'assets/room/btn_dn_press.png'
			addChild(dnButton)
		}
		
		public function open():void {
			PopUpManager.centerPopUp(PopUpManager.addPopUp(this, null, true))
		}
		
		public function close():void {
			PopUpManager.removePopUp(this)
		}
		
	}
}