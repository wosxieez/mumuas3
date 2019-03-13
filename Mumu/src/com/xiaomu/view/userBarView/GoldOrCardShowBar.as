package com.xiaomu.view.userBarView
{
	import coco.component.Image;
	import coco.component.TextAlign;
	import coco.component.TextInput;
	import coco.core.UIComponent;
	
	/**
	 * 金币/房卡显示小组件
	 * @author fangchao
	 */
	public class GoldOrCardShowBar extends UIComponent
	{
		public function GoldOrCardShowBar()
		{
			super();
		}
		
		private var typeIcon:Image///金币或房卡图片
		private var number:TextInput///数量
		private var addIcon:Image///添加图片
		
		private var _typeSource:String;
		private var _count:String = '0';
		private var _iconWidthHeight:Array=[20,20];

		public function get iconWidthHeight():Array
		{
			return _iconWidthHeight;
		}

		public function set iconWidthHeight(value:Array):void
		{
			_iconWidthHeight = value;
			invalidateDisplayList()
		}

		public function get count():String
		{
			return _count;
		}

		public function set count(value:String):void
		{
			_count = value;
			invalidateProperties();
		}

		public function get typeSource():String
		{
			return _typeSource;
		}

		public function set typeSource(value:String):void
		{
			_typeSource = value;
			invalidateProperties()
		}

		override protected function createChildren():void
		{
			super.createChildren()
			
			number = new TextInput();
			number.editable = false;
			number.radius = 10;
			number.fontSize = 10;
			number.width = width;
			number.height = height-4;
			number.color = 0x000000;
			number.textAlign = TextAlign.CENTER;
			addChild(number);
			
			typeIcon = new Image();
			addChild(typeIcon);
			
			addIcon = new Image();
			addIcon.source = 'assets/user/add.png';
			addIcon.width = addIcon.height = height;
			addChild(addIcon);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			typeIcon.source = typeSource;
			number.text = count;
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList()
			
			
			typeIcon.x = typeIcon.y = -2;
			number.y = 0;
			number.x = iconWidthHeight[0]/3
			
			addIcon.x = number.x+number.width-addIcon.width+4;
			addIcon.y = -2;
			
			typeIcon.width = iconWidthHeight[0]
			typeIcon.height =  iconWidthHeight[1]
		}
	}
}