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
	import coco.component.TextAlign;
	import coco.component.TextInput;
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	import coco.util.FontFamily;
	
	public class SettingMemberPanel extends UIComponent
	{
		public function SettingMemberPanel()
		{
			super();
			width = 915;
			height = 518;
		}
		
		
		private static var instance:SettingMemberPanel
		
		public static function getInstane(): SettingMemberPanel {
			if (!instance) {
				instance = new SettingMemberPanel()
			}
			
			return instance
		}
		
		
		private var bgImg:Image;
		private var titleImg:Image;
		private var okImg:ImageButton;
		private var cancelImg:ImageButton;
		
		private var goldLab:Label;
		private var goldInput:TextInput
		private var nameLab:Label;
		private var nameInput:TextInput;
		private var subNameLab:Label;
		private var subNameInput:TextInput;
		
		private var removeImg:ImageButton
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
			
			nameLab = new Label();
			nameLab.text = '姓名:';
			nameLab.fontFamily = FontFamily.MICROSOFT_YAHEI;
			nameLab.color = 0x6f1614;
			nameLab.fontSize = 32;
			nameLab.width = 90;
			nameLab.height = 40;
			addChild(nameLab);
			
			nameInput = new TextInput()
			nameInput.editable = false
			nameInput.maxChars = 12;
			nameInput.radius = 10;
			nameInput.fontFamily = FontFamily.MICROSOFT_YAHEI;
			nameInput.color = 0x6f1614;
			nameInput.fontSize = 32;
			nameInput.width = 300;
			nameInput.height = 50;
			addChild(nameInput)
			
			subNameLab = new Label();
			subNameLab.text = '昵称:';
			subNameLab.fontFamily = FontFamily.MICROSOFT_YAHEI;
			subNameLab.color = 0x6f1614;
			subNameLab.fontSize = 32;
			subNameLab.width = 90;
			subNameLab.height = 40;
			addChild(subNameLab);
			
			subNameInput = new TextInput()
			subNameInput.maxChars = 12;
			subNameInput.radius = 10;
			subNameInput.fontFamily = FontFamily.MICROSOFT_YAHEI;
			subNameInput.color = 0x6f1614;
			subNameInput.fontSize = 32;
			subNameInput.width = 300;
			subNameInput.height = 50;
			addChild(subNameInput)
			
			goldLab = new Label();
			goldLab.text = '金币:';
			goldLab.fontFamily = FontFamily.MICROSOFT_YAHEI;
			goldLab.color = 0x6f1614;
			goldLab.fontSize = 32;
			goldLab.width = 90;
			goldLab.height = 40;
			addChild(goldLab);
			
			goldInput = new TextInput()
			goldInput.maxChars = 12;
			goldInput.radius = 10;
			goldInput.fontFamily = FontFamily.MICROSOFT_YAHEI;
			goldInput.color = 0x6f1614;
			goldInput.fontSize = 32;
			goldInput.width = 300;
			goldInput.height = 50;
			addChild(goldInput)
			
			removeImg = new ImageButton()
			removeImg.upImageSource = 'assets/home/popUp/shanchu_up.png';
			removeImg.downImageSource = 'assets/home/popUp/shanchu_down.png';
			removeImg.width = 146
			removeImg.height = 59
			removeImg.addEventListener(MouseEvent.CLICK, removeButton_clickHandler)
			addChild(removeImg)
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
			
			nameLab.x = 200;
			nameLab.y = 150;
			
			nameInput.x = nameLab.x+nameLab.width+20;
			nameInput.y = nameLab.y-(nameInput.height-nameLab.height)/2;
			
			subNameLab.x = 200;
			subNameLab.y = nameLab.y+nameLab.height+20;
			
			subNameInput.x = subNameLab.x+subNameLab.width+20;
			subNameInput.y = subNameLab.y-(subNameInput.height-subNameLab.height)/2;
			
			goldLab.x = 200;
			goldLab.y = subNameLab.y+subNameLab.height+20;
			
			goldInput.x = goldLab.x+goldLab.width+20;
			goldInput.y = goldLab.y-(goldInput.height-goldLab.height)/2;
			
			removeImg.x = cancelImg.x+cancelImg.width+20;
			removeImg.y = cancelImg.y+(cancelImg.height-removeImg.height)/2;
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
		
		public function open(user:Object):void {
			oldUser = user
			
			PopUpManager.centerPopUp(PopUpManager.addPopUp(this,null,true,true,0xffffff,0.3))
			
			// 查询到用户
			HttpApi.getInstane().getUserInfoByName(oldUser.username, 
				function (e:Event):void {
					var response:Object = JSON.parse(e.currentTarget.data)
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
		
		protected function okImgHandler(event:MouseEvent):void
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
					var response:Object = JSON.parse(e.currentTarget.data)
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
		
		protected function cancelImgHandler(event:MouseEvent):void
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