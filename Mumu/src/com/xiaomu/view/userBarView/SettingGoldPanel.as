package com.xiaomu.view.userBarView
{
	import com.xiaomu.component.ImageButton;
	import com.xiaomu.event.AppManagerEvent;
	import com.xiaomu.manager.AppManager;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Alert;
	import coco.component.Button;
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextAlign;
	import coco.component.TextInput;
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	import coco.util.FontFamily;
	
	/**
	 * 设置群主自身的金币
	 */
	public class SettingGoldPanel extends UIComponent
	{
		public function SettingGoldPanel()
		{
			super();
			width = 915;
			height = 518;
		}
		
		
		private var bgImg:Image;
		private var titleImg:Image;
		
		private var goldLab:Label;
		private var goldNumberTextInput:TextInput;
		private var okImg:ImageButton;
		private var cancelImg:ImageButton;
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
			
			bgImg = new Image();
			bgImg.source = 'assets/home/popUp/bac_04.png';
			bgImg.width = width;
			bgImg.height = height;
			addChild(bgImg);
			
			titleImg = new Image();
			titleImg.source = 'assets/home/popUp/shezhi.png';
			titleImg.width = 293;
			titleImg.height = 86;
			addChild(titleImg);
			
			goldLab = new Label();
			goldLab.text = '金币数:';
			goldLab.fontFamily = FontFamily.MICROSOFT_YAHEI;
			goldLab.color = 0x6f1614;
			goldLab.fontSize = 32;
			goldLab.width = 120;
			goldLab.height = 30;
			addChild(goldLab);
			
			goldNumberTextInput = new TextInput();
			goldNumberTextInput.maxChars = 5;
			goldNumberTextInput.radius = 10;
			goldNumberTextInput.fontFamily = FontFamily.MICROSOFT_YAHEI;
			goldNumberTextInput.color = 0x6f1614;
			goldNumberTextInput.fontSize = 32;
			goldNumberTextInput.width = 300;
			goldNumberTextInput.height = 50;
			addChild(goldNumberTextInput)
			
			okImg = new ImageButton();
			okImg.upImageSource = 'assets/home/popUp/btn_confirm_normal.png';
			okImg.downImageSource = 'assets/home/popUp/btn_confirm_press.png';
			okImg.width = 166;
			okImg.height = 70;
			okImg.addEventListener(MouseEvent.CLICK,okImgHandler);
			addChild(okImg);
			
			cancelImg = new ImageButton();
			cancelImg.upImageSource = 'assets/home/popUp/Z_cancelNormal.png';
			cancelImg.downImageSource = 'assets/home/popUp/Z_cancelPress.png';
			cancelImg.width = 166;
			cancelImg.height = 70;
			cancelImg.addEventListener(MouseEvent.CLICK,cancelImgHandler);
			addChild(cancelImg);
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
			
			bgImg.x = bgImg.y = 0;
			titleImg.x = (width-titleImg.width)/2;
			titleImg.y = 0;
			
			okImg.x = width/2-okImg.width-20;
			okImg.y = height-okImg.height-20
			
			cancelImg.x = width/2+20;
			cancelImg.y = okImg.y
			
			goldLab.x = 170;
			goldLab.y = 150;
			
			goldNumberTextInput.x = goldLab.x+goldLab.width+20;
			goldNumberTextInput.y = goldLab.y-(goldNumberTextInput.height-goldLab.height)/2;
		}
		
		protected function cancelImgHandler(event:MouseEvent):void
		{
			PopUpManager.removeAllPopUp();
		}
		
		protected function okImgHandler(event:MouseEvent):void
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
							AppAlert.show('金币更新成功');
							AppManager.getInstance().dispatchEvent(new AppManagerEvent(AppManagerEvent.UPDATE_ADMIN_GOLD_SUCCESS));
						}
					},null);
					
				},null);
			}else{
				AppAlert.show('不是有效数字');
			}
		}
	}
}