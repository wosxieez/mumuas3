package com.xiaomu.view.hall.popUpPanel
{
	import com.xiaomu.event.AppManagerEvent;
	import com.xiaomu.itemRender.CircleItemRender;
	import com.xiaomu.manager.AppManager;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Alert;
	import coco.component.Button;
	import coco.component.ButtonGroup;
	import coco.component.Label;
	import coco.component.TextAlign;
	import coco.component.TextInput;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	import coco.manager.PopUpManager;
	
	/**
	 * 创建亲友圈，交互框
	 */
	public class CreateGroupPanel extends UIComponent
	{
		public function CreateGroupPanel()
		{
			super();
		}
		
		
		private var groupNameLab:Label;
		private var groupNameInput:TextInput;
		private var playerNumLab:Label;
		private var playerNumberBtnGroup:ButtonGroup;
		private var topValueLab:Label;
		private var topValueBtnGroup:ButtonGroup;
		private var playMethodLab:Label;
		private var playMethodBtnGroup:ButtonGroup;
		
		private var mainPanelView:MainPanelView;
		
		private var okBtn : Button;
		private var cancelBtn : Button;
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			groupNameLab = new Label();
			groupNameLab.text = '群名:';
			groupNameLab.width = 40;
			groupNameLab.height = 20;
			addChild(groupNameLab);
			
			groupNameInput = new TextInput();
			groupNameInput.textAlign = TextAlign.CENTER;
			groupNameInput.maxChars = 15;
			groupNameInput.height = 20;
			addChild(groupNameInput);
			
			/*mainPanelView = new MainPanelView();
			addChild(mainPanelView);*/
			
			playerNumLab = new Label();
			playerNumLab.text = '人数:';
			playerNumLab.width = 40;
			playerNumLab.height = 20;
			addChild(playerNumLab);
			
			playerNumberBtnGroup = new ButtonGroup();
			playerNumberBtnGroup.width = 300;
			playerNumberBtnGroup.height = 100;
			playerNumberBtnGroup.x = 40;
			playerNumberBtnGroup.y = 100;
			playerNumberBtnGroup.dataProvider = [{'name':'两人'},{'name':'三人'}];
			playerNumberBtnGroup.gap = 20;
			playerNumberBtnGroup.labelField = 'name'
			playerNumberBtnGroup.selectedIndex = 0;
			playerNumberBtnGroup.itemRendererWidth = 60;
			playerNumberBtnGroup.itemRendererHeight = 20;
			playerNumberBtnGroup.itemRendererClass = CircleItemRender;
			addChild(playerNumberBtnGroup);
			
			topValueLab = new Label();
			topValueLab.text = '封顶:';
			topValueLab.width = 40;
			topValueLab.height = 20;
			addChild(topValueLab);
			
			topValueBtnGroup = new ButtonGroup();
			topValueBtnGroup.width = 300;
			topValueBtnGroup.height = 100;
			topValueBtnGroup.x = 40;
			topValueBtnGroup.y = 100;
			topValueBtnGroup.dataProvider = [{'name':'200息'},{'name':'400息'}];
			topValueBtnGroup.gap = 20;
			topValueBtnGroup.labelField = 'name'
			topValueBtnGroup.selectedIndex = 0;
			topValueBtnGroup.itemRendererWidth = 60;
			topValueBtnGroup.itemRendererHeight = 20;
			topValueBtnGroup.itemRendererClass = CircleItemRender;
			addChild(topValueBtnGroup);
			
			playMethodLab = new Label();
			playMethodLab.text = '玩法:';
			playMethodLab.width = 40;
			playMethodLab.height = 20;
			addChild(playMethodLab);
			
			playMethodBtnGroup = new ButtonGroup();
			playMethodBtnGroup.width = 300;
			playMethodBtnGroup.height = 100;
			playMethodBtnGroup.x = 40;
			playMethodBtnGroup.y = 100;
			playMethodBtnGroup.dataProvider = [{'name':'快速吃牌'},{'name':'首局随机庄家'}];
			playMethodBtnGroup.gap = 20;
			playMethodBtnGroup.labelField = 'name'
			playMethodBtnGroup.selectedIndex = 0;
			playMethodBtnGroup.itemRendererWidth = 60;
			playMethodBtnGroup.itemRendererHeight = 20;
			playMethodBtnGroup.itemRendererClass = CircleItemRender;
			addChild(playMethodBtnGroup);
			
			okBtn = new Button();
			okBtn.label = '确定';
			okBtn.addEventListener(MouseEvent.CLICK,oklHandler);
			addChild(okBtn);
			
			cancelBtn = new Button();
			cancelBtn.label = 'back'
			cancelBtn.addEventListener(MouseEvent.CLICK,cancelHandler);
			addChild(cancelBtn);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
//			mainPanelView.width = width;
//			mainPanelView.height = height;
			
			groupNameLab.x = 10;
			groupNameLab.y = 20;
			groupNameInput.x = groupNameLab.x+groupNameLab.width;
			groupNameInput.y = groupNameLab.y;
			
			playerNumLab.x = groupNameLab.x;
			playerNumLab.y = groupNameLab.y+groupNameLab.height+10;
			playerNumberBtnGroup.x = playerNumLab.x+playerNumLab.width;
			playerNumberBtnGroup.y = playerNumLab.y;
			
			topValueLab.x = playerNumLab.x;
			topValueLab.y = playerNumLab.y+playerNumLab.height+10;
			topValueBtnGroup.x = topValueLab.x+topValueLab.width;
			topValueBtnGroup.y = topValueLab.y
				
			playMethodLab.x = topValueLab.x;
			playMethodLab.y = topValueLab.y+topValueLab.height+10;
			playMethodBtnGroup.x = playMethodLab.x+playMethodLab.width;
			playMethodBtnGroup.y = playMethodLab.y
			
			okBtn.width = cancelBtn.width = 40;
			okBtn.height = cancelBtn.height = 20;
			
			okBtn.y  = height-okBtn.height-25;
			okBtn.x = width-okBtn.width-20;
			
			cancelBtn.x = width-cancelBtn.width-5;
			cancelBtn.y = 5;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xffffff,1);
			graphics.drawRoundRect(0,0,width,height,20,20);
			graphics.endFill();
		}
		
		protected function cancelHandler(event:MouseEvent):void
		{
			PopUpManager.removePopUp(this);
		}
		
		
		protected function oklHandler(event:MouseEvent):void
		{
			/*
			* 创建群的操作，先insert group表，再更新user表中当前用户的group_info字段
			*/
			var group_info_arr: Array = []; 
			HttpApi.getInstane().getUserInfoByName(AppData.getInstane().username,function(e:Event):void{
				group_info_arr  = JSON.parse(JSON.parse(e.currentTarget.data).message[0].group_info) as Array
				if(groupNameInput.text){
					////进行group表的插入工作
					HttpApi.getInstane().insertGroupInfo(groupNameInput.text,parseInt(AppData.getInstane().user.userId),function(e:Event):void{
						var newGroupInfoObj:Object = {'gold':0,'group_id':parseInt(JSON.parse(e.currentTarget.data).message.id)};
						group_info_arr.push(newGroupInfoObj);
						HttpApi.getInstane().updateUserGroupInfo(AppData.getInstane().username,group_info_arr,function(e:Event):void{
							if(JSON.parse(e.currentTarget.data).result==0){
								PopUpManager.removeAllPopUp();
								///刷新界面
								Alert.show('创建成功');
								AppManager.getInstance().dispatchEvent(new AppManagerEvent(AppManagerEvent.CREATE_GROUP_SUCCESS));
							}
						},null)
					},null)
				}
			},null);
		}
	}
}