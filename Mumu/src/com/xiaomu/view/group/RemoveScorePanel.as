package com.xiaomu.view.group
{
	import com.xiaomu.component.AppPanelBig;
	import com.xiaomu.component.TitleTextInput;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Alert;
	import coco.layout.VerticalLayout;
	
	public class RemoveScorePanel extends AppPanelBig
	{
		public function RemoveScorePanel()
		{
			super();
			
			title = '玩家下分'
			var vl:VerticalLayout = new VerticalLayout()
			layout = vl
		}
		
		public var targetUser:Object
		
		private var addScoreInput:TitleTextInput
		private var fromUser:Object
		private var toUser:Object
		
		override protected function createChildren():void {
			super.createChildren()
			
			addScoreInput = new TitleTextInput()
			addScoreInput.width = 500
			addScoreInput.title = '减少分数'
			addChild(addScoreInput)
		}
		
		override protected function commitButton_clickHandler(event:MouseEvent):void {
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
			if (fromUser.ll != 4 && fromUser.ll != 3 && fromUser.uid != toUser.pid) {
				Alert.show('您没有权限操作')
				return
			}
			var score:Number = Number(addScoreInput.text)
			if (toUser.fs >= score) {
				HttpApi.getInstane().updateGroupUser({
					update: {fs: toUser.fs - score}, 
					query: {gid: toUser.gid, uid: toUser.uid}
				},
					function (e:Event):void {
						var response:Object = JSON.parse(e.currentTarget.data)
						if (response.code == 0) {
							
							HttpApi.getInstane().updateGroupUser({
								update: {fs: fromUser.fs + score}, 
								query: {gid: fromUser.gid, uid: fromUser.uid}
							},
								function (ee:Event):void {
									var response2:Object = JSON.parse(ee.currentTarget.data)
									if (response2.code == 0) {
										Alert.show('下分成功')
										close()
									} else {
										Alert.show('下分失败')
									}
								})
						} else {
							Alert.show('下分失败')
						}
					})
			} else {
				Alert.show('对方积分不足，下分失败')
			}
		}
		
	}
}


