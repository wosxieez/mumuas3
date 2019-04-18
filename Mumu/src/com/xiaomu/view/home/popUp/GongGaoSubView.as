package com.xiaomu.view.home.popUp
{
	import coco.component.Button;
	import coco.component.TextArea;
	import coco.core.UIComponent;
	
	/**
	 * 公告内容界面。纯文字内容。非图片内容
	 */
	public class GongGaoSubView extends UIComponent
	{
		public function GongGaoSubView()
		{
			super();
		}
		private var contentText:String = '	如今，因为工作同“一带一路”建设的紧密联系，我几乎每年都要访问中国几次。我看到中国年轻人的脸庞上都洋溢着自信。我相信，中巴经济走廊将不断推进巴基斯坦向前发展，巴基斯坦的年轻人也会迎来更美好的未来。\r\n	对巴基斯坦人民来说，中国是我们最亲密的伙伴之一。两国山水相依，在许多领域都有着密切的交流合作。如今，作为“一带一路”建设的旗舰项目——中巴经济走廊正不断推动巴基斯坦的经济和社会发展。';
		private var contentArea:TextArea;
		private var button:Button;
		override protected function createChildren():void
		{
			contentArea = new TextArea();
			contentArea.text = contentText;
			contentArea.editable = false;
			contentArea.width = width;
			contentArea.height = height;
			contentArea.backgroundAlpha = 0;
			contentArea.borderAlpha = 0;
			contentArea.leading = 10;
			contentArea.color = 0x6f1614;
			contentArea.fontSize = 24;
			addChild(contentArea);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			contentArea.width = width;
			contentArea.height = height;
		}
		
		/*override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xfff000);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}*/
	}
}