package com.xiaomu.view.userBarView
{
	import coco.component.Image;
	import coco.component.Label;
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
		private var unitLabel:Label
		
		private var _typeSource:String;
		private var _count:String = '0';
		private var _iconWidthHeight:Array=[34,35];

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
		
		private var _unit:String

		public function get unit():String
		{
			return _unit;
		}

		public function set unit(value:String):void
		{
			_unit = value;
			invalidateProperties()
		}

		override protected function createChildren():void
		{
			super.createChildren()
			
			number = new TextInput();
			number.backgroundColor = 0x000000;
			number.backgroundAlpha = .3;
			number.borderAlpha = 1;
			number.editable = false;
			number.radius =  height*0.5;
			number.fontSize = height*0.6;
			number.width = width;
			number.height = height;
			number.color = 0xFFCC33;
			number.textAlign = TextAlign.CENTER
			addChild(number);
			
			typeIcon = new Image();
			addChild(typeIcon);
			
			addIcon = new Image();
			addIcon.source = 'assets/user/add.png';
			addIcon.width = addIcon.height = number.height;
			addIcon.visible = false
			addChild(addIcon);
			
			unitLabel = new Label()
			unitLabel.height = number.height;
			unitLabel.width = 2 * unitLabel.height
			unitLabel.textAlign = TextAlign.RIGHT
			unitLabel.fontSize = 25
			unitLabel.rightMargin = 10
			unitLabel.color = 0xFFCC33;
			addChild(unitLabel)
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			typeIcon.source = typeSource;
			number.text = count;
			unitLabel.text = unit
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList()
			
			number.y = 0
			unitLabel.x = width - unitLabel.width
			addIcon.x = number.x+number.width-addIcon.width;
			
			typeIcon.width = iconWidthHeight[0]
			typeIcon.x = - typeIcon.width / 2
			typeIcon.height =  iconWidthHeight[1]
			typeIcon.y = (height-typeIcon.height)/2;
		}
	}
}