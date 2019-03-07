package com.xiaomu.view.hall
{
	import coco.component.Button;
	import coco.component.Label;
	import coco.component.TextAlign;
	import coco.component.TextInput;
	import coco.core.UIComponent;
	
	/**
	 * 创建亲友圈，交互框
	 */
	public class CreateGroupPanel extends UIComponent
	{
		public function CreateGroupPanel()
		{
			super();
			width = 200;
			height = 120;
		}
		
		private var title:Label;
		private var nameInput:TextInput;
		private var okBtn : Button;
		private var cancelBtn : Button;
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			title = new Label();
			title.text = '请输入群名称';
			title.textAlign = TextAlign.CENTER;
			addChild(title);
			
			nameInput = new TextInput();
			nameInput.textAlign = TextAlign.CENTER;
			nameInput.maxChars = 15;
			addChild(nameInput);
			
//			okBtn = new Button();
//			okBtn.label = '确定';
//			okBtn.width = 60;
//			okBtn.height = 20;
//			addChild(okBtn);
//			
//			cancelBtn = new Button();
//			cancelBtn.label = '取消'
//			cancelBtn.width = 60;
//			cancelBtn.height = 20;
//			addChild(cancelBtn);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			title.width = width;
			title.y = 10;
			nameInput.x = width/5;
			nameInput.y = 30;
			nameInput.width = width*3/5;
			nameInput.height = nameInput.width/6;
			
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xffffff);
			graphics.drawRoundRect(0,0,width,height,10,10);
			graphics.endFill();
		}
	}
}