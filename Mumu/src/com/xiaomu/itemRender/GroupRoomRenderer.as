package com.xiaomu.itemRender
{
	import com.xiaomu.util.AppData;
	
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	import coco.component.Label;
	
	public class GroupRoomRenderer extends DefaultItemRenderer
	{
		public function GroupRoomRenderer()
		{
			super();
			mouseChildren = true
			backgroundAlpha=.1;
			backgroundColor = 0x000000
			radius = 10
			borderAlpha = 0;
		}
		
		private var tableImg:Image;
		private var player1:Label;
		private var player2:Label;
		private var ruleName:Label;
		
		override protected function createChildren():void {
			super.createChildren()
			
			labelDisplay.visible = false
			
			tableImg = new Image();
			addChild(tableImg);
			
			player1 = new Label();
			player1.fontSize = 22;
			player1.color = 0xffffff;
			addChild(player1);
			
			player2 = new Label();
			player2.fontSize = 22;
			player2.color = 0xffffff;
			addChild(player2);
			
			ruleName = new Label();
			ruleName.fontSize = 22;
			ruleName.color = 0xffffff;
			addChild(ruleName);
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			if (data) {
				for each (var ruleObj:Object in AppData.getInstane().allRules) 
				{
					if(ruleObj.id==data.rid){
						tableImg.source = "assets/guild/guild2_bg_table"+parseInt(ruleObj.cc)+"_phz.png"
						player1.text = data.users[0]
						player2.text = data.users[1]
						ruleName.text = ruleObj.rulename;
					}
				}
				
			}
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			tableImg.height = height*0.8;
			tableImg.width = tableImg.height*383/340;
			tableImg.x = (width-tableImg.width)/2;
			tableImg.y = (height-tableImg.height)/2;
			
			player1.width = width/2;
			player2.width = width/2;
			player1.x = width/12;
			player1.y = height/2;
			player2.x = width-player2.width-width/12;
			player2.y = height/5-20;
			
			ruleName.width = width
			ruleName.height = 40;
			ruleName.y = (height-ruleName.height)/2-40;
		}
		
	}
}