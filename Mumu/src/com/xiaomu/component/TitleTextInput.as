package com.xiaomu.component
{
	import coco.component.Label;
	import coco.component.TextInput;
	
	public class TitleTextInput extends TextInput
	{
		public function TitleTextInput()
		{
			super();
		}
		
		private var _title:String
		
		public function get title():String
		{
			return _title;
		}

		public function set title(value:String):void
		{
			_title = value;
			invalidateProperties()
		}

		private var titleDisplay:Label
		
		override protected function createChildren():void {
			super.createChildren()
				
			titleDisplay = new Label()
			addChild(titleDisplay)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
				
				titleDisplay.text = title
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			titleDisplay.y = textDisplay.y
			titleDisplay.height = textDisplay.height
			titleDisplay.width = 100
				
			textDisplay.x = 105;
			textDisplay.width = width  - 110;
		}
		
	}
}