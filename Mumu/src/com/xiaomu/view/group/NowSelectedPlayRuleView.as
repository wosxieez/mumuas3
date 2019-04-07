package com.xiaomu.view.group
{
	import flash.events.MouseEvent;
	
	import coco.component.Button;
	import coco.component.Image;
	import coco.component.SkinComponent;
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
		
		protected function clickHandler(event:MouseEvent):void
		{
			new SwitchRulePanel().open()///玩法选则
		}
		
		private static var instance:NowSelectedPlayRuleView;
		
		public static function getInstance():NowSelectedPlayRuleView
		{
			if(!instance){instance = new NowSelectedPlayRuleView()}
			return instance;
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
		private var skin:SkinComponent;
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
			
			skin = new SkinComponent();
			skin.alpha = 0;
			skin.addEventListener(MouseEvent.CLICK,clickHandler);
			addChild(skin);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(data){
				var ruleNameStr:String = data.rulename+"\r";
				var peopleNumbeStr :String=data.cc==1?"一人，":(data.cc==2?"二人，":(data.cc==3?"三人，":"四人，"));
				var huxiNumberStr:String = data.hx+"胡息起胡，";
				var daNiaoNumberStr :String= data.nf==0?"不打鸟，":"打鸟"+data.nf+"分，";
				var fenDingNumberStr:String = data.fd+"胡息封顶。";
				ruleArea.text = ruleNameStr+peopleNumbeStr+huxiNumberStr+daNiaoNumberStr+fenDingNumberStr;
			}else{
				ruleArea.text='无';
			}
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			bgImg.width = width;
			bgImg.height = height;
			
			skin.width = width;
			skin.height = height;
			
			ruleArea.width = bgImg.width-20;
			ruleArea.height = bgImg.height;
			ruleArea.x = (width-ruleArea.width)/2;
			ruleArea.y = (height-ruleArea.height)/2;
		}
	}
}