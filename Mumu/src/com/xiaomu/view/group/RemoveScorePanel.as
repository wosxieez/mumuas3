package com.xiaomu.view.group
{
	import com.xiaomu.component.AppAlert;
	import com.xiaomu.component.AppPanelSmall;
	import com.xiaomu.component.AppSmallAlert;
	import com.xiaomu.event.AppManagerEvent;
	import com.xiaomu.manager.AppManager;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Label;
	import coco.component.TextAlign;
	import coco.component.TextInput;
	
	public class RemoveScorePanel extends AppPanelSmall
	{
		public function RemoveScorePanel()
		{
			super();
			
			title = '玩家下分'
		}
		
		public var targetUser:Object
		
		private var addScoreLab:Label;
		private var addScoreInput:TextInput
		private var fromUser:Object
		private var toUser:Object
		
		override protected function createChildren():void {
			super.createChildren()
			
			addScoreLab = new Label();
			addScoreLab.text = '减少分数';
			addScoreLab.fontSize = 24;
			addScoreLab.color = 0x845525;
			addScoreLab.height = 40;
			addScoreLab.width = 120;
			addChild(addScoreLab);
			
			addScoreInput = new TextInput()
			addScoreInput.color = 0x845525;
			addScoreInput.textAlign = TextAlign.CENTER;
			addScoreInput.restrict = '0-9';
			addScoreInput.width = 300
			addScoreInput.height = 40;
			addScoreInput.fontSize = 24;
			addScoreInput.maxChars = 5;
			addChild(addScoreInput)
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			addScoreLab.x = 40;
			addScoreLab.y = 60;
			
			addScoreInput.x = addScoreLab.x+addScoreLab.width+30;
			addScoreInput.y = addScoreLab.y;
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
				AppAlert.show('您没有权限操作')
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
										AppSmallAlert.show('下分成功',3.5)
										AppManager.getInstance().dispatchEvent(new AppManagerEvent(AppManagerEvent.UPDATE_MEMBER_INFO_SUCCESS));
										close()
									} else {
										AppSmallAlert.show('下分失败',3.5)
									}
								})
						} else {
							AppSmallAlert.show('下分失败',3.5)
						}
					})
			} else {
				AppSmallAlert.show('对方积分不足，下分失败',3.5)
			}
		}
		
	}
}


