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
	import coco.component.TextInput;
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	
	public class AddMemberPanel extends UIComponent
	{
		public function AddMemberPanel()
		{
			super();
			
			width = 350
			height = 150
		}
		
		
		private static var instance:AddMemberPanel
		
		public static function getInstane(): AddMemberPanel {
			if (!instance) {
				instance = new AddMemberPanel()
			}
			
			return instance
		}
		
		private var titleLab:Label;
		private var titleHight:int=50;
		private var nameLab:Label;
		private var memberUsernameInput:TextInput
		private var submitButton:Button
		private var cancelButton:Button
		
		override protected function createChildren():void {
			super.createChildren()
				
			titleLab = new Label();
			titleLab.text = '添加成员';
			titleLab.fontSize = 24;
			titleLab.width = width;
			titleLab.height = 40;
			titleLab.color = 0xffffff;
			addChild(titleLab);
			
			nameLab = new Label();
			nameLab.text = '账号:';
			nameLab.fontSize = 20;
			nameLab.width = 80;
			nameLab.height = 40;
			nameLab.color = 0xffffff;
			addChild(nameLab);
				
			memberUsernameInput = new TextInput()
			memberUsernameInput.width = 200
			memberUsernameInput.height = 40
			memberUsernameInput.fontSize = 28
			addChild(memberUsernameInput)
			
			submitButton = new Button()
			submitButton.width = 60
			submitButton.height = 30
			submitButton.label = "确定"
			submitButton.fontSize = 20
			submitButton.addEventListener(MouseEvent.CLICK, submitButton_clickHandler)
			addChild(submitButton)
			
			cancelButton = new Button()
			cancelButton.width = 60
			cancelButton.height = 30
			cancelButton.label = "取消"
			cancelButton.fontSize = 20
			cancelButton.addEventListener(MouseEvent.CLICK, cancelButton_clickHandler)
			addChild(cancelButton)
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList();
			
			titleLab.y = 3;
			
			nameLab.x = 10;
			nameLab.y = titleHight+20;
			
			memberUsernameInput.x = nameLab.x+nameLab.width+10;
			memberUsernameInput.y = titleHight+20;
			
			cancelButton.x = width/2+10;
			cancelButton.y = height+titleHight-cancelButton.height-10;
			submitButton.x = width/2-submitButton.width-10;
			submitButton.y = cancelButton.y;
			
		}
		
		override protected function drawSkin():void {
			super.drawSkin();
			
			graphics.clear()
			graphics.beginFill(0x000000, 0.7)
			graphics.drawRoundRect(0, 0, width, height+titleHight, 5, 5)
			graphics.endFill()
			graphics.beginFill(0x000000)
			graphics.drawRoundRect(0, 0, width, titleHight, 5, 5)
			graphics.endFill()
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
		
		protected function submitButton_clickHandler(event:MouseEvent):void
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
		
		protected function cancelButton_clickHandler(event:MouseEvent):void
		{
			close()
		}
		
		
		
		
	}
}