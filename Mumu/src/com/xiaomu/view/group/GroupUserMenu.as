package com.xiaomu.view.group
{
	import com.xiaomu.component.AppAlert;
	import com.xiaomu.component.AppSmallAlert;
	import com.xiaomu.event.AppManagerEvent;
	import com.xiaomu.manager.AppManager;
	import com.xiaomu.renderer.GroupUserMenuRender;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import coco.component.Alert;
	import coco.component.ButtonGroup;
	import coco.event.UIEvent;
	import coco.manager.PopUpManager;
	
	public class GroupUserMenu extends ButtonGroup
	{
		public function GroupUserMenu()
		{
			super();
			
			itemRendererClass = GroupUserMenuRender;
			itemRendererHeight = 70;
			itemRendererColumnCount = 1
			gap = 5;
			width = 180
			addEventListener(UIEvent.CHANGE, this_changeHandler)
		}
		
		private static var instance:GroupUserMenu
		
		public static function getInstane(): GroupUserMenu {
			if (!instance) {
				instance = new GroupUserMenu()
			}
			
			return instance
		}
		
		private var _targetUser:Object
		
		public function get targetUser():Object
		{
			return _targetUser;
		}
		
		public function set targetUser(value:Object):void
		{
			_targetUser = value;
			checkDataProvider();
		}
		
		private var action:int 
		private var selectedStr :String
		private var fromUser:Object
		private var toUser:Object
		
		protected function this_changeHandler(event:UIEvent):void
		{
			trace("选则：",selectedItem); //['升职', '降职', '增加疲劳值', '减少疲劳值', '踢出群','单独提成值']
			selectedStr = selectedItem as String;
			action = selectedIndex
			setTimeout(function ():void {selectedIndex = -1}, 500)
			if (action == -1) return
			
			if (selectedStr == "增加疲劳值") {
				var addScorePanel:AddScorePanel = new AddScorePanel()
				addScorePanel.targetUser = targetUser
				addScorePanel.open()
				PopUpManager.removePopUp(this)
				return
			} else if (selectedStr == "减少疲劳值") {
				var removeScorePanel:RemoveScorePanel = new RemoveScorePanel()
				removeScorePanel.targetUser = targetUser
				removeScorePanel.open()
				PopUpManager.removePopUp(this)
				return
			}else if(selectedStr == "单独提成值"){
				//				trace("选则了设置单独提成值");
				
				var setSpecialTiChengPanel:SetSpecialTiChengPanel = new SetSpecialTiChengPanel()
				setSpecialTiChengPanel.targetUser = targetUser
				setSpecialTiChengPanel.open()
				PopUpManager.removePopUp(this)
			}else if(selectedStr == "设置昵称"){
				var setNickNamePanel:SetNickNamePanel = new SetNickNamePanel()
				setNickNamePanel.targetUser = targetUser
				setNickNamePanel.open()
				PopUpManager.removePopUp(this)
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
			if(selectedStr== "升职")
			{
				AppAlert.show('是否确定将此玩家降职', '',Alert.OK|Alert.CANCEL, function (e:UIEvent):void {
					if (e.detail == Alert.OK) {
						if (fromUser.ll > toUser.ll + 1) {
							HttpApi.getInstane().updateGroupUser({
								update: {ll: toUser.ll + 1,pid: AppData.getInstane().user.id}, 
								query: {gid: toUser.gid, uid: toUser.uid}
							},
								function (e:Event):void {
									var response:Object = JSON.parse(e.currentTarget.data)
									if (response.code == 0) {
										AppSmallAlert.show('升职成功')
										AppManager.getInstance().dispatchEvent(new AppManagerEvent(AppManagerEvent.UPDATE_MEMBER_INFO_SUCCESS));
									} else {
										AppSmallAlert.show('升职失败')
									}
								})
						} else {
							AppSmallAlert.show('无法再升职了')
						}
					}},null);
			}
			else if(selectedStr== "降职")
			{
				AppAlert.show('是否确定将此玩家降职', '',Alert.OK|Alert.CANCEL, function (e:UIEvent):void {
					if (e.detail == Alert.OK) {
						if (toUser.ll > 0) {
							HttpApi.getInstane().updateGroupUser({
								update: {ll: toUser.ll - 1,pid: AppData.getInstane().user.id}, 
								query: {gid: toUser.gid, uid: toUser.uid}
							},
								function (e:Event):void {
									var response:Object = JSON.parse(e.currentTarget.data)
									if (response.code == 0) {
										AppSmallAlert.show('降职成功')
										AppManager.getInstance().dispatchEvent(new AppManagerEvent(AppManagerEvent.UPDATE_MEMBER_INFO_SUCCESS));
									} else {
										AppSmallAlert.show('降职失败')
									}
								})
						} else {
							AppSmallAlert.show('无法再降职了')
						}
					}},null);
			}
			else if(selectedStr== "踢出群")
			{
				AppAlert.show('是否确定将此玩家提出群', '',Alert.OK|Alert.CANCEL, function (e:UIEvent):void {
					if (e.detail == Alert.OK) {
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
												AppSmallAlert.show('踢出成功')
												AppManager.getInstance().dispatchEvent(new AppManagerEvent(AppManagerEvent.CHANGE_MEMBER_SUCCESS));
											} else {
												AppSmallAlert.show('踢出失败')
											}
										})
									} else {
										AppSmallAlert.show('踢出失败')
									}
								})
						} else {
							AppSmallAlert.show('您没有权限操作')
						}
					} else {
						trace('cancel');
					}
				})
			}
			PopUpManager.removePopUp(this)
		}
		
		/**
		 * 获取数据，对等级进行判断
		 */
		private function checkDataProvider():void
		{
			//				trace(JSON.stringify(targetUser));
			trace("你在这个群的等级：",AppData.getInstane().groupLL,"操作对象等级：",targetUser.ll);
			if((targetUser.ll==2||targetUser.ll==1)&&(AppData.getInstane().groupLL==4)){
				trace("你是馆主，且操作对象是一二级管理员，可以设置单独的提成");
				dataProvider=['升职', '降职', '增加疲劳值', '减少疲劳值', '踢出群','单独提成值', '设置昵称']
			}else if((targetUser.ll==3)&&(AppData.getInstane().groupLL==4)){
				trace("你是馆主，且操作对象是副馆主");
				dataProvider=['降职', '增加疲劳值', '减少疲劳值', '踢出群', '设置昵称']
			}
			else if((targetUser.ll==0)&&(AppData.getInstane().groupLL==4)){
				trace("你是馆主，且操作对象是普通成员");
				dataProvider=['升职', '增加疲劳值', '减少疲劳值', '踢出群', '设置昵称']
			}
			else if((targetUser.ll==0||targetUser.ll==1)&&(AppData.getInstane().groupLL==3)){
				trace("你是副馆主，且操作对象是普通成员或二级管理员");
				dataProvider=['升职', '降职', '增加疲劳值', '减少疲劳值', '设置昵称']
			}else if((targetUser.ll==2)&&(AppData.getInstane().groupLL==3)){
				trace("你是副馆主，且操作对象是一级管理员");
				dataProvider=['降职', '增加疲劳值', '减少疲劳值', '设置昵称']
			}else if((targetUser.ll>=3)&&(AppData.getInstane().groupLL==3)){
				trace("你是副馆主，且操作对象等级是大于自身");
				dataProvider=[]
			}
			else if((targetUser.ll==0)&&(AppData.getInstane().groupLL==2)) {
				trace("你是一级管理员，且操作对象是普通成员，只可以上下分,升职");
				dataProvider=['升职', '增加疲劳值', '减少疲劳值', '设置昵称']
			}
			else if((targetUser.ll==1)&&(AppData.getInstane().groupLL==2)) {
				trace("你是一级管理员，且操作对象二级管理员，只可以上下分,降职");
				dataProvider=['降职', '增加疲劳值', '减少疲劳值', '设置昵称']
			}
			else if((targetUser.ll>=2)&&(AppData.getInstane().groupLL==2)) {
				trace("你是一级管理员，且操作对象等级是大于自身");
				dataProvider=[]
			}
			else if((targetUser.ll==0)&&(AppData.getInstane().groupLL==1)) {
				trace("你是二级管理员，且操作对象是普通成员，只可以上下分");
				dataProvider=['增加疲劳值', '减少疲劳值', '设置昵称']
			}else if((targetUser.ll>=1)&&(AppData.getInstane().groupLL==1)) {
				trace("你是二级管理员，且操作对象等级是大于自身");
				dataProvider=[]
			}
			else if((targetUser.ll==4)){
				dataProvider=[]
			}
			height = dataProvider.length * itemRendererHeight+(dataProvider.length-1)*gap
		}
		
	}
}