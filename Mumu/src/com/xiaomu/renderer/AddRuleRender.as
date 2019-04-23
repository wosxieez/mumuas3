package com.xiaomu.renderer
{
	import coco.component.Image;
	import coco.component.ItemRenderer;
	import coco.component.Label;
	import coco.component.TextAlign;
	
	public class AddRuleRender extends ItemRenderer
	{
		public function AddRuleRender()
		{
			super();
			backgroundAlpha = 0;
			borderAlpha = 0;
		}
		
		private var statusImg:Image;
		private var lab:Label;
		private var _selected:Boolean;

		override public function get selected():Boolean
		{
			return _selected;
		}

		override public function set selected(value:Boolean):void
		{
			_selected = value;
			invalidateProperties();
		}

		override protected function createChildren():void
		{
			super.createChildren();
			
			statusImg = new Image();
			addChild(statusImg);
			
			lab = new Label();
			lab.fontSize = 20;
			lab.textAlign = TextAlign.LEFT;
			lab.color = 0x6f1614;
			addChild(lab);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			statusImg.source = "assets/component/"+(selected?"yuanxuan2.png":"yuanwei1.png");
			lab.text = data.name;
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			statusImg.height = height*0.7;
			statusImg.width = (130/42)*statusImg.height;
			
			lab.x = statusImg.height+5;
			lab.height = height
		}
	}
}