package com.xiaomu.view.group
{
	import com.xiaomu.component.ImageButton;
	import com.xiaomu.event.AppManagerEvent;
	import com.xiaomu.manager.AppManager;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Alert;
	import coco.component.Button;
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextInput;
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	import coco.util.FontFamily;
	
	/**
	 * 添加群成员设置界面
	 */
	public class AddMemberPanel extends UIComponent
	{
		public function AddMemberPanel()
		{
			super();
			width = 915;
			height = 518;
		}
		
		private static var instance:AddMemberPanel
		
		public static function getInstane(): AddMemberPanel {
			if (!instance) {
				instance = new AddMemberPanel()
			}
			
			return instance
		}
		
		private var nameLab:Label;
		private var memberUsernameInput:TextInput
		private var submitButton:Button
		private var cancelButton:Button
		
		private var bgImg:Image;
		private var titleImg:Image;
		private var okImg:ImageButton;
		private var cancelImg:ImageButton;
		
		override protected function createChildren():void {
			super.createChildren()
				
			bgImg = new Image();
			bgImg.source = 'assets/home/popUp/bac_04.png';
			bgImg.width = width;
			bgImg.height = height;
			addChild(bgImg);
			
			titleImg = new Image();
			titleImg.source = 'assets/home/popUp/Title_yaoqing.png';
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
				
			nameLab = new Label();
			nameLab.text = '账号:';
			nameLab.fontFamily = FontFamily.MICROSOFT_YAHEI;
			nameLab.color = 0x6f1614;
			nameLab.fontSize = 32;
			nameLab.width = 90;
			nameLab.height = 30;
			addChild(nameLab);
				
			memberUsernameInput = new TextInput()
			memberUsernameInput.maxChars = 12;
			memberUsernameInput.radius = 10;
			memberUsernameInput.fontFamily = FontFamily.MICROSOFT_YAHEI;
			memberUsernameInput.color = 0x6f1614;
			memberUsernameInput.fontSize = 32;
			memberUsernameInput.width = 300;
			memberUsernameInput.height = 50;
			addChild(memberUsernameInput)
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList();
			
			bgImg.x = bgImg.y = 0;
			titleImg.x = (width-titleImg.width)/2;
			titleImg.y = 0;
			
			okImg.x = width/2-okImg.width-20;
			okImg.y = height-okImg.height-20
			
			cancelImg.x = width/2+20;
			cancelImg.y = okImg.y
			
			nameLab.x = 200;
			nameLab.y = 150;
			
			memberUsernameInput.x = nameLab.x+nameLab.width+20;
			memberUsernameInput.y = nameLab.y-(memberUsernameInput.height-nameLab.height)/2;
		}
		
		private var thisGroupID:int
		
		public function open(groupid:int):void {
			thisGroupID = groupid
			PopUpManager.centerPopUp(PopUpManager.addPopUp(this,null,true,false,0,0.2))
		}
		
		public function close():void {
			memberUsernameInput.text = ''
			PopUpManager.removePopUp(this)
		}
		
		protected function okImgHandler(event:MouseEvent):void
		{
			// 查询到用户
			HttpApi.getInstane().getUserInfoByName(memberUsernameInput.text, 
				function (e:Event):void {
					var response:Object = JSON.parse(e.currentTarget.data)
					if (response.result == 0) {
						if (response.message.length > 0) {
							var user:Object = response.message[0]
							var groups:Array
							try
							{
								groups = JSON.parse(user.group_info) as Array
							} 
							catch(error:Error) 
							{
							}
							
							if (!groups) groups = []
							
							for each(var group:Object in groups) {
								if (group.group_id == thisGroupID) {
									Alert.show('该玩家已经在群里')
									return
								}
							}
							groups.push({gold: 0, group_id: thisGroupID})
							HttpApi.getInstane().updateUserGroupInfo(user.username, groups, 
								function (e:Event):void {
									var response2:Object = JSON.parse(e.currentTarget.data)
									if (response2.result == 0) {
										Alert.show('添加成功')
										AppManager.getInstance().dispatchEvent(new AppManagerEvent(AppManagerEvent.CHANGE_MEMBER_SUCCESS));
										close()
									} else {
										Alert.show('添加失败')
									}
								}, function (e:Event):void {
									Alert.show('添加失败')
								})
						} else {
							Alert.show('该玩家不存在')
						}
					} else {
						Alert.show('添加失败')
					}
				}, function (e:Event):void {
					Alert.show('添加失败')
				})
		}
		
		protected function cancelImgHandler(event:MouseEvent):void
		{
			close()
		}
	}
}