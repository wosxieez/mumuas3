package com.xiaomu.view.group
{
	import com.xiaomu.component.AppPanelSmall;
	import com.xiaomu.component.TitleTextInput;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Alert;
	import coco.component.Image;
	
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
		private var usernameInput:TitleTextInput
		
		override protected function createChildren():void {
			super.createChildren()
				
			titleImg = new Image();
			titleImg.width = 293;
			titleImg.height = 86;
			titleImg.source ='assets/guild/guild_title_addMember.png';
			this.addRawChild(titleImg);
			
			usernameInput = new TitleTextInput()
			usernameInput.width = 500
			usernameInput.title = '成员用户名'
			addChild(usernameInput)
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			titleImg.x = (width-titleImg.width)/2;
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
										Alert.show('添加成员成功')
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


