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
	
	public class AddScorePanel extends AppPanelSmall
	{
		public function AddScorePanel()
		{
			super();
			
			title = '增加玩家疲劳值'
		}
		
		public var targetUser:Object
		
		private var addScoreLab:Label;
		private var addScoreInput:TextInput
		private var fromUser:Object
		private var toUser:Object
		
		override protected function createChildren():void {
			super.createChildren()
			
			addScoreLab = new Label();
			addScoreLab.text = '增加疲劳值';
			addScoreLab.fontSize = 24;
			addScoreLab.color = 0x845525;
			addScoreLab.height = 40;
			addScoreLab.width = 150;
			addChild(addScoreLab);
			
			addScoreInput = new TextInput()
			addScoreInput.color = 0x845525;
			addScoreInput.textAlign = TextAlign.CENTER;
			addScoreInput.restrict = '0-9';
			addScoreInput.width = 300
//			addScoreInput.maxChars = 5;
			addScoreInput.height = 40;
			addScoreInput.fontSize = 24;
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
				AppSmallAlert.show('您没有权限操作');
				return
			}
			var score:Number = Number(addScoreInput.text)
			if (fromUser.fs >= score) {
				HttpApi.getInstane().addGroupUserScore(toUser.gid, toUser.uid, '', fromUser.uid, '', score, 
					function (e:Event):void {
						var response:Object = JSON.parse(e.currentTarget.data)
						if (response.code == 0) {
							AppSmallAlert.show('增加疲劳值成功');
							AppManager.getInstance().dispatchEvent(new AppManagerEvent(AppManagerEvent.UPDATE_MEMBER_INFO_SUCCESS));
							close()
						} else {
							AppSmallAlert.show('增加疲劳值失败');
						}
					},
					function (e:Event):void {
						AppSmallAlert.show('增加疲劳值失败');
					})
			} else {
				AppSmallAlert.show('您的疲劳值不足，无法为他人增加');
			}
		}
		
	}
}