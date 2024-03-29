package com.xiaomu.view.hall
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
	import coco.component.TextAlign;
	import coco.component.TextInput;
	
	/**
	 * 创建亲友圈，交互框
	 */
	public class AddGroupPanel extends AppPanelSmall
	{
		public function AddGroupPanel()
		{
			super();
		}
		
		private var titleImg:Image;
		private var groupNameLab:Label;
		private var groupNameInput:TextInput;
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			groupNameLab = new Label();
			groupNameLab.text = '群名称:';
			groupNameLab.textAlign = TextAlign.RIGHT;
			groupNameLab.fontSize = 24;
			groupNameLab.color = 0x6f1614;
			groupNameLab.width = 200;
			groupNameLab.height = 40;
			addChild(groupNameLab);
			
			groupNameInput = new TextInput()
			groupNameInput.maxChars = 10;
			groupNameInput.textAlign = TextAlign.CENTER;
			groupNameInput.width = 300;
			groupNameInput.height = 36;
			groupNameInput.fontSize = 24;
			groupNameInput.color = 0x6f1614;
			groupNameInput.radius = 10;
			addChild(groupNameInput)
			
			titleImg = new Image()
			titleImg.width = 293
			titleImg.height = 86
			titleImg.source = 'assets/hall/guild_title_create.png'
			addRawChild(titleImg)
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			groupNameLab.x = 20;
			groupNameLab.y = 60;
			
			groupNameInput.x=groupNameLab.x+groupNameLab.width+10;
			groupNameInput.y = groupNameLab.y;
			
			titleImg.x = (width - titleImg.width) / 2
		}
		
		override protected function commitButton_clickHandler(event:MouseEvent):void {
			HttpApi.getInstane().addGroup({groupname: groupNameInput.text, fc: 0}, 
				function (e:Event):void {
					try
					{
						var response:Object = JSON.parse(e.currentTarget.data)
						if (response.code == 0) { 
							var group:Object = response.data
							// 创建群成功 把自己作为馆长身份加入进去
							HttpApi.getInstane().addGroupUser({ 
								gid: group.id, 
								uid: AppData.getInstane().user.id,
								fs: 10000000,
								ll: 4}, 
								function (ee:Event):void {
									var response2:Object = JSON.parse(ee.currentTarget.data)
									if (response2.code == 0) { 
										AppAlert.show('创建群成功')
										AppManager.getInstance().dispatchEvent(new AppManagerEvent(AppManagerEvent.CREATE_GROUP_SUCCESS));
										close()
									} else {
										AppAlert.show('创建群失败')
									}
								}) 
						} else {
							AppAlert.show('创建群失败')
						}
					} 
					catch(error:Error) 
					{
						AppAlert.show('创建群失败')
					}
				})
		}
	}
}