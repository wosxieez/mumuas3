package com.xiaomu.view.hall.popUpPanel
{
	import com.xiaomu.component.ImageButton;
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
		private var okImg:ImageButton;
		private var cancelImg:ImageButton;
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
			
			okImg = new ImageButton();
			okImg.upImageSource = 'assets/home/popUp/btn_confirm_normal.png';
			okImg.downImageSource = 'assets/home/popUp/btn_confirm_press.png';
			okImg.width = 166;
			okImg.height = 70;
			okImg.addEventListener(MouseEvent.CLICK,okImgHandler);
			addChild(okImg);
			
			cancelImg = new ImageButton();
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
			HttpApi.getInstane().addGroup({groupname: groupNameInput.text, fc: 0}, 
				function (e:Event):void {
					try
					{
						var response:Object = JSON.parse(e.currentTarget.data)
						if (response.code == 0) { 
							var group:Object = response.data
							// 创建群成功 把自己作为馆长身份加入进去
							HttpApi.getInstane().addGroupUser({ gid: group.id, uid: AppData.getInstane().user.id }, 
								function (ee:Event):void {
									var response2:Object = JSON.parse(ee.currentTarget.data)
									if (response2.code == 0) { 
										Alert.show('创建群成功')
									}
								}) 
						} else {
						}
					} 
					catch(error:Error) 
					{
						
					}
				})
		}
	}
}