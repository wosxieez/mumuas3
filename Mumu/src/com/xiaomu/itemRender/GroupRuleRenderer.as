package com.xiaomu.itemRender
{
	import com.xiaomu.component.ImageButton;
	import com.xiaomu.view.group.GroupRuleMenu;
	
	import flash.events.MouseEvent;
	
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	import coco.component.TextArea;
	import coco.manager.PopUpManager;
	
	public class GroupRuleRenderer extends DefaultItemRenderer
	{
		public function GroupRuleRenderer()
		{
			super();
			mouseChildren = true
			backgroundAlpha = 0;
		}
		
		private var bgImg:Image;
		private var lab:TextArea;
		private var manageButton:ImageButton
		
		override protected function createChildren():void {
			super.createChildren()
			
			bgImg = new Image();
			bgImg.source = 'assets/guild/guild_diban02.png';
			addChild(bgImg);
			
			lab = new TextArea();
			lab.borderAlpha = lab.backgroundAlpha = 0;
			lab.fontSize = 24;
			lab.editable = false;
			lab.color = 0x845525;
			lab.leading = 5;
			addChild(lab);
			
			manageButton = new ImageButton()
			manageButton.upImageSource = 'assets/guild/btn_guild_manager_n.png';
			manageButton.downImageSource = 'assets/guild/btn_guild_manager_p.png';
			manageButton.addEventListener(MouseEvent.CLICK, manageButton_clickHandler)
			addChild(manageButton)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			if (data) {
				lab.text = '玩法名:'+data.rulename + '。人数:' + data.cc + ', 胡息:' + data.hx + 
					', 息分:' + data.xf + ', 鸟分:' + data.nf + ', 封顶:' + data.fd  + ', 提成线:' + data.tf + ', 提成值:' + data.tc+ ', 一级提成:' + data.tc2 + 
					', 二级提成:' + data.tc1+',最低疲劳值:'+(data.plz?data.plz:0);
			}
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			bgImg.width = width;
			bgImg.height = height;
			
			lab.width = width-200;
			lab.height = height;
			lab.x = 20;
			lab.y = (height-lab.height)/2;
			
			manageButton.height =  51
			manageButton.width = 132
			manageButton.x = width - manageButton.width-20
			manageButton.y = ( height-manageButton.height)/2;
		}
		
		protected function manageButton_clickHandler(event:MouseEvent):void
		{
			event.preventDefault()
			event.stopImmediatePropagation()
			
			GroupRuleMenu.getInstane().x = width
			GroupRuleMenu.getInstane().ruleData = data
			PopUpManager.addPopUp(GroupRuleMenu.getInstane(), this, false, true)
		}
		
	}
}