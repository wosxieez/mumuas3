package com.xiaomu.component
{
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextAlign;
	import coco.component.TextArea;
	import coco.component.TextInput;
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
		private var joinName:TextInput;
		override protected function createChildren():void
		{
			super.createChildren();
			
			joinPic = new Image();
			joinPic.width = joinPic.height = 20;
			joinPic.source = 'assets/role/joiner_'+(int(Math.random()*3)+1)+'.png';
			addChild(joinPic);
			
			joinName = new TextInput();
			joinName.editable = false;
			joinName.textAlign = TextAlign.CENTER;
			joinName.backgroundAlpha = 0;
			joinName.borderAlpha = 0;
			joinName.fontSize = 6;
			joinName.color = 0xffffff;
			addChild(joinName);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
//			trace('收到数据：',data);
			if(data){
				joinName.text = data.name;
			}
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			joinPic.x = (width-joinPic.width)/2;
			joinPic.y = 0;
			
			joinName.height = 8;
			joinName.width = width;
			joinName.x = 0;
			joinName.y = joinPic.y+joinPic.height+2;
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