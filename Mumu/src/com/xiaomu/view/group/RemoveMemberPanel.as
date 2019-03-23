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
			width = 200
			height = 160
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
			titleLab.fontSize = 20;
			addChild(titleLab);
			
			okBtn =  new Button();
			okBtn.width = 60;
			okBtn.height = 28;
			okBtn.label = '确认';
			okBtn.fontSize = 16;
			okBtn.addEventListener(MouseEvent.CLICK,okBtnHandler);
			addChild(okBtn);
			
			cancelBtn =  new Button();
			cancelBtn.width = 60;
			cancelBtn.height = 28;
			cancelBtn.label = '取消';
			cancelBtn.fontSize = 16;
			cancelBtn.addEventListener(MouseEvent.CLICK,cancelBtnHandler);
			addChild(cancelBtn);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			titleLab.width = width;
			titleLab.y = 10;
			
			cancelBtn.x = (width-cancelBtn.width)/2;
			cancelBtn.y = height-cancelBtn.height-20;
			
			okBtn.x = (width-okBtn.width)/2;
			okBtn.y = cancelBtn.y-okBtn.height-20;
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