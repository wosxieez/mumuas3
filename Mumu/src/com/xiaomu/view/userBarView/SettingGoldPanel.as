package com.xiaomu.view.userBarView
{
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
	 * 设置用户的金币
	 */
	public class SettingGoldPanel extends UIComponent
	{
		public function SettingGoldPanel()
		{
			super();
			width = 160
			height = 60
		}
		
		private var titleHeigh:Number = 30;
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
			titleLab.fontSize = 12;
			titleLab.height = 20;
			titleLab.color = 0xffffff;
			addChild(titleLab);
			
			goldLab = new Label();
			goldLab.width = 40;
			goldLab.height = 20;
			goldLab.textAlign = TextAlign.LEFT;
			goldLab.text = '金币数:';
			goldLab.fontSize = 10;
			goldLab.color = 0xffffff;
			addChild(goldLab);
			
			goldNumberTextInput = new TextInput();
			goldNumberTextInput.fontSize = 10;
			goldNumberTextInput.height = 20;
			addChild(goldNumberTextInput)
			
			okBtn = new Button();
			okBtn.width = 30
			okBtn.height = 15
			okBtn.label = "确定"
			okBtn.fontSize = 10
			okBtn.addEventListener(MouseEvent.CLICK,okBtnHandler);
			addChild(okBtn);
			
			cancelBtn = new Button();
			cancelBtn.width = 30
			cancelBtn.height = 15
			cancelBtn.label = "取消"
			cancelBtn.fontSize = 10
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
			
			goldLab.x = 5;
			goldLab.y = 5+titleHeigh;
			goldNumberTextInput.x = goldLab.x+goldLab.width+5;
			goldNumberTextInput.y = goldLab.y;
			goldNumberTextInput.width = width-goldNumberTextInput.x-30
			
			okBtn.y = height+titleHeigh-okBtn.height-5;
			okBtn.x = width/2-okBtn.width-5;
			cancelBtn.y = okBtn.y;
			cancelBtn.x = width/2+5;
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
						}
					},null);
					
				},null);
			}else{
				Alert.show('不是有效数字');
			}
		}
	}
}