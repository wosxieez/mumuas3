package com.xiaomu.view.hall.popUpPanel
{
	import com.xiaomu.component.ImageBtnWithUpAndDown;
	import com.xiaomu.event.AppManagerEvent;
	import com.xiaomu.manager.AppManager;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Alert;
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextInput;
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	import coco.util.FontFamily;
	
	/**
	 * 创建亲友圈，交互框
	 */
	public class CreateGroupPanel extends UIComponent
	{
		public function CreateGroupPanel()
		{
			super();
			width = 915;
			height = 518;
		}
		
		private var bgImg:Image;
		private var titleImg:Image;
		private var okImg:ImageBtnWithUpAndDown;
		private var cancelImg:ImageBtnWithUpAndDown;
		private var groupNameInput:TextInput;
		private var groupNameLab:Label;
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			bgImg = new Image();
			bgImg.source = 'assets/home/popUp/bac_04.png';
			bgImg.width = width;
			bgImg.height = height;
			addChild(bgImg);
			
			titleImg = new Image();
			titleImg.source = 'assets/home/popUp/shezhi.png';
			titleImg.width = 293;
			titleImg.height = 86;
			addChild(titleImg);
			
			okImg = new ImageBtnWithUpAndDown();
			okImg.upImageSource = 'assets/home/popUp/btn_confirm_normal.png';
			okImg.downImageSource = 'assets/home/popUp/btn_confirm_press.png';
			okImg.width = 166;
			okImg.height = 70;
			okImg.addEventListener(MouseEvent.CLICK,okImgHandler);
			addChild(okImg);
			
			cancelImg = new ImageBtnWithUpAndDown();
			cancelImg.upImageSource = 'assets/home/popUp/Z_cancelNormal.png';
			cancelImg.downImageSource = 'assets/home/popUp/Z_cancelPress.png';
			cancelImg.width = 166;
			cancelImg.height = 70;
			cancelImg.addEventListener(MouseEvent.CLICK,cancelImgHandler);
			addChild(cancelImg);
			
			groupNameLab = new Label();
			groupNameLab.text = '群名:';
			groupNameLab.fontFamily = FontFamily.MICROSOFT_YAHEI;
			groupNameLab.color = 0x6f1614;
			groupNameLab.fontSize = 32;
			groupNameLab.width = 90;
			groupNameLab.height = 40;
			addChild(groupNameLab);
			
			groupNameInput = new TextInput();
			groupNameInput.maxChars = 12;
			groupNameInput.radius = 10;
			groupNameInput.fontFamily = FontFamily.MICROSOFT_YAHEI;
			groupNameInput.color = 0x6f1614;
			groupNameInput.fontSize = 32;
			groupNameInput.width = 300;
			groupNameInput.height = 50;
			addChild(groupNameInput);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			bgImg.x = bgImg.y = 0;
			titleImg.x = (width-titleImg.width)/2;
			titleImg.y = 0;
			
			okImg.x = width/2-okImg.width-20;
			okImg.y = height-okImg.height-20
			
			cancelImg.x = width/2+20;
			cancelImg.y = okImg.y
				
			groupNameLab.x = 200;
			groupNameLab.y = 150;
			
			groupNameInput.x = groupNameLab.x+groupNameLab.width+20;
			groupNameInput.y = groupNameLab.y-(groupNameInput.height-groupNameLab.height)/2;
		}
		
		protected function cancelImgHandler(event:MouseEvent):void
		{
			PopUpManager.removePopUp(this);
		}
		
		protected function okImgHandler(event:MouseEvent):void
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