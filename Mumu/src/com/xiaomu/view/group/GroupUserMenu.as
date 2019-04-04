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
	
	public class GroupUserMenu extends ButtonGroup
	{
		public function GroupUserMenu()
		{
			super();
			
			itemRendererClass = GroupUserMenuRender;
			itemRendererHeight = 80;
			itemRendererColumnCount = 1
			gap = 5;
			dataProvider = ['升职', '降职', '增加疲劳值', '减少疲劳值', '踢出群']
			width = 200
			height = dataProvider.length * itemRendererHeight+(dataProvider.length-1)*gap
			addEventListener(UIEvent.CHANGE, this_changeHandler)
		}
		
		private static var instance:GroupUserMenu
		
		public static function getInstane(): GroupUserMenu {
			if (!instance) {
				instance = new GroupUserMenu()
			}
			
			return instance
		}
		
		public var targetUser:Object
		
		private var action:int 
		private var fromUser:Object
		private var toUser:Object
		
		protected function this_changeHandler(event:UIEvent):void
		{
			action = selectedIndex
			setTimeout(function ():void {selectedIndex = -1}, 500)
			if (action == -1) return
			
			if (action == 2) {
				var addScorePanel:AddScorePanel = new AddScorePanel()
				addScorePanel.targetUser = targetUser
				addScorePanel.open()
				PopUpManager.removePopUp(this)
				return
			} else if (action == 3) {
				var removeScorePanel:RemoveScorePanel = new RemoveScorePanel()
				removeScorePanel.targetUser = targetUser
				removeScorePanel.open()
				PopUpManager.removePopUp(this)
				return
			}
			
			// 获取到自己的群信息
			HttpApi.getInstane().getGroupUser({gid: AppData.getInstane().group.id, uid: AppData.getInstane().user.id}, 
				function (e:Event):void {
					try
					{
						var response:Object = JSON.parse(e.currentTarget.data)
						if (response.code == 0) {
							fromUser = response.data[0]
							HttpApi.getInstane().getGroupUser({gid: targetUser.gid, uid: targetUser.uid}, 
								function (ee:Event):void {
									var response2:Object = JSON.parse(ee.currentTarget.data)
									if (response2.code == 0) {
										toUser = response2.data[0]
										doAction()
									}
								})
						}
					} 
					catch(error:Error) 
					{
					}
				})
		}
		
		private function doAction():void {
			switch(action)
			{
				case 0:
				{
					if (fromUser.uid == toUser.pid) {
						if (fromUser.ll > toUser.ll + 1) {
							HttpApi.getInstane().updateGroupUser({
								update: {ll: toUser.ll + 1}, 
								query: {gid: toUser.gid, uid: toUser.uid}
							},
								function (e:Event):void {
									var response:Object = JSON.parse(e.currentTarget.data)
									if (response.code == 0) {
										AppAlert.show('升职成功')
									} else {
										AppAlert.show('升职失败')
									}
								})
						} else {
							AppAlert.show('无法再升职了')
						}
					} else {
						AppAlert.show('您没有权限操作')
					}
					break;
				}
				case 1:
				{
					if (fromUser.uid == toUser.pid) {
						if (toUser.ll > 0) {
							HttpApi.getInstane().updateGroupUser({
								update: {ll: toUser.ll - 1}, 
								query: {gid: toUser.gid, uid: toUser.uid}
							},
								function (e:Event):void {
									var response:Object = JSON.parse(e.currentTarget.data)
									if (response.code == 0) {
										AppAlert.show('降职成功')
									} else {
										AppAlert.show('降职失败')
									}
								})
						} else {
							AppAlert.show('无法再降职了')
						}
					} else {
						AppAlert.show('您没有权限操作')
					}
					break;
				}
				case 4:
				{
					// 替人操作
					if (fromUser.ll == 4) {
						HttpApi.getInstane().updateGroupUser({
							update: {fs: fromUser.fs + toUser.fs}, 
							query: {gid: fromUser.gid, uid: fromUser.uid}
						},
							function (e:Event):void {
								var response:Object = JSON.parse(e.currentTarget.data)
								if (response.code == 0) {
									HttpApi.getInstane().removeGroupUser({gid: toUser.gid, uid: toUser.uid}, function (ee:Event):void {
										var response2:Object = JSON.parse(ee.currentTarget.data)
										if (response2.code == 0) {
											AppAlert.show('踢出成功')
										} else {
											AppAlert.show('踢出失败')
										}
									})
								} else {
									AppAlert.show('踢出失败')
								}
							})
					} else {
						AppAlert.show('您没有权限操作')
					}
					break;
				}
				default:
				{
					break;
				}
			}
			
			PopUpManager.removePopUp(this)
		}
		
	}
}