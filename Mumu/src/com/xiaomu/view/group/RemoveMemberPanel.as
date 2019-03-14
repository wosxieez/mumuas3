package com.xiaomu.view.group
{
	import com.xiaomu.event.AppManagerEvent;
	import com.xiaomu.manager.AppManager;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Alert;
	import coco.component.Button;
	import coco.component.Label;
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	
	public class RemoveMemberPanel extends UIComponent
	{
		public function RemoveMemberPanel()
		{
			super();
			width = 100
			height = 80
		}
		
		private var titleLab:Label;
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
		}

		override protected function createChildren():void
		{
			super.createChildren();
			
			titleLab = new Label();
			titleLab.text = '确认移除吗？';
			titleLab.color = 0xffffff;
			titleLab.fontSize = 10;
			addChild(titleLab);
			
			okBtn =  new Button();
			okBtn.width = 30;
			okBtn.height = 14;
			okBtn.label = '确认';
			okBtn.fontSize = 8;
			okBtn.addEventListener(MouseEvent.CLICK,okBtnHandler);
			addChild(okBtn);
			
			cancelBtn =  new Button();
			cancelBtn.width = 30;
			cancelBtn.height = 14;
			cancelBtn.label = '取消';
			cancelBtn.fontSize = 8;
			cancelBtn.addEventListener(MouseEvent.CLICK,cancelBtnHandler);
			addChild(cancelBtn);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			titleLab.width = width;
			titleLab.y = 5;
			
			cancelBtn.x = (width-cancelBtn.width)/2;
			cancelBtn.y = height-cancelBtn.height-10;
			
			okBtn.x = (width-okBtn.width)/2;
			okBtn.y = cancelBtn.y-okBtn.height-10;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0x000000,0.8);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
		
		protected function cancelBtnHandler(event:MouseEvent):void
		{
			PopUpManager.removePopUp(this);
		}
		
		protected function okBtnHandler(event:MouseEvent):void
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