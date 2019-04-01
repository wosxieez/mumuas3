package com.xiaomu.view.hall.popUpPanel
{
	import com.xiaomu.component.AppPanelSmall;
	import com.xiaomu.component.TitleTextInput;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Alert;
	
	/**
	 * 创建亲友圈，交互框
	 */
	public class AddGroupPanel extends AppPanelSmall
	{
		public function AddGroupPanel()
		{
			super();
		}
		
		private var groupNameInput:TitleTextInput;
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			groupNameInput = new TitleTextInput()
			groupNameInput.title = '群名称'
			addChild(groupNameInput)
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			groupNameInput.width = contentWidth
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
										Alert.show('创建群成功')
										close()
									} else {
										Alert.show('创建群失败')
									}
								}) 
						} else {
							Alert.show('创建群失败')
						}
					} 
					catch(error:Error) 
					{
						Alert.show('创建群失败')
					}
				})
		}
	}
}