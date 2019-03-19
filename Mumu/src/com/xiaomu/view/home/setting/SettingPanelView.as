package com.xiaomu.view.home.setting
{
	
	import com.xiaomu.component.ImageBtnWithUpAndDown;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.Audio;
	import com.xiaomu.view.MainView;
	import com.xiaomu.view.login.LoginView;
	
	import flash.events.MouseEvent;
	
	import coco.component.Button;
	import coco.component.ButtonGroup;
	import coco.component.Image;
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
		
		private var bgImg:Image;
		private var setType:ButtonGroup;
		private var musicSetView:MusicSetView;
		private var otherSetView:OtherSetView;
		private var signOutBtn:ImageBtnWithUpAndDown;
		private var closeBtn:ImageBtnWithUpAndDown;
		override protected function createChildren():void
		{
			super.createChildren();
			
			bgImg = new Image();
			bgImg.source = 'assets/home/settingPanel/bac_03_new.png';
			addChild(bgImg);
			
			setType = new ButtonGroup();
			setType.width = 271*0.3;
			setType.height = 72*0.3;
			setType.dataProvider = [{'name':'声音','image':'setting_checkbox_sound_full'}];
			setType.labelField = 'name';
			setType.gap = 10;
			setType.selectedIndex = 0;
			setType.itemRendererWidth = setType.width;
			setType.itemRendererHeight = setType.height;
			setType.itemRendererClass = SetTypeRender;
			setType.addEventListener(UIEvent.CHANGE,changeHandler);
			addChild(setType);
			
			musicSetView = new MusicSetView();
			addChild(musicSetView);
			
			otherSetView = new OtherSetView();
			otherSetView.visible = false;
			addChild(otherSetView);
			
			signOutBtn = new ImageBtnWithUpAndDown();
			signOutBtn.upImageSource = 'assets/home/settingPanel/logoutNormal.png';
			signOutBtn.downImageSource = 'assets/home/settingPanel/logoutPress.png';
			signOutBtn.width = 214*0.4
			signOutBtn.height = 82*0.4
			signOutBtn.addEventListener(MouseEvent.CLICK,signOutBtnHandler);
			addChild(signOutBtn);
			
			closeBtn = new ImageBtnWithUpAndDown();
			closeBtn.upImageSource = 'assets/home/settingPanel/btn_close_normal.png';
			closeBtn.downImageSource = 'assets/home/settingPanel/btn_close_press.png';
			closeBtn.width = 79*0.32
			closeBtn.height = 156*0.32
			closeBtn.addEventListener(MouseEvent.CLICK,closeBtnHandler);
			addChild(closeBtn);
		}
		
		override protected function updateDisplayList():void
		{
			width = Application.topApplication.width;
			height =Application.topApplication.height;
			
			bgImg.width = width;
			bgImg.height = height;
			
			setType.x = width*0.1;
			setType.y = 40;
			
			musicSetView.width = width*0.8
			musicSetView.height = height*0.6
			musicSetView.x = otherSetView.x = (width-musicSetView.width)/2;
			musicSetView.y = otherSetView.y = setType.y+setType.height;
			
			signOutBtn.y = height-signOutBtn.height-15
			signOutBtn.x = (width-signOutBtn.width)/2;
			
			closeBtn.x = bgImg.x+bgImg.width-closeBtn.width-30;
			closeBtn.y = 15;
				
		}
		
		/*override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xe6dfc5);
			graphics.drawRoundRect(0,0,width,height,10,10);
			graphics.endFill();
		}*/
		
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