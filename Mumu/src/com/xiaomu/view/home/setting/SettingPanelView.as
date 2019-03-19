package com.xiaomu.view.home.setting
{
	
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.Audio;
	import com.xiaomu.view.MainView;
	import com.xiaomu.view.login.LoginView;
	
	import flash.events.MouseEvent;
	
	import coco.component.Button;
	import coco.component.ButtonGroup;
	import coco.core.Application;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	import coco.manager.PopUpManager;
	
	/**
	 * 设置界面
	 */
	public class SettingPanelView extends UIComponent
	{
		public function SettingPanelView()
		{
			super();
		}
		
		private var setType:ButtonGroup;
		private var musicSetView:MusicSetView;
		private var otherSetView:OtherSetView;
		private var signOutBtn:Button;
		private var closeBtn:Button;
		override protected function createChildren():void
		{
			super.createChildren();
			
			setType = new ButtonGroup();
			setType.width = 160;
			setType.height = 20;
//			setType.dataProvider = [{'name':'声音'},{'name':'其他'}];
			setType.dataProvider = [{'name':'声音'}];
			setType.labelField = 'name';
			setType.gap = 10;
			setType.selectedIndex = 0;
			setType.itemRendererWidth = 120;
			setType.addEventListener(UIEvent.CHANGE,changeHandler);
			addChild(setType);
			
			musicSetView = new MusicSetView();
			addChild(musicSetView);
			
			otherSetView = new OtherSetView();
			otherSetView.visible = false;
			addChild(otherSetView);
			
			signOutBtn = new Button();
			signOutBtn.label = '退出登录';
			signOutBtn.addEventListener(MouseEvent.CLICK,signOutBtnHandler);
			addChild(signOutBtn);
			
			closeBtn = new Button();
			closeBtn.label = 'close';
			closeBtn.addEventListener(MouseEvent.CLICK,closeBtnHandler);
			addChild(closeBtn);
		}
		
		override protected function updateDisplayList():void
		{
			width = Application.topApplication.width*0.8;
			height =Application.topApplication.height*0.8;
			
			setType.x = 10;
			setType.y = 30;
			
			musicSetView.x = otherSetView.x = 10;
			musicSetView.y = otherSetView.y = setType.y+setType.height;
			
			signOutBtn.width = 40;
			signOutBtn.height = 20;
			signOutBtn.y = height-signOutBtn.height
			signOutBtn.x = (width-signOutBtn.width)/2;
			
			closeBtn.width = closeBtn.height = 20;
			closeBtn.x = width-closeBtn.width
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xffffff);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
		
		private var oldSelectIndex:int;
		protected function changeHandler(event:UIEvent):void
		{
			if(setType.selectedIndex!=-1){
				oldSelectIndex = setType.selectedIndex
			}else{
				setType.selectedIndex = oldSelectIndex;
				return;
			}
			
			if(setType.selectedIndex==0){
				musicSetView.visible = true;
				otherSetView.visible = false;
			}else{
				musicSetView.visible = false;
				otherSetView.visible = true;
			}
		}
		
		protected function closeBtnHandler(event:MouseEvent):void
		{
			PopUpManager.removePopUp(this);
		}
		
		protected function signOutBtnHandler(event:MouseEvent):void
		{
			PopUpManager.removeAllPopUp();
			AppData.getInstane().inGroupView = false;
			dispose()
			MainView.getInstane().popView(LoginView)
		}
		
		public function dispose():void {
			Audio.getInstane().stopBGM()
		}
		
	}
}