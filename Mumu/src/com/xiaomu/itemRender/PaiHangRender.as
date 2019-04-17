package com.xiaomu.itemRender
{
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	import coco.component.Label;
	
	public class PaiHangRender extends DefaultItemRenderer
	{
		public function PaiHangRender()
		{
			super();
			mouseChildren = true
			backgroundAlpha = 0;
		}
		
		private var bgImg:Image;
		private var labFen:Label;
		private var labZhiWei:Label;
		private var labName:Label;
		
		override public function set index(value:int):void {
			super.index = value
			invalidateProperties()
		}
		
		override protected function createChildren():void {
			super.createChildren()
			
			bgImg = new Image();
			bgImg.source = 'assets/guild/guild_diban02.png';
			addChild(bgImg);
			
			labName = new Label();
			labName.fontSize = 24;
			labName.color = 0x845525;
			addChild(labName);
			
			labZhiWei = new Label();
			labZhiWei.fontSize = 24;
			labZhiWei.color = 0x845525;
			addChild(labZhiWei);
			
			labFen = new Label();
			labFen.fontSize = 24;
			labFen.color = 0x845525;
			addChild(labFen);
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			if (data) {
				labZhiWei.text = data.username;
				labFen.text = data.jb
				if (index == 0) {
					labName.color = 0xFF0000
					labName.text = '状元'
				} else if (index == 1) {
					labName.color = 0xFF0000
					labName.text = '榜眼'
				} else if (index == 2) {
					labName.color = 0xFF0000
					labName.text = '探花'
				} else {
					labName.color = 0x845525
					labName.text = '进士'
				}
			}
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			bgImg.width = width;
			bgImg.height = height;
			
			labName.x = 20;
			labName.width = 200;
			labName.height = 40;
			labName.y = (height-labName.height)/2;
			
			labZhiWei.x = labName.x+labName.width+10;
			labZhiWei.width = 200;
			labZhiWei.height = 40;
			labZhiWei.y = (height-labZhiWei.height)/2;
			
			labFen.x = labZhiWei.x+labZhiWei.width+10;
			labFen.width = 200;
			labFen.height = 40;
			labFen.y = (height-labFen.height)/2;
		}
		
	}
}