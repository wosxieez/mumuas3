package com.xiaomu.view.group
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
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	import coco.util.FontFamily;
	
	public class RemoveMemberPanel extends UIComponent
	{
		public function RemoveMemberPanel()
		{
			super();
			width = 915;
			height = 518;
		}
		
		private var bgImg:Image;
		private var titleImg:Image;
		private var okImg:ImageButton;
		private var cancelImg:ImageButton;
		private var lab:Label;
		private var _data:Object;

		public function get data():Object
		{
			return _data;
		}

		public function set data(value:Object):void
		{
			_data = value;
		}

		override protected function createChildren():void
		{
			super.createChildren();
			
//			titleLab = new Label();
//			titleLab.text = '确认移除吗？';
//			titleLab.color = 0xffffff;
//			titleLab.fontSize = 20;
//			addChild(titleLab);
			
//			okBtn =  new Button();
//			okBtn.width = 60;
//			okBtn.height = 28;
//			okBtn.label = '确认';
//			okBtn.fontSize = 16;
//			okBtn.addEventListener(MouseEvent.CLICK,okBtnHandler);
//			addChild(okBtn);
//			
//			cancelBtn =  new Button();
//			cancelBtn.width = 60;
//			cancelBtn.height = 28;
//			cancelBtn.label = '取消';
//			cancelBtn.fontSize = 16;
//			cancelBtn.addEventListener(MouseEvent.CLICK,cancelBtnHandler);
//			addChild(cancelBtn);
			
			bgImg = new Image();
			bgImg.source = 'assets/home/popUp/bac_04.png';
			bgImg.width = width;
			bgImg.height = height;
			addChild(bgImg);
			
			titleImg = new Image();
			titleImg.source = 'assets/home/popUp/Tishi.png';
			titleImg.width = 293;
			titleImg.height = 86;
			addChild(titleImg);
			
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
			
			lab = new Label();
			lab.width = 500;
			lab.height = 40;
			lab.text = '确定删除该成员吗？';
			lab.color = 0x6f1614;
			lab.fontFamily = FontFamily.MICROSOFT_YAHEI;
			lab.fontSize = 32;
			addChild(lab);
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
			
			lab.x = (width-lab.width)/2;
			lab.y = 150;
		}
		
		protected function cancelImgHandler(event:MouseEvent):void
		{
			PopUpManager.removePopUp(this);
		}
		
		protected function okImgHandler(event:MouseEvent):void
		{
			if(data.gold>0){
				Alert.show('该用户余额:'+data.gold);
				PopUpManager.removePopUp(this);
				return
			}else{
				doRemoveHandler();
			}
			PopUpManager.removeAllPopUp();
		}
		
		private function doRemoveHandler():void
		{
			HttpApi.getInstane().getUserInfoByName(data.username,function(e:Event):void{
				var group_info_str : String = JSON.parse(e.currentTarget.data).message[0].group_info;
				var group_info:Array = JSON.parse(group_info_str) as Array
				var newTempArr:Array = [];
//				trace('用户组信息：'+JSON.stringify(group_info));
//				trace('传递值：',JSON.stringify(data));
				for each (var i:Object in group_info) 
				{
					if(i.group_id!=data.group_id){
						newTempArr.push(i)
					}
				}
				///更新该用户在数据库中的组信息
				HttpApi.getInstane().updateUserGroupInfo(data.username,newTempArr,function(e:Event):void{
					var message:String = JSON.parse(e.currentTarget.data).message;
					if(JSON.parse(e.currentTarget.data).result==0){
						Alert.show('移除成员成功');
						AppManager.getInstance().dispatchEvent(new AppManagerEvent(AppManagerEvent.CHANGE_MEMBER_SUCCESS));
					}else{
						Alert.show('移除成员失败')
					}
				},null)
			},null);
		}
		
	}
}