package com.xiaomu.renderer
{
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	
	public class CardGroupRender extends DefaultItemRenderer
	{
		public function CardGroupRender()
		{
			super();
			backgroundAlpha =0;
			borderAlpha = 0;
		}
		
		private var typeIcon:Image;
		private var cardIcon1:Image;
		private var cardIcon2:Image;
		private var cardIcon3:Image;
		private var cardIcon4:Image;
		override protected function createChildren():void
		{
			super.createChildren();
			
			typeIcon = new Image();
			addChild(typeIcon);
			
			cardIcon4 = new Image();
			addChild(cardIcon4);
			
			cardIcon3 = new Image();
			addChild(cardIcon3);
			
			cardIcon2 = new Image();
			addChild(cardIcon2);
			
			cardIcon1 = new Image();
			addChild(cardIcon1);
		}
		
		override protected function commitProperties():void
		{
			super.createChildren();
			
			if(data){
				typeIcon.source = "assets/cards/type_"+data.name+".png";
				if(data.name=='pao'){
					cardIcon4.visible = true;
					cardIcon4.source = 'assets/cards/Card_half_'+data.cards[3]+".png"
					cardIcon3.source = 'assets/cards/Card_half_'+data.cards[2]+".png"
					cardIcon2.source = 'assets/cards/Card_half_'+data.cards[1]+".png"
					cardIcon1.source = 'assets/cards/Card_half_'+data.cards[0]+".png"
				}else if(data.name=='ti') {
					cardIcon4.visible = true;
					cardIcon4.source = 'assets/cards/Card_half_'+data.cards[3]+".png"
					cardIcon3.source = 'assets/cards/Card_half_'+"back_blue"+".png"
					cardIcon2.source = 'assets/cards/Card_half_'+"back_blue"+".png"
					cardIcon1.source = 'assets/cards/Card_half_'+"back_blue"+".png"
				}else if(data.name=='wei'){
					cardIcon4.visible = false;
					cardIcon3.source = 'assets/cards/Card_half_'+data.cards[2]+".png"
					cardIcon2.source = 'assets/cards/Card_half_'+"back_blue"+".png"
					cardIcon1.source = 'assets/cards/Card_half_'+"back_blue"+".png"
				}else if(data.name=='jiang'){
					cardIcon4.visible = false;
					cardIcon3.visible = false;
					cardIcon2.source = 'assets/cards/Card_half_'+data.cards[1]+".png"
					cardIcon1.source = 'assets/cards/Card_half_'+data.cards[0]+".png"
				}else if(data.name=='peng'||data.name=='chi'||data.name=='kan'){
					cardIcon4.visible = false;
					cardIcon3.source = 'assets/cards/Card_half_'+data.cards[2]+".png"
					cardIcon2.source = 'assets/cards/Card_half_'+data.cards[1]+".png"
					cardIcon1.source = 'assets/cards/Card_half_'+data.cards[0]+".png"
				}else{
					if(data.cards.length==3){
						cardIcon4.visible = false;
						cardIcon3.source = 'assets/cards/Card_half_'+data.cards[2]+".png"
						cardIcon2.source = 'assets/cards/Card_half_'+data.cards[1]+".png"
						cardIcon1.source = 'assets/cards/Card_half_'+data.cards[0]+".png"
					}else if(data.cards.length==2){
						cardIcon4.visible = false;
						cardIcon3.visible = false;
						cardIcon2.source = 'assets/cards/Card_half_'+data.cards[1]+".png"
						cardIcon1.source = 'assets/cards/Card_half_'+data.cards[0]+".png"
					}
				}
			}
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			typeIcon.x = typeIcon.y = 0;
			typeIcon.width = width;
			typeIcon.height = height;
			
			cardIcon1.width = cardIcon2.width = cardIcon3.width =cardIcon4.width =  width;
			cardIcon1.height = cardIcon2.height = cardIcon3.height =cardIcon4.height =  height;
			
			cardIcon4.x = 0;
			cardIcon4.y = typeIcon.y+typeIcon.height+10;
			
			cardIcon3.x = 0;
			cardIcon3.y = cardIcon4.y+cardIcon4.height-2;
			
			cardIcon2.x = 0;
			cardIcon2.y = cardIcon3.y+cardIcon3.height-2;
			
			cardIcon1.x = 0;
			cardIcon1.y = cardIcon2.y+cardIcon2.height-2;
		}
	}
}