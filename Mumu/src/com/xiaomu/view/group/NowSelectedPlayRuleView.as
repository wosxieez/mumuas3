package com.xiaomu.view.group
{
	import com.xiaomu.util.AppData;
	
	import coco.component.Image;
	import coco.component.TextArea;
	import coco.core.UIComponent;
	
	/**
	 * 当前选中的玩法界面
	 */
	public class NowSelectedPlayRuleView extends UIComponent
	{
		public function NowSelectedPlayRuleView()
		{
			super();
			width = 453;
			height = 100-10;
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
		
		private var bgImg:Image;
		private var ruleArea:TextArea;
		override protected function createChildren():void
		{
			super.createChildren();
			
			bgImg = new Image();
			bgImg.source = 'assets/guild/guild2_diban2.png';
			addChild(bgImg);
			
			ruleArea = new TextArea();
			ruleArea.backgroundAlpha = 0;
			ruleArea.borderAlpha = 0;
			ruleArea.editable = false;
			ruleArea.color = 0xffffff;
			ruleArea.fontSize = 18;
			ruleArea.leading = 8;
			addChild(ruleArea);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(data){
				var ruleNameStr:String = data.rulename+"\r";
				var peopleNumbeStr :String=data.cc==2?"二人，":(data.cc==3?"三人，":"四人，");
				var huxiNumberStr:String = data.hx+"胡息起胡，";
				var daNiaoNumberStr :String= data.nf==0?"不打鸟，":"打鸟"+data.nf+"分，";
				var fenDingNumberStr:String = data.fd+"胡息封顶，";
				var timesNumberStr :String= data.nf==0?"不翻倍":"翻"+data.nf+"倍";
				ruleArea.text = ruleNameStr+peopleNumbeStr+huxiNumberStr+daNiaoNumberStr+fenDingNumberStr+timesNumberStr;
			}else{
				ruleArea.text='无';
			}
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			bgImg.width = width;
			bgImg.height = height;
			
			ruleArea.width = bgImg.width-20;
			ruleArea.height = bgImg.height;
			ruleArea.x = (width-ruleArea.width)/2;
			ruleArea.y = (height-ruleArea.height)/2;
		}
	}
}