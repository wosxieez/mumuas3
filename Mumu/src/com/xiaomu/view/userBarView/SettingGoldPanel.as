package com.xiaomu.view.userBarView
{
	import com.xiaomu.event.AppManagerEvent;
	import com.xiaomu.manager.AppManager;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Alert;
	import coco.component.Button;
	import coco.component.Label;
	import coco.component.TextAlign;
	import coco.component.TextInput;
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	
	/**
	 * 设置群主自身的金币
	 */
	public class SettingGoldPanel extends UIComponent
	{
		public function SettingGoldPanel()
		{
			super();
			width = 320
			height = 120
		}
		
		private var titleHeigh:Number = 50;
		private var titleLab:Label;
		private var goldLab:Label;
		private var goldNumberTextInput:TextInput;
		private var okBtn:Button;
		private var cancelBtn:Button;
		private var _data:Object;
		
		public function get data():Object
		{
			return _data;
		}
		
		public function set data(value:Object):void
		{
			_data = value;
			invalidateProperties();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			titleLab = new Label();
			titleLab.width = width;
			titleLab.text = '群主金币设置';
			titleLab.fontSize = 24;
			titleLab.height = 40;
			titleLab.color = 0xffffff;
			addChild(titleLab);
			
			goldLab = new Label();
			goldLab.width = 80;
			goldLab.height = 40;
			goldLab.textAlign = TextAlign.LEFT;
			goldLab.text = '金币数:';
			goldLab.fontSize = 20;
			goldLab.color = 0xffffff;
			addChild(goldLab);
			
			goldNumberTextInput = new TextInput();
			goldNumberTextInput.fontSize = 20;
			goldNumberTextInput.height = 40;
			addChild(goldNumberTextInput)
			
			okBtn = new Button();
			okBtn.width = 60
			okBtn.height = 30
			okBtn.label = "确定"
			okBtn.fontSize = 20
			okBtn.addEventListener(MouseEvent.CLICK,okBtnHandler);
			addChild(okBtn);
			
			cancelBtn = new Button();
			cancelBtn.width = 60
			cancelBtn.height = 30
			cancelBtn.label = "取消"
			cancelBtn.fontSize = 20
			cancelBtn.addEventListener(MouseEvent.CLICK,cancelBtnHandler);
			addChild(cancelBtn);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			goldNumberTextInput.text = data.gold;
//			trace('user_id:',data.userId,'group_id',data.groupId,'gold',goldNumberTextInput.text,'user_name',data.userName);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			titleLab.y = (titleHeigh-titleLab.height)/2
			
			goldLab.x = 10;
			goldLab.y = 10+titleHeigh;
			goldNumberTextInput.x = goldLab.x+goldLab.width+5;
			goldNumberTextInput.y = goldLab.y;
			goldNumberTextInput.width = width-goldNumberTextInput.x-60
			
			okBtn.y = height+titleHeigh-okBtn.height-5;
			okBtn.x = width/2-okBtn.width-10;
			cancelBtn.y = okBtn.y;
			cancelBtn.x = width/2+10;
		}
		
		override protected function drawSkin():void {
			graphics.clear()
			graphics.beginFill(0x000000, 0.7)
			graphics.drawRoundRect(0, 0, width, height+titleHeigh, 5, 5)
			graphics.endFill()
			graphics.beginFill(0x000000)
			graphics.drawRoundRect(0, 0, width, titleHeigh, 5, 5)
			graphics.endFill()
		}
		
		protected function cancelBtnHandler(event:MouseEvent):void
		{
			PopUpManager.removeAllPopUp();
		}
		
		protected function okBtnHandler(event:MouseEvent):void
		{
			///user_id: 2 group_id 29 gold 200 user_name fangchao
			PopUpManager.removeAllPopUp();
			if(parseInt(goldNumberTextInput.text)||parseInt(goldNumberTextInput.text)==0){
				HttpApi.getInstane().getUserInfoById(data.userId,function(e:Event):void{
					var group_info_str : String = JSON.parse(e.currentTarget.data).message[0].group_info;
					var group_info:Array = JSON.parse(group_info_str) as Array
					for each (var i:Object in group_info) 
					{
						if(i.group_id==data.groupId){
							i.gold=parseInt(goldNumberTextInput.text);
						}
					}
//					trace('最新金币数据：',JSON.stringify(group_info));
					HttpApi.getInstane().updateUserGroupInfo(data.userName,group_info,function(e:Event):void{
						if(JSON.parse(e.currentTarget.data).result==0){
							Alert.show('金币更新成功');
							AppManager.getInstance().dispatchEvent(new AppManagerEvent(AppManagerEvent.UPDATE_ADMIN_GOLD_SUCCESS));
						}
					},null);
					
				},null);
			}else{
				Alert.show('不是有效数字');
			}
		}
	}
}