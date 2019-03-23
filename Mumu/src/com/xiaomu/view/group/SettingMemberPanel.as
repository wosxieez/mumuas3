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
	import coco.component.TextInput;
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	
	public class SettingMemberPanel extends UIComponent
	{
		public function SettingMemberPanel()
		{
			super();
			
			width = 480
			height = 200
		}
		
		
		private static var instance:SettingMemberPanel
		
		public static function getInstane(): SettingMemberPanel {
			if (!instance) {
				instance = new SettingMemberPanel()
			}
			
			return instance
		}
		
		private var titleHeight:int = 50;
		private var titleLab:Label;
		private var goldLab:Label;
		private var goldInput:TextInput
		private var nameLab:Label;
		private var nameInput:TextInput;
		private var subNameLab:Label;
		private var subNameInput:TextInput;
		
		private var submitButton:Button
		private var cancelButton:Button
		private var removeButton:Button
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
		
		private var _group_id:int
		
		public function get group_id():int
		{
			return _group_id;
		}

		public function set group_id(value:int):void
		{
			_group_id = value;
		}

		override protected function createChildren():void {
			super.createChildren()
				
			titleLab = new Label();
			titleLab.text = '设置成员';
			titleLab.color = 0xffffff;
			titleLab.fontSize = 24;
			titleLab.width = width;
			titleLab.height = 40;
			addChild(titleLab);
			
			nameLab = new Label();
			nameLab.width = 60;
			nameLab.height = 40;
			nameLab.text = '姓名:';
			nameLab.textAlign = TextAlign.LEFT;
			nameLab.color = 0xffffff;
			nameLab.fontSize = 20;
			addChild(nameLab);
			
			nameInput = new TextInput()
			nameInput.editable = false
			nameInput.fontSize = 20;
			nameInput.width = 120
			nameInput.height = 40
			addChild(nameInput)
			
			subNameLab = new Label();
			subNameLab.width = 60;
			subNameLab.height = 40;
			subNameLab.text = '昵称:';
			subNameLab.textAlign = TextAlign.LEFT;
			subNameLab.color = 0xffffff;
			subNameLab.fontSize = 20;
			addChild(subNameLab);
			
			subNameInput = new TextInput()
			subNameInput.fontSize = 20;
			subNameInput.width = 120
			subNameInput.height = 40
			addChild(subNameInput)
			
			goldLab = new Label();
			goldLab.width = 60;
			goldLab.height = 40;
			goldLab.text = '金币:';
			goldLab.textAlign = TextAlign.LEFT;
			goldLab.color = 0xffffff;
			goldLab.fontSize = 20;
			addChild(goldLab);
			
			goldInput = new TextInput()
			goldInput.fontSize = 20
			goldInput.width = 120
			goldInput.height = 40
			addChild(goldInput)
			
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
			
			removeButton = new Button()
			removeButton.width = 100
			removeButton.height = 30
			removeButton.label = "移除成员"
			removeButton.fontSize = 20
			removeButton.addEventListener(MouseEvent.CLICK, removeButton_clickHandler)
			addChild(removeButton)
		}
		
		
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			if (thisUser) {
				nameInput.text = thisUser.username
				var groups:Array = JSON.parse(thisUser.group_info) as Array
				for each(var group:Object in groups) {
					if (group.group_id == oldUser.group_id) {
						goldInput.text = group.gold
						subNameInput.text = group.subname
//						trace('group:',JSON.stringify(group));
						group_id = group.group_id;
						break
					}
				}
			}
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			titleLab.y = (titleHeight-titleLab.height)/2;
			
			nameLab.x = 20;
			nameLab.y = titleHeight+10;
			nameInput.x = nameLab.x+nameLab.width;
			nameInput.y = nameLab.y;
			
			goldLab.x = nameInput.x+nameInput.width+30;
			goldLab.y = nameLab.y;
			goldInput.x = goldLab.x+goldLab.width;
			goldInput.y = nameLab.y;
			
			subNameLab.x = nameLab.x;
			subNameLab.y = nameLab.y+nameLab.height+20;
			subNameInput.x = subNameLab.x+subNameLab.width;
			subNameInput.y = subNameLab.y;
			
			submitButton.x = width/2-submitButton.width-10;
			submitButton.y = height+titleHeight-submitButton.height-20;
			cancelButton.x = width/2+10;
			cancelButton.y = submitButton.y;
			removeButton.x = width-(removeButton.width+20);
			removeButton.y = cancelButton.y;
		}
		
		override protected function drawSkin():void {
			graphics.clear()
			graphics.beginFill(0x000000, 0.7)
			graphics.drawRoundRect(0, 0, width, height+titleHeight, 5, 5)
			graphics.endFill()
			graphics.beginFill(0x000000)
			graphics.drawRoundRect(0, 0, width, titleHeight, 5, 5)
			graphics.endFill()
		}
		
		public function open(user:Object):void {
			oldUser = user
			
			PopUpManager.centerPopUp(PopUpManager.addPopUp(this,null,true,true,0xffffff,0.3))
			
			// 查询到用户
			HttpApi.getInstane().getUserInfoByName(oldUser.username, 
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
			goldInput.text = ''
			PopUpManager.removePopUp(this)
		}
		
		protected function submitButton_clickHandler(event:MouseEvent):void
		{
			if(!parseInt(goldInput.text)){
				Alert.show('输入金币数有误');
				return;
			}
			var groups:Array = JSON.parse(thisUser.group_info) as Array
			for each(var group:Object in groups) {
				if (group.group_id == oldUser.group_id) {
					group.gold = parseInt(goldInput.text);
					group.subname = subNameInput.text
					break
				}
			}
			HttpApi.getInstane().updateUserGroupInfo(thisUser.username, groups, 
				function (e:Event):void {
					const response:Object = JSON.parse(e.currentTarget.data)
					if (response.result == 0) {
						Alert.show('设置成功')
						AppManager.getInstance().dispatchEvent(new AppManagerEvent(AppManagerEvent.UPDATE_MEMBER_INFO_SUCCESS));
						close()
					} else {
						Alert.show('设置失败')
					}
				},
				function (e:Event):void {
					Alert.show('设置失败')
				})
		}
		
		protected function cancelButton_clickHandler(event:MouseEvent):void
		{
			close()
		}
		
		protected function removeButton_clickHandler(event:MouseEvent):void
		{
			var removeMemberPanel:RemoveMemberPanel;
			if(!removeMemberPanel){
				removeMemberPanel = new RemoveMemberPanel();
			}
			removeMemberPanel.data = {'userid':thisUser.id,'gold':parseInt(goldInput.text),'username':thisUser.username,'group_id':group_id}
			PopUpManager.centerPopUp(PopUpManager.addPopUp(removeMemberPanel,null,true,false,0xffffff,0.2));
		}
		
		
	}
}