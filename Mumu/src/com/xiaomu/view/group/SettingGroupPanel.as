package com.xiaomu.view.group
{
	import com.xiaomu.event.AppManagerEvent;
	import com.xiaomu.manager.AppManager;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Alert;
	import coco.component.Button;
	import coco.component.Label;
	import coco.component.TextAlign;
	import coco.component.TextArea;
	import coco.component.TextInput;
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	
	/**
	 * 群设置
	 */
	public class SettingGroupPanel extends UIComponent
	{
		public function SettingGroupPanel()
		{
			super();
			
			width = 250
			height = 100
		}
		
		private var titleHeigh:Number = 30;
		private var titleLab:Label;
		private var groupNameLab:Label;
		private var groupNameTextInput:TextInput;
		private var groupRemarkLab:Label;
		private var groupRemarkTextArea:TextArea;
		private var okBtn:Button;
		private var cancelBtn:Button;
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
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			titleLab = new Label();
			titleLab.width = width;
			titleLab.text = '群设置';
			titleLab.fontSize = 12;
			titleLab.height = 20;
			titleLab.color = 0xffffff;
			addChild(titleLab);
			
			groupNameLab = new Label();
			groupNameLab.width = 40;
			groupNameLab.height = 20;
			groupNameLab.textAlign = TextAlign.LEFT;
			groupNameLab.text = '群名:';
			groupNameLab.fontSize = 10;
			groupNameLab.color = 0xffffff;
			addChild(groupNameLab);
			
			groupNameTextInput = new TextInput();
			groupNameTextInput.fontSize = 10;
			groupNameTextInput.height = 20;
			addChild(groupNameTextInput)
			
			groupRemarkLab = new Label();
			groupRemarkLab.width = 40;
			groupRemarkLab.height = 20;
			groupRemarkLab.textAlign = TextAlign.LEFT;
			groupRemarkLab.text = '群介绍:';
			groupRemarkLab.fontSize = 10;
			groupRemarkLab.color = 0xffffff;
			addChild(groupRemarkLab);
			
			groupRemarkTextArea = new TextArea();
			groupRemarkTextArea.fontSize = 10;
			addChild(groupRemarkTextArea)
			
			okBtn = new Button();
			okBtn.width = 30
			okBtn.height = 15
			okBtn.label = "确定"
			okBtn.fontSize = 10
			okBtn.addEventListener(MouseEvent.CLICK,okBtnHandler);
			addChild(okBtn);
			
			cancelBtn = new Button();
			cancelBtn.width = 30
			cancelBtn.height = 15
			cancelBtn.label = "取消"
			cancelBtn.fontSize = 10
			cancelBtn.addEventListener(MouseEvent.CLICK,cancelBtnHandler);
			addChild(cancelBtn);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
//			trace('数据：',JSON.stringify(data));
			groupNameTextInput.text = data.group_name;
			groupRemarkTextArea.text = data.remark;
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			titleLab.y = (titleHeigh-titleLab.height)/2
			
			groupNameLab.x = 5;
			groupNameLab.y = 5+titleHeigh;
			groupNameTextInput.x = groupNameLab.x+groupNameLab.width+5;
			groupNameTextInput.y = groupNameLab.y;
			groupNameTextInput.width = width-groupNameTextInput.x-30
			
			groupRemarkLab.x = 5;
			groupRemarkLab.y = groupNameLab.y+groupNameLab.height+5;
			groupRemarkTextArea.x = groupRemarkLab.x+groupRemarkLab.width+5;
			groupRemarkTextArea.y = groupRemarkLab.y;
			groupRemarkTextArea.width = width-groupRemarkTextArea.x-30
			groupRemarkTextArea.height = 40;
			
			okBtn.y = height+titleHeigh-okBtn.height-5;
			okBtn.x = width/2-okBtn.width-5;
			cancelBtn.y = okBtn.y;
			cancelBtn.x = width/2+5;
		}
		
		override protected function drawSkin():void {
			graphics.clear()
			graphics.beginFill(0x000000, 0.7)
			graphics.drawRoundRect(0, 0, width, height+titleHeigh, 5, 5)
			graphics.endFill()
			graphics.beginFill(0x000000)
			graphics.drawRoundRect(0, 0, width, titleHeigh, 5, 5)
			graphics.endFill()
		}
		
		protected function cancelBtnHandler(event:MouseEvent):void
		{
			PopUpManager.removeAllPopUp();
		}
		
		protected function okBtnHandler(event:MouseEvent):void
		{
			PopUpManager.removeAllPopUp();
			var newData : Object = {'group_name':groupNameTextInput.text,'remark':groupRemarkTextArea.text};
			HttpApi.getInstane().updateGroupByGroupId(data.group_id,newData,function(e:Event):void{
				if(JSON.parse(e.currentTarget.data).result==0){
					Alert.show('群信息修改成功');
					AppManager.getInstance().dispatchEvent(new AppManagerEvent(AppManagerEvent.UPDATE_GROUP_SUCCESS));
				}
			},null);
		}
	}
}