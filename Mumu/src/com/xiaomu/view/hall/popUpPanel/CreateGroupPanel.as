package com.xiaomu.view.hall.popUpPanel
{
	import com.xiaomu.event.AppManagerEvent;
	import com.xiaomu.itemRender.CircleItemRender;
	import com.xiaomu.manager.AppManager;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Alert;
	import coco.component.Button;
	import coco.component.ButtonGroup;
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextAlign;
	import coco.component.TextInput;
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	
	/**
	 * 创建亲友圈，交互框
	 */
	public class CreateGroupPanel extends UIComponent
	{
		public function CreateGroupPanel()
		{
			super();
			width = 400;
			height = 120;
		}
		
		private var titleHeigh:int = 50;
		private var titleLab:Label;
		private var groupNameLab:Label;
		private var groupNameInput:TextInput;
		private var okBtn : Button;
		private var cancelBtn : Button;
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			titleLab = new Label();
			titleLab.text = '创建亲友圈';
			titleLab.fontSize = 20;
			titleLab.width = width;
			titleLab.height = 40;
			titleLab.color = 0xffffff;
			addChild(titleLab);
			
			groupNameLab = new Label();
			groupNameLab.color = 0xffffff;
			groupNameLab.text = '群名:';
			groupNameLab.width = 80;
			groupNameLab.height = 40;
			groupNameLab.fontSize = 20;
			addChild(groupNameLab);
			
			groupNameInput = new TextInput();
			groupNameInput.textAlign = TextAlign.CENTER;
			groupNameInput.maxChars = 30;
			groupNameInput.height = 40;
			groupNameInput.fontSize = 20;
			addChild(groupNameInput);
			
			okBtn = new Button();
			okBtn.label = '确定';
			okBtn.width = 60;
			okBtn.height = 30;
			okBtn.fontSize = 20;
			okBtn.addEventListener(MouseEvent.CLICK,oklHandler);
			addChild(okBtn);
			
			cancelBtn = new Button();
			cancelBtn.label = '取消'
			cancelBtn.width = 60;
			cancelBtn.height = 30;
			cancelBtn.fontSize = 20;
			cancelBtn.addEventListener(MouseEvent.CLICK,cancelHandler);
			addChild(cancelBtn);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			titleLab.y = (titleHeigh-titleLab.height)/2;
			
			groupNameLab.x = 20;
			groupNameLab.y = titleHeigh+10;
			groupNameInput.x = groupNameLab.x+groupNameLab.width;
			groupNameInput.y = groupNameLab.y;
			groupNameInput.width = width-2*groupNameInput.x;
			
			okBtn.x = width/2-okBtn.width-10;
			okBtn.y = height+titleHeigh-okBtn.height-10;
			cancelBtn.x = width/2+10;
			cancelBtn.y = okBtn.y;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			/*graphics.clear();
			graphics.beginFill(0xffffff,1);
			graphics.drawRoundRect(0,0,width,height,20,20);
			graphics.endFill();*/
			
			graphics.clear()
			graphics.beginFill(0x000000, 0.7)
			graphics.drawRoundRect(0, 0, width, height+titleHeigh, 5, 5)
			graphics.endFill()
			graphics.beginFill(0x000000)
			graphics.drawRoundRect(0, 0, width, titleHeigh, 5, 5)
			graphics.endFill()
		}
		
		protected function cancelHandler(event:MouseEvent):void
		{
			PopUpManager.removePopUp(this);
		}
		
		
		protected function oklHandler(event:MouseEvent):void
		{
			/*
			* 创建群的操作，先insert group表，再更新user表中当前用户的group_info字段
			创建insert rooms表，添加x张桌子
			*/
			var group_info_arr: Array = []; 
			HttpApi.getInstane().getUserInfoByName(AppData.getInstane().username,function(e:Event):void{
				var group_info:String = "[]";
				if(JSON.parse(e.currentTarget.data).message[0].group_info){
					group_info = JSON.parse(e.currentTarget.data).message[0].group_info;
				}
				group_info_arr  = JSON.parse(group_info) as Array
				if(groupNameInput.text){
					////进行group表的插入工作
					HttpApi.getInstane().insertGroupInfo(groupNameInput.text,parseInt(AppData.getInstane().user.userId),function(e:Event):void{
						var newGroupInfoObj:Object = {'gold':0,'group_id':parseInt(JSON.parse(e.currentTarget.data).message.id)};
						var group_id:int = parseInt(JSON.parse(e.currentTarget.data).message.id);
						group_info_arr.push(newGroupInfoObj);
						///添加桌子，insert room表
						
						for (var i:int = 1; i <= 5; i++) 
						{
							HttpApi.getInstane().addRoom(i+'号房间',group_id,3,null,null);
						}
						///对群主自身的groupInfo字段进行更新
						HttpApi.getInstane().updateUserGroupInfo(AppData.getInstane().username,group_info_arr,function(e:Event):void{
							if(JSON.parse(e.currentTarget.data).result==0){
								PopUpManager.removeAllPopUp();
								///刷新界面
								Alert.show('创建成功');
								AppManager.getInstance().dispatchEvent(new AppManagerEvent(AppManagerEvent.CREATE_GROUP_SUCCESS));
							}
						},null)
					},null)
				}
			},null);
		}
	}
}