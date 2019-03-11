package com.xiaomu.view.group
{
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Alert;
	import coco.component.Button;
	import coco.component.HorizontalAlign;
	import coco.component.Panel;
	import coco.component.TextInput;
	import coco.component.VerticalAlign;
	import coco.layout.VerticalLayout;
	import coco.manager.PopUpManager;
	
	public class AddMemberPanel extends Panel
	{
		public function AddMemberPanel()
		{
			super();
			
			width = 150
			height = 120
			backgroundColor = 0x000000
			backgroundAlpha = .8
			borderAlpha = 0
			
			title = '添加成员'
			
			var vlayout:VerticalLayout = new VerticalLayout()
			vlayout.verticalAlign = VerticalAlign.MIDDLE
			vlayout.horizontalAlign = HorizontalAlign.CENTER
			vlayout.gap = 5
			layout = vlayout
		}
		
		
		private static var instance:AddMemberPanel
		
		public static function getInstane(): AddMemberPanel {
			if (!instance) {
				instance = new AddMemberPanel()
			}
			
			return instance
		}
		
		
		private var memberUsernameInput:TextInput
		private var submitButton:Button
		private var cancelButton:Button
		
		override protected function createChildren():void {
			super.createChildren()
				
			titleDisplay.color = 0xFFFFFF
			
			memberUsernameInput = new TextInput()
			memberUsernameInput.width = 100
			memberUsernameInput.height = 20
			addChild(memberUsernameInput)
			
			submitButton = new Button()
			submitButton.width = 100
			submitButton.height = 20
			submitButton.label = "确定"
			submitButton.addEventListener(MouseEvent.CLICK, submitButton_clickHandler)
			addChild(submitButton)
			
			cancelButton = new Button()
			cancelButton.width = 100
			cancelButton.height = 20
			cancelButton.label = "取消"
			cancelButton.addEventListener(MouseEvent.CLICK, cancelButton_clickHandler)
			addChild(cancelButton)
		}
		
		private var thisGroupID:int
		
		public function open(groupid:int):void {
			thisGroupID = groupid
			PopUpManager.centerPopUp(PopUpManager.addPopUp(this))
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
					const response:Object = JSON.parse(e.currentTarget.data)
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
									const response2:Object = JSON.parse(e.currentTarget.data)
									if (response2.result == 0) {
										Alert.show('添加成功')
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
		
		override protected function drawSkin():void {
			graphics.clear()
			graphics.beginFill(0x000000, 0.7)
			graphics.drawRoundRect(0, 0, width, height, 5, 5)
			graphics.endFill()
			graphics.beginFill(0x000000)
			graphics.drawRoundRect(0, 0, width, titleHeight, 5, 5)
			graphics.endFill()
		}
		
		
	}
}