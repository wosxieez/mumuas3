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
	
	public class SettingMemberPanel extends Panel
	{
		public function SettingMemberPanel()
		{
			super();
			
			width = 150
			height = 120
			backgroundColor = 0x000000
			backgroundAlpha = .8
			borderAlpha = 0
			
			title = '设置成员'
			
			var vlayout:VerticalLayout = new VerticalLayout()
			vlayout.verticalAlign = VerticalAlign.MIDDLE
			vlayout.horizontalAlign = HorizontalAlign.CENTER
			vlayout.gap = 5
			layout = vlayout
		}
		
		
		private static var instance:SettingMemberPanel
		
		public static function getInstane(): SettingMemberPanel {
			if (!instance) {
				instance = new SettingMemberPanel()
			}
			
			return instance
		}
		
		
		private var memberUsernameInput:TextInput
		private var submitButton:Button
		private var cancelButton:Button
		private var oldUser:Object
		private var _thisUser:Object
		
		public function get thisUser():Object
		{
			return _thisUser;
		}
		
		public function set thisUser(value:Object):void
		{
			_thisUser = value;
			invalidateProperties()
		}
		
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
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			if (thisUser) {
				var groups:Array = JSON.parse(thisUser.group_info) as Array
				for each(var group:Object in groups) {
					if (group.group_id == oldUser.group_id) {
						memberUsernameInput.text = group.gold
						break
					}
				}
			}
		}
		
		public function open(user:Object):void {
			oldUser = user
			
			PopUpManager.centerPopUp(PopUpManager.addPopUp(this))
			
			// 查询到用户
			HttpApi.getInstane().getUserInfo(oldUser.username, 
				function (e:Event):void {
					const response:Object = JSON.parse(e.currentTarget.data)
					if (response.result == 0) {
						if (response.message.length > 0) {
							thisUser = response.message[0]
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
		
		public function close():void {
			memberUsernameInput.text = ''
			PopUpManager.removePopUp(this)
		}
		
		protected function submitButton_clickHandler(event:MouseEvent):void
		{
			var groups:Array = JSON.parse(thisUser.group_info) as Array
			for each(var group:Object in groups) {
				if (group.group_id == oldUser.group_id) {
					group.gold = memberUsernameInput.text
					break
				}
			}
			
			HttpApi.getInstane().updateUserGroupInfo(thisUser.username, groups, 
				function (e:Event):void {
					trace(e.currentTarget.data)
					const response:Object = JSON.parse(e.currentTarget.data)
					if (response.result == 0) {
						Alert.show('设置成功')
						close()
					} else {
						Alert.show('设置失败')
					}
				},
				function (e:Event):void {
					trace(e.currentTarget.data)
					Alert.show('设置失败')
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