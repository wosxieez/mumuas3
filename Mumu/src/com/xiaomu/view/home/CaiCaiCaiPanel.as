package com.xiaomu.view.home
{
	import com.xiaomu.component.AppPanel;
	import com.xiaomu.component.Ball;
	
	import coco.component.HorizontalAlign;
	import coco.component.VerticalAlign;
	import coco.layout.HorizontalLayout;
	
	public class CaiCaiCaiPanel extends AppPanel
	{
		public function CaiCaiCaiPanel()
		{
			super();
			
			title = '猜猜猜'
			
			var hl:HorizontalLayout = new HorizontalLayout()
			hl.horizontalAlign = HorizontalAlign.CENTER
			hl.verticalAlign = VerticalAlign.MIDDLE
			hl.gap = 20
			layout = hl
		}
		
		private var ball1:Ball
		private var ball2:Ball
		private var ball3:Ball
		private var ball4:Ball
		private var ball5:Ball
		private var ball6:Ball
		
		override protected function createChildren():void {
			super.createChildren()
				
			titleDisplay.color = 0x6f1614
			titleDisplay.fontSize = 24
				
			ball1 = new Ball()
			ball1.text = '1'
			addChild(ball1)
			
			ball2 = new Ball()
			ball2.text = '2'
			addChild(ball2)
			
			ball3 = new Ball()
			ball3.text = '3'
			addChild(ball3)
			
			ball4 = new Ball()
			ball4.text = '4'
			addChild(ball4)
			
			ball5 = new Ball()
			ball5.text = '5'
			addChild(ball5)
			
			ball6 = new Ball()
			ball6.text = '6'
			ball6.backgroundColor = 0x0000FF
			addChild(ball6)
		}
		
	}
}