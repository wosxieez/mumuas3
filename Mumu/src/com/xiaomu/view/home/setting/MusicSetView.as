package com.xiaomu.view.home.setting
{
	import com.xiaomu.component.SettingMusicSlider;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.Audio;
	
	import coco.component.Image;
	import coco.component.Label;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	
	public class MusicSetView extends UIComponent
	{
		public function MusicSetView()
		{
			super();
		}
		
		private static var instance:Audio
		
		public static function getInstane(): Audio {
			if (!instance) {
				instance = new Audio()
			}
			
			return instance
		}
		
		private var bgImg:Image;
		private var bgmMusicLab:Image;
		private var bgmMusicSlider:SettingMusicSlider;
		private var gameMusicLab:Image;
		private var gameMusicSlider:SettingMusicSlider;
		private var bgmSliderValue:int;
		private var gameSliderValue:int;
		override protected function createChildren():void
		{
			super.createChildren();
			
			bgImg = new Image();
			bgImg.source = 'assets/home/settingPanel/setting_bg_diban01.png';
			addChild(bgImg);
			
			bgmMusicLab = new Image();
			bgmMusicLab.source = 'assets/home/settingPanel/setting_sound.png';
			bgmMusicLab.width = 158*0.7;
			bgmMusicLab.height = 50*0.7;
			addChild(bgmMusicLab);
			
			bgmMusicSlider = new SettingMusicSlider();
			bgmMusicSlider.sliderBtnSource = 'assets/home/settingPanel/setting_bar_sender.png';
			bgmMusicSlider.sliderCoverImageSource = 'assets/home/settingPanel/setting_bar_full.png';
			bgmMusicSlider.sliderBarImageSource = 'assets/home/settingPanel/setting_bar_void.png';
			bgmMusicSlider.width = 290;
			bgmMusicSlider.height = 8;
			bgmMusicSlider.maxValue = 100;
			bgmMusicSlider.minValue = 0;
			bgmMusicSlider.value = parseInt(AppData.getInstane().bgmValue)?parseInt(AppData.getInstane().bgmValue):0;
			bgmMusicSlider.addEventListener(UIEvent.CHANGE,changebgmHandler);
			addChild(bgmMusicSlider);
			
			gameMusicLab = new Image();
			gameMusicLab.source = 'assets/home/settingPanel/setting_music.png';
			gameMusicLab.width = 158*0.7;
			gameMusicLab.height = 50*0.7;
			addChild(gameMusicLab);
			
			gameMusicSlider = new SettingMusicSlider();
			gameMusicSlider.sliderBtnSource = 'assets/home/settingPanel/setting_bar_sender.png';
			gameMusicSlider.sliderCoverImageSource = 'assets/home/settingPanel/setting_bar_full.png';
			gameMusicSlider.sliderBarImageSource = 'assets/home/settingPanel/setting_bar_void.png';
			gameMusicSlider.width = 290;
			gameMusicSlider.height = 8;
			gameMusicSlider.maxValue = 100;
			gameMusicSlider.minValue = 0;
			gameMusicSlider.value = parseInt(AppData.getInstane().gameMusicValue)?parseInt(AppData.getInstane().gameMusicValue):0;
			gameMusicSlider.addEventListener(UIEvent.CHANGE,changegameHandler);
			addChild(gameMusicSlider);
		}
		
		protected function changegameHandler(event:UIEvent):void
		{
			AppData.getInstane().gameMusicValue=gameMusicSlider.value+'';
			Audio.getInstane().changeGameGain(int(gameMusicSlider.value));
		}
		
		protected function changebgmHandler(event:UIEvent):void
		{
			AppData.getInstane().bgmValue=bgmMusicSlider.value+'';
			Audio.getInstane().changeBgmGain(int(bgmMusicSlider.value));
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			bgImg.width = width;
			bgImg.height = height;
			bgmMusicLab.width = 60;
			bgmMusicLab.height = 20;
			bgmMusicLab.x = 10;
			bgmMusicLab.y = 20;
			bgmMusicSlider.x = bgmMusicLab.x+bgmMusicLab.width;
			bgmMusicSlider.y = bgmMusicLab.y+7;
			gameMusicLab.width = 60;
			gameMusicLab.height = 20;
			gameMusicLab.x = bgmMusicLab.x;
			gameMusicLab.y = bgmMusicLab.y+bgmMusicLab.height+15;
			gameMusicSlider.x = gameMusicLab.x+gameMusicLab.width;
			gameMusicSlider.y = gameMusicLab.y+7;
		}
	}
}