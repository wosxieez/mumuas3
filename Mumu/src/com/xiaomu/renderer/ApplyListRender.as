package com.xiaomu.renderer
{
	import com.xiaomu.component.ImageButton;
	import com.xiaomu.view.group.GroupApplyMenu;
	
	import flash.events.MouseEvent;
	
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextAlign;
	import coco.manager.PopUpManager;
	
	public class ApplyListRender extends DefaultItemRenderer
	{
		public function ApplyListRender()
		{
			super();
			autoDrawSkin = false;
			borderAlpha = 0;
			mouseChildren = true;
		}
		
		private var bgImg:Image;
		private var nameLab:Label;
		private var timeLab:Label;
		private var otherLab:Label;
		private var manageButton:ImageButton
		override protected function createChildren():void
		{
			super.createChildren();
			
			labelDisplay.visible = false;
			
			bgImg = new Image();
			bgImg.source = 'assets/guild/guild_diban02.png';
			addChild(bgImg);
			
			timeLab =  new Label();
			timeLab.fontSize = 24;
			timeLab.width = 250;
			timeLab.height = 40;
			timeLab.color = 0x845525;
			timeLab.textAlign = TextAlign.LEFT;
			addChild(timeLab);
			
			nameLab =  new Label();
			nameLab.fontSize = 24;
			nameLab.width = 300;
			nameLab.height = 40;
			nameLab.color = 0x845525;
			nameLab.textAlign = TextAlign.LEFT;
			addChild(nameLab);
			
			otherLab =  new Label();
			otherLab.fontSize = 24;
			otherLab.width = 120;
			otherLab.height = 40;
			otherLab.color = 0x845525;
			otherLab.text = '申请入群';
			otherLab.textAlign = TextAlign.RIGHT;
			addChild(otherLab);
			
			manageButton = new ImageButton()
			manageButton.upImageSource = 'assets/guild/btn_guild_manager_n.png';
			manageButton.downImageSource = 'assets/guild/btn_guild_manager_p.png';
			manageButton.addEventListener(MouseEvent.CLICK, manageButton_clickHandler)
			addChild(manageButton)
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			bgImg.width = width;
			bgImg.height = height;
			
			timeLab.x = 20;
			timeLab.y = (height-timeLab.height)/2;
			
			nameLab.x = timeLab.x+timeLab.width+10;
			nameLab.y = timeLab.y;
			
			otherLab.x = nameLab.x+nameLab.width;
			otherLab.y = nameLab.y;
			
			manageButton.height =  51
			manageButton.width = 132
			manageButton.x = width-manageButton.width-20;
			manageButton.y = (height-manageButton.height)/2;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if(data){
				timeLab.text = data.newDate
				nameLab.text = "账号: "+data.uname;
			}
		}
		
		protected function manageButton_clickHandler(event:MouseEvent):void
		{
			event.preventDefault()
			event.stopImmediatePropagation()
			
			GroupApplyMenu.getInstane().x = width
			GroupApplyMenu.getInstane().applyData = data
			PopUpManager.addPopUp(GroupApplyMenu.getInstane(), this, false, true)
		}
	}
}