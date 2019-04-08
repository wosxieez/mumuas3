package com.xiaomu.view.group
{
	import com.xiaomu.component.AppAlert;
	import com.xiaomu.component.AppPanelSmall;
	import com.xiaomu.event.AppManagerEvent;
	import com.xiaomu.manager.AppManager;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextInput;
	
	public class AddUserPanel extends AppPanelSmall
	{
		public function AddUserPanel()
		{
			super();
			
//			title = '添加成员'
//			var vl:VerticalLayout = new VerticalLayout()
//			layout = vl
		}
		
		private var titleImg:Image;
		private var usernameLab:Label;
		private var usernameInput:TextInput
		
		override protected function createChildren():void {
			super.createChildren()
				
			titleImg = new Image();
			titleImg.width = 293;
			titleImg.height = 86;
			titleImg.source ='assets/guild/guild_title_addMember.png';
			this.addRawChild(titleImg);
			
			usernameLab = new Label();
			usernameLab.text = '成员用户名';
			usernameLab.fontSize = 24;
			usernameLab.color = 0x845525;
			usernameLab.height = 40;
			usernameLab.width = 160;
			addChild(usernameLab);
			
			usernameInput = new TextInput()
			usernameInput.width = 300
			usernameInput.height = 40;
			usernameInput.fontSize = 24;
			usernameInput.color = 0x845525;
			addChild(usernameInput)
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			titleImg.x = (width-titleImg.width)/2;
			
			usernameLab.x = 40;
			usernameLab.y = 60;
			
			usernameInput.x = usernameLab.x+usernameLab.width+30;
			usernameInput.y = usernameLab.y;
		}
		
		override protected function commitButton_clickHandler(event:MouseEvent):void {
			HttpApi.getInstane().getUser({username: usernameInput.text}, 
				function (e:Event):void {
					try {
						var response:Object = JSON.parse(e.currentTarget.data)
						if (response.code == 0 && response.data.length > 0) {
							var user:Object = response.data[0]
							HttpApi.getInstane().addGroupUser({ 
								gid: AppData.getInstane().group.id, 
								uid: user.id, 
								pid: AppData.getInstane().user.id,
								fs: 0, 
								ll: 0}, 
								function (ee:Event):void {
									var response2:Object = JSON.parse(ee.currentTarget.data)
									if (response2.code == 0) {
										AppAlert.show('添加成员成功')
										AppManager.getInstance().dispatchEvent(new AppManagerEvent(AppManagerEvent.CHANGE_MEMBER_SUCCESS));
										close()
									}
								})
						} else {
						}
					} catch(error:Error) {
					}
				})
		}
		
	}
}


