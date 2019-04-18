package com.xiaomu.view.group
{
	import com.xiaomu.component.AppPanelSmall;
	import com.xiaomu.component.AppSmallAlert;
	import com.xiaomu.event.AppManagerEvent;
	import com.xiaomu.manager.AppManager;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Label;
	import coco.component.TextAlign;
	import coco.component.TextInput;
	
	/**
	 * 设置独立提成界面
	 */
	public class SetNickNamePanel extends AppPanelSmall
	{
		public function SetNickNamePanel()
		{
			super();
			title = '设置昵称'
		}
		
		
		private var _targetUser:Object
		
		public function get targetUser():Object
		{
			return _targetUser;
		}
		
		public function set targetUser(value:Object):void
		{
			_targetUser = value;
			invalidateProperties();
		}
		
		private var addScoreLab:Label;
		private var addScoreInput:TextInput
		private var fromUser:Object
		private var toUser:Object
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			addScoreLab = new Label();
			addScoreLab.text = '用户昵称';
			addScoreLab.fontSize = 24;
			addScoreLab.color = 0x845525;
			addScoreLab.height = 40;
			addScoreLab.width = 120;
			addChild(addScoreLab);
			
			addScoreInput = new TextInput()
			addScoreInput.color = 0x845525;
			addScoreInput.textAlign = TextAlign.CENTER;
			addScoreInput.width = 300
			addScoreInput.height = 40;
			addScoreInput.fontSize = 24;
			addScoreInput.maxChars = 5;
			addChild(addScoreInput)
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			addScoreInput.text = targetUser.nn?targetUser.nn+'':'';
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
			//			trace("设置特殊提成值",JSON.stringify(targetUser));
			//			trace("id:",targetUser.id,"uid:",targetUser.uid,"username:",targetUser.username,"ll:",targetUser.ll,"tc",addScoreInput.text);
			HttpApi.getInstane().updateGroupUser({
				update: {nn: addScoreInput.text }, 
				query: {id:targetUser.id}
			},function(e:Event):void{
				var response:Object = JSON.parse(e.currentTarget.data)
				if (response.code == 0) {
					close();
					AppSmallAlert.show('设置成功')
					AppManager.getInstance().dispatchEvent(new AppManagerEvent(AppManagerEvent.UPDATE_MEMBER_INFO_SUCCESS));
				}
			},null)
		}
		
		
	}
}