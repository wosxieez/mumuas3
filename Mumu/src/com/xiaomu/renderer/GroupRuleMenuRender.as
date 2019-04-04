package com.xiaomu.renderer
{
	import com.xiaomu.component.ImageButton;
	
	import coco.component.DefaultItemRenderer;
	
	public class GroupRuleMenuRender extends DefaultItemRenderer
	{
		public function GroupRuleMenuRender()
		{
			super();
			backgroundAlpha = 0;
			borderAlpha = 0;
		}
		
		private var btn:ImageButton;
		override protected function createChildren():void
		{
			super.createChildren();
			
			btn = new ImageButton();
			btn.width = 132;
			btn.height = 51;
			addChild(btn);
			
			labelDisplay.visible = false;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			//			lab.text = data+"";
			trace(JSON.stringify(data));
			if(data){
				btn.upImageSource="assets/guild/"+data.image+"_n.png";
				btn.downImageSource="assets/guild/"+data.image+"_p.png";
			}
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			btn.x = (width-btn.width)/2;
			btn.y = (height-btn.height)/2;
		}
	}
}