package com.xiaomu.view.hall.popUpPanel
{
	import com.xiaomu.component.AppPanelSmall;
	
	import coco.component.TextArea;
	import coco.manager.PopUpManager;
	
	public class JoinGroupNoticePanel extends AppPanelSmall
	{
		public function JoinGroupNoticePanel()
		{
			super();
		}
		
		private static var instance:JoinGroupNoticePanel
		
		public static function getInstane(): JoinGroupNoticePanel {
			if (!instance) {
				instance = new JoinGroupNoticePanel()
			}
			
			return instance
		}
		
		private var textArea:TextArea
		
		override protected function createChildren():void {
			super.createChildren()
			
			textArea = new TextArea()
			textArea.editable = false
			textArea.backgroundAlpha = textArea.borderAlpha = 0
			textArea.text = '程序员小哥哥正在努力的开发中....请联系群主手动添加'
			textArea.color = 0x6f1614;
			addChild(textArea)
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			textArea.width = contentWidth
			textArea.height = contentHeight
		}
		
		override public function open():void {
			PopUpManager.centerPopUp(PopUpManager.addPopUp(this, null, true, false, 0x000000,0.5))
		}
	}
}