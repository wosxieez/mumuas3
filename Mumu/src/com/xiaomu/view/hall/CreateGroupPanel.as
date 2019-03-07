package com.xiaomu.view.hall
{
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Alert;
	import coco.component.Button;
	import coco.component.Label;
	import coco.component.Panel;
	import coco.component.TextAlign;
	import coco.component.TextInput;
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	
	/**
	 * 创建亲友圈，交互框
	 */
	public class CreateGroupPanel extends Panel
	{
		public function CreateGroupPanel()
		{
			super();
			
			width = 150
			height = 120
			backgroundColor = 0x000000
			backgroundAlpha = .8
			borderAlpha = 0
			title = '请输入群名称'
		}
		
		private var nameInput:TextInput;
		private var okBtn : Button;
		private var cancelBtn : Button;
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			titleDisplay.color = 0xFFFFFF
			
			nameInput = new TextInput();
			nameInput.textAlign = TextAlign.CENTER;
			nameInput.maxChars = 15;
			addChild(nameInput);
			
			okBtn = new Button();
			okBtn.label = '确定';
			okBtn.addEventListener(MouseEvent.CLICK,oklHandler);
			addChild(okBtn);
			
			cancelBtn = new Button();
			cancelBtn.label = '取消'
			cancelBtn.addEventListener(MouseEvent.CLICK,cancelHandler);
			addChild(cancelBtn);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			nameInput.x = okBtn.x = cancelBtn.x = width/5;
			nameInput.y = 10;
			nameInput.width = width*3/5;
			nameInput.height = nameInput.width/6;
			
			okBtn.width = cancelBtn.width = nameInput.width;
			okBtn.height = cancelBtn.height = nameInput.height;
			okBtn.y = nameInput.y+nameInput.height+10;
			cancelBtn.y = okBtn.y+okBtn.height+10
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear()
			graphics.beginFill(0x000000, 0.7)
			graphics.drawRoundRect(0, 0, width, height, 5, 5)
			graphics.endFill()
			graphics.beginFill(0x000000)
			graphics.drawRoundRect(0, 0, width, titleHeight, 5, 5)
			graphics.endFill()
		}
		
		protected function cancelHandler(event:MouseEvent):void
		{
			PopUpManager.removePopUp(this);
		}
		
		
		protected function oklHandler(event:MouseEvent):void
		{
			var group_info_arr: Array = []; 
			HttpApi.getInstane().getUserInfo(AppData.getInstane().username,function(e:Event):void{
				group_info_arr  = JSON.parse(JSON.parse(e.currentTarget.data).message[0].group_info) as Array
				if(nameInput.text){
					////进行group表的插入工作
					HttpApi.getInstane().insertGroupInfo(nameInput.text,parseInt(AppData.getInstane().user.userId),function(e:Event):void{
						var newGroupInfoObj:Object = {'gold':0,'group_id':parseInt(JSON.parse(e.currentTarget.data).message.id)};
						group_info_arr.push(newGroupInfoObj);
						HttpApi.getInstane().updateUserGroupInfo(AppData.getInstane().username,group_info_arr,function(e:Event):void{
							if(JSON.parse(e.currentTarget.data).result==0){
								PopUpManager.removeAllPopUp();
								///刷新界面
								Alert.show('创建成功');
							}
						},null)
					},null)
				}
			},null);
			
			
		}
	}
}