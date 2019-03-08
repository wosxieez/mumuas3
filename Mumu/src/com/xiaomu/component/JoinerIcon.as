package com.xiaomu.component
{
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextAlign;
	import coco.core.UIComponent;
	
	public class JoinerIcon extends UIComponent
	{
		public function JoinerIcon()
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

		private var joinPic : Image;
		private var joinName:Label;
		override protected function createChildren():void
		{
			super.createChildren();
			
			joinPic = new Image();
			
			joinPic.source = 'assets/role/joiner_'+(int(Math.random()*3)+1)+'.png';
			addChild(joinPic);
			
			joinName = new Label();
			joinName.textAlign = TextAlign.CENTER;
			joinName.color = 0xffffff;
			addChild(joinName);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if(data){
				joinName.text = data.name;
			}
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			joinPic.width = joinPic.height = width;
			
			joinPic.x = (width-joinPic.width)/2;
			joinPic.y = 0;
			
			joinName.height = height/3+5;
			joinName.width = width*1.6;
			joinName.x = -width*0.3;
			joinName.y = joinPic.y+joinPic.height;
			joinName.fontSize = height/3;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			/*graphics.clear();
			graphics.beginFill(0x0000ff,0.2);
			graphics.drawRoundRect(0,0,width,height,5,5);
			graphics.endFill();*/
		}
		
		
	}
}