package com.xiaomu.renderer
{
	import com.xiaomu.component.JoinerIcon;
	
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextAlign;
	import coco.component.TextInput;
	
	public class RoomRenderer extends DefaultItemRenderer
	{
		public function RoomRenderer()
		{
			super();
			autoDrawSkin = false;
		}
		
		private var _data:Object;
		
		override public function get data():Object
		{
			return _data;
		}
		
		override public function set data(value:Object):void
		{
			_data = value;
			invalidateDisplayList();
			invalidateProperties();
		}
		
		
		private var tableImg : Image;
		private var user:Label;
		private var joiner1 : JoinerIcon
		private var joiner2 : JoinerIcon
		private var joiner3 : JoinerIcon
		private var roomName : TextInput;
		private var counter:Label;
		override protected function createChildren():void
		{
			super.createChildren();
			
			tableImg = new Image();
			tableImg.source = 'assets/room/table.png';
			addChild(tableImg);
			
			roomName = new TextInput();
			roomName.editable = false;
			roomName.backgroundAlpha = 0;
			roomName.borderAlpha = 0;
			roomName.textAlign = TextAlign.CENTER;
			roomName.color = 0xffffff;
			
			addChild(roomName);
			
			joiner1 = new JoinerIcon();
			addChild(joiner1);
			
			joiner2 = new JoinerIcon();
			addChild(joiner2);
			
			joiner3 = new JoinerIcon();
			addChild(joiner3);
			
			counter = new Label();
			counter.color = 0xffffff;
			addChild(counter);
			
			labelDisplay.visible = false;
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			joiner1.visible = joiner2.visible = joiner3.visible = false;
			roomName.width = width/4;
			roomName.height = height/12;
			roomName.fontSize = height/12;
			tableImg.width = width/3;
			tableImg.height = height/3;
			joiner1.width = joiner2.width = joiner3.width=
				joiner1.height = joiner2.height = joiner3.height = height*2/11;
			
			if(data){
				counter.text = data.count+'人桌';
				//				trace(JSON.stringify(data))
				tableImg.x = (width-tableImg.width)/2;
				tableImg.y = (height-tableImg.height)/2
				
				joiner1.x = width/15
				joiner1.y = (height-joiner1.height)/2
				
				joiner2.x = width-joiner2.width-width/15;
				joiner2.y = (height-joiner2.height)/2
				
				joiner3.x = (width-joiner3.width)/2;
				joiner3.y = height/15;
			}
			
			counter.width = width;
			counter.height = 14;
			counter.fontSize = 10;
			counter.y = tableImg.y+(tableImg.height-counter.height)/2
			
			roomName.width = width;
			roomName.x = 0;
			roomName.y = height-height/15-roomName.height;
			roomName.text = data.name
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if (data)
			{
				if(data.users){
//					trace('data.users::',data.users);
					for (var k:int = 0; k < [joiner1,joiner2,joiner3].length; k++) 
					{
						var dataObj : Object =  {'name':data.users[k]}
						JoinerIcon([joiner1,joiner2,joiner3][k]).data = dataObj;
					}
					if(data.users.length==1){
						joiner1.visible = true;
						joiner2.visible = false;
						joiner3.visible = false;
					}else if(data.users.length==2){
						joiner1.visible = true;
						joiner2.visible = true;
						joiner3.visible = false;
					}else if(data.users.length==3){
						joiner1.visible = true;
						joiner2.visible = true;
						joiner3.visible = true;
					}else{
						joiner1.visible = false;
						joiner2.visible = false;
						joiner3.visible = false;
					}
				}
			}
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xffffff,0.1);
			graphics.drawRoundRect(0,0,width,height,10,10);
			graphics.endFill();
		}
		
	}
}