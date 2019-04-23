package com.xiaomu.renderer
{
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextAlign;
	
	public class RuleListRender extends DefaultItemRenderer
	{
		public function RuleListRender()
		{
			super();
			autoDrawSkin = false;
		}
		
		private var lab1:Label;
		private var lab2:Label;
		private var xianimg:Image;
		override protected function createChildren():void
		{
			super.createChildren();
			
			labelDisplay.visible = false;
			
			lab1 = new Label();
			lab1.textAlign = TextAlign.LEFT;
			lab1.fontSize = 19;
			lab1.color = 0xAB8632;
			addChild(lab1);
			
			lab2 = new Label();
			lab2.textAlign = TextAlign.LEFT;
			lab2.fontSize = 19;
			lab2.color = 0xFFFFFF;
			addChild(lab2);
			
			xianimg = new Image();
			xianimg.source = 'assets/room/xian_wanfa.png';
			addChild(xianimg);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			lab1.height = height;
			lab1.width = 60;
			lab1.x = 10;
			lab1.y = (height-lab1.height)/2
				
			lab2.height = height;
			lab2.width = 140;
			lab2.x = lab1.x+lab1.width;
			lab2.y = (height-lab1.height)/2
				
			xianimg.x = 10;
			xianimg.y = height-5;
			xianimg.width = width-20;
			xianimg.height = 2;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if(data){
				switch(data.name)
				{
					case 'xf':
					{
						lab1.text = '息分:'
						lab2.text = data.value+"分";
						break;
					}
					case 'nf':
					{
						lab1.text = '打鸟:'
						lab2.text = '打鸟'+data.value+"分";
						break;
					}
					case 'cc':
					{
						lab1.text = '人数:'
						lab2.text = data.value+"人精简";
						break;
					}
					case 'rulename':
					{
						lab1.text = '名称:'
						lab2.text = data.value;
						break;
					}
					case 'fd':
					{
						lab1.text = '封顶:'
						lab2.text = data.value+"息";
						break;
					}
					case 'hx':
					{
						lab1.text = '起胡:'
						lab2.text = data.value+"胡起胡";
						break;
					}
						
					default:
					{
						break;
					}
				}
				
			}
		}
	}
}