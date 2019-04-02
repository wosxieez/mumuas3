package com.xiaomu.renderer
{
	import com.xiaomu.component.ImageButton;
	import com.xiaomu.util.AppData;
	
	import flash.events.MouseEvent;
	
	import coco.component.Image;
	import coco.component.ItemRenderer;
	import coco.component.Label;
	import coco.component.TextArea;
	import coco.manager.PopUpManager;
	
	public class RulesListRender extends ItemRenderer
	{
		public function RulesListRender()
		{
			super();
			backgroundAlpha = 0;
			mouseChildren = true;
		}
		
		private var bgImg:Image;
		private var selectBtn:ImageButton
		private var selectedLab:Label;
		private var ruleName:Label;
		private var ruleDetail:TextArea;
		private var peopleNumbeStr:String;//人数
		private var timesNumberStr:String; //倍数（翻倍）
		private var huxiNumberStr:String; //胡息
		private var fenDingNumberStr:String;//封顶
		private var daNiaoNumberStr:String;//打鸟
		override protected function createChildren():void
		{
			super.createChildren();
			
			bgImg = new Image();
			bgImg.source = 'assets/guild/guild_diban08.png';
			addChild(bgImg);
			
			selectedLab = new Label();
			selectedLab.width = 132;
			selectedLab.height = 51;
			selectedLab.text = '已选择';
			selectedLab.fontSize = 24;
			selectedLab.color = 0x00CC33;
			addChild(selectedLab);
			
			selectBtn = new ImageButton();
			selectBtn.upImageSource = 'assets/guild/btn_guild_select_n.png';
			selectBtn.downImageSource = 'assets/guild/btn_guild_select_p.png';
			selectBtn.width = 132;
			selectBtn.height = 51;
			selectBtn.addEventListener(MouseEvent.CLICK,selectBtnHandler);
			addChild(selectBtn);
			
			ruleName = new Label();
			ruleName.fontSize = 24;
			ruleName.height = 32;
			ruleName.color = 0x845525;
			addChild(ruleName);
			
			ruleDetail = new TextArea();
			ruleDetail.editable = false;
			ruleDetail.fontSize = 15;
			ruleDetail.leading = 5;
			ruleDetail.color = 0x845525;
			ruleDetail.backgroundAlpha = 0;
			ruleDetail.borderAlpha = 0;
			addChild(ruleDetail);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			ruleName.text = data.rulename;
			try
			{
				peopleNumbeStr =data.cc==2?"二人，":(data.cc==3?"三人，":"四人，");
				huxiNumberStr = data.hx+"胡息起胡，";
				daNiaoNumberStr = data.nf==0?"不打鸟，":"打鸟"+data.nf+"分，";
				fenDingNumberStr = data.fd+"胡息封顶，";
				timesNumberStr = data.nf==0?"不翻倍，":"翻"+data.nf+"倍";
			} 
			catch(error:Error) 
			{
				
			}
			ruleDetail.text = peopleNumbeStr+huxiNumberStr+daNiaoNumberStr+fenDingNumberStr+timesNumberStr;
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			bgImg.width = width;
			bgImg.height = height;
			
			selectBtn.x = width-selectBtn.width-15;
			selectBtn.y = (height-selectBtn.height)/2;
			
			selectedLab.x = selectBtn.x ;
			selectedLab.y = selectBtn.y;
			
			ruleName.x = 10;
			ruleName.y = (height-ruleName.height)/2;
			
			ruleDetail.width = width*0.55;
			ruleDetail.height = height*0.7;
			ruleDetail.x = selectBtn.x-ruleDetail.width-20;
			ruleDetail.y = (height-ruleDetail.height)/2
				
			if(AppData.getInstane().rule.id==data.id){
				selectBtn.visible = false;
				selectedLab.visible = true;
			}else{
				selectBtn.visible = true;
				selectedLab.visible = false;
			}
		}
		
		protected function selectBtnHandler(event:MouseEvent):void
		{
			AppData.getInstane().rule = data as Object
			PopUpManager.removePopUp(this.parent.parent.parent.parent.parent)///关闭玩法界面
		}
	}
}