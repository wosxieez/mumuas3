package com.xiaomu.view.group
{
	import com.xiaomu.component.AppAlert;
	import com.xiaomu.renderer.GroupUserMenuRender;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import coco.component.ButtonGroup;
	import coco.event.UIEvent;
	import coco.manager.PopUpManager;
	
	public class GroupRuleMenu extends ButtonGroup
	{
		public function GroupRuleMenu()
		{
			super();
			
			itemRendererClass = GroupUserMenuRender;
			itemRendererColumnCount = 1
			dataProvider = ['修改', '删除']
			width = 200
			height = dataProvider.length * 40
			addEventListener(UIEvent.CHANGE, this_changeHandler)
		}
		
		private static var instance:GroupRuleMenu
		
		public static function getInstane(): GroupRuleMenu {
			if (!instance) {
				instance = new GroupRuleMenu()
			}
			
			return instance
		}
		
		public var ruleData:Object
		private var action:int
		
		protected function this_changeHandler(event:UIEvent):void
		{
			action = selectedIndex
			setTimeout(function ():void {selectedIndex = -1}, 500)
			if (action == -1) return
			
			if (action == 0) {
				var settingRulePanel:SettingRulePanel = new SettingRulePanel()
				settingRulePanel.ruleData = ruleData
				settingRulePanel.open()
			} else if (action == 1) {
				// 获取到自己的群信息
				HttpApi.getInstane().getGroupUser({gid: AppData.getInstane().group.id, uid: AppData.getInstane().user.id}, 
					function (e:Event):void {
						try
						{
							var response:Object = JSON.parse(e.currentTarget.data)
							if (response.code == 0) {
								var me:Object = response.data[0]
								if (me && me.ll == 4) { // 只有馆长才能删除
									HttpApi.getInstane().removeRule({id: ruleData.id}, function (ee:Event):void {
										var response2:Object = JSON.parse(ee.currentTarget.data)
										if (response2.code == 0) {
											AppAlert.show('删除成功')
										} else {
											AppAlert.show('删除失败')
										}
									})
								} else {
									AppAlert.show('您没有权限操作')
								}
							}
						} 
						catch(error:Error) 
						{
						}
					})
			}
			
			PopUpManager.removePopUp(this)
		}
		
	}
}