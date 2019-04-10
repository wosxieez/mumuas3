package com.xiaomu.view.room
{
	import coco.component.Label;
	import coco.component.TextAlign;
	import coco.core.UIComponent;
	
	public class NiaoFenViewInEndResult extends UIComponent
	{
		public function NiaoFenViewInEndResult()
		{
			super();
		}
		
		private var _data:Object;

		public function get data():Object
		{
			return _data;
		}

		public function set data(value:Object):void
		{
			_data = value;
			invalidateProperties();
		}
		
		private var niaoFenLab:Label;
		private var ruleNameLab:Label;
		override protected function createChildren():void
		{
			super.createChildren();
			
			niaoFenLab = new Label();
			niaoFenLab.fontSize = 24;
			niaoFenLab.height = 30;
			niaoFenLab.textAlign = TextAlign.LEFT;
			niaoFenLab.color = 0xfffff0;
			addChild(niaoFenLab);
			
			ruleNameLab = new Label();
			ruleNameLab.fontSize = 24;
			ruleNameLab.height = 30;
			ruleNameLab.textAlign = TextAlign.LEFT;
			ruleNameLab.color = 0xfffff0;
			addChild(ruleNameLab);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			niaoFenLab.width = ruleNameLab.width = width;
			niaoFenLab.x = 10;
			niaoFenLab.y = 10;
			
			ruleNameLab.x = 10;
			ruleNameLab.y = niaoFenLab.y+niaoFenLab.height+10;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			trace('niaofen:',JSON.stringify(data));
			if(data){
				niaoFenLab.text = data.nf==0?"不打鸟":"打鸟"+data.nf+"分";
				ruleNameLab.text = "游戏："+data.rulename;
			}
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.lineStyle(2,0xffffff0);
			graphics.drawRoundRect(0,0,width,height,10,10);
			graphics.endFill();
		}
	}
}