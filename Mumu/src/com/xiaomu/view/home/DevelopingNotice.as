package com.xiaomu.view.home
{
	import com.xiaomu.component.AppPanelSmall;
	
	import coco.component.TextArea;
	
	public class DevelopingNotice extends AppPanelSmall
	{
		public function DevelopingNotice()
		{
			super();
			
			title = "提示"
		}
		
		private static var instance:DevelopingNotice
		
		public static function getInstane(): DevelopingNotice {
			if (!instance) {
				instance = new DevelopingNotice()
			}
			
			return instance
		}
		
		
		private var textArea:TextArea
		
		override protected function createChildren():void {
			super.createChildren()
				
			textArea = new TextArea()
			textArea.editable = false
			textArea.backgroundAlpha = textArea.borderAlpha = 0
			textArea.text = '程序员小哥哥正在努力的开发中....'
			addChild(textArea)
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			textArea.width = contentWidth
			textArea.height = contentHeight
		}
		
	}
}