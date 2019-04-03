package com.xiaomu.view.group
{
	import com.xiaomu.component.AppPanelSmall;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Alert;
	import coco.component.Label;
	import coco.component.TextInput;
	
	public class AddScorePanel extends AppPanelSmall
	{
		public function AddScorePanel()
		{
			super();
			
			title = '玩家上分'
		}
		
		public var targetUser:Object
		
		private var addScoreLab:Label;
		private var addScoreInput:TextInput
		private var fromUser:Object
		private var toUser:Object
		
		override protected function createChildren():void {
			super.createChildren()
			
			addScoreLab = new Label();
			addScoreLab.text = '增加分数';
			addScoreLab.fontSize = 24;
			addScoreLab.color = 0x845525;
			addScoreLab.height = 40;
			addScoreLab.width = 120;
			addChild(addScoreLab);
			
			addScoreInput = new TextInput()
			addScoreInput.restrict = '0-9';
			addScoreInput.width = 300
			addScoreInput.maxChars = 5;
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
				Alert.show('您没有权限操作')
				return
			}
			var score:Number = Number(addScoreInput.text)
			if (fromUser.fs >= score) {
				HttpApi.getInstane().updateGroupUser({
					update: {fs: toUser.fs + score}, 
					query: {gid: toUser.gid, uid: toUser.uid}
				},
					function (e:Event):void {
						var response:Object = JSON.parse(e.currentTarget.data)
						if (response.code == 0) {
							
							HttpApi.getInstane().updateGroupUser({
								update: {fs: fromUser.fs - score}, 
								query: {gid: fromUser.gid, uid: fromUser.uid}
							},
								function (ee:Event):void {
									var response2:Object = JSON.parse(ee.currentTarget.data)
									if (response2.code == 0) {
										Alert.show('上分成功')
										close()
									} else {
										Alert.show('上分失败')
									}
								})
						} else {
							Alert.show('上分失败')
						}
					})
			} else {
				Alert.show('您的积分不足，无法上分')
			}
		}
		
	}
}