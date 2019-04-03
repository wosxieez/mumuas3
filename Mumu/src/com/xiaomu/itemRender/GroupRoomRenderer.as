package com.xiaomu.itemRender
{
	import com.xiaomu.util.AppData;
	
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextAlign;
	
	public class GroupRoomRenderer extends DefaultItemRenderer
	{
		public function GroupRoomRenderer()
		{
			super();
			mouseChildren = true
			backgroundAlpha=0.1;
			borderAlpha = 0.2;
		}
		
		private var tableImg:Image;
		private var player1:Label;
		private var player2:Label;
		override protected function createChildren():void {
			super.createChildren()
			
			tableImg = new Image();
			addChild(tableImg);
			
			player1 = new Label();
			
			player1.fontSize = 24;
			player1.color = 0xffffff;
			addChild(player1);
			
			player2 = new Label();
			player2.fontSize = 24;
			player2.color = 0xffffff;
			addChild(player2);
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			if (data) {
				labelDisplay.text = JSON.stringify(data)
				labelDisplay.visible =false;
//				trace("数据：：",JSON.stringify(data));// {"users":["wosxieez4","xiebao"],"name":"room878234","rid":1}
//				trace("玩法：",JSON.stringify(AppData.getInstane().allRules));
				for each (var ruleObj:Object in AppData.getInstane().allRules) 
				{
					if(ruleObj.id==data.rid){
//						trace("人数：",ruleObj.cc);
						tableImg.source = "assets/guild/guild2_bg_table"+parseInt(ruleObj.cc)+"_phz.png"
						player1.text = data.users[0]
						player2.text = data.users[1]
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
			player2.y = height/5;
		}
		
	}
}