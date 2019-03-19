package com.xiaomu.view.home.setting
{
	import com.xiaomu.component.SettingMusicSlider;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.Audio;
	
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
		
		private var lab:Label;
		private var bgmMusicLab:Label;
		private var bgmMusicSlider:SettingMusicSlider;
		private var gameMusicLab:Label;
		private var gameMusicSlider:SettingMusicSlider;
		private var bgmSliderValue:int;
		private var gameSliderValue:int;
		override protected function createChildren():void
		{
			super.createChildren();
			trace('create');
			lab = new Label();
			lab.text = '音效设置界面';
			addChild(lab);
			lab.visible = false;
			
			bgmMusicLab = new Label();
			bgmMusicLab.text = '背景音乐';
			addChild(bgmMusicLab);
			
			bgmMusicSlider = new SettingMusicSlider();
			bgmMusicSlider.sliderBtnSource = 'assets/home/sliderBtn.png';
			bgmMusicSlider.sliderBarImageSource = 'assets/home/sliderBg.png';
			bgmMusicSlider.sliderCoverImageSource = 'assets/home/sliderBarCover.png';
			bgmMusicSlider.width = 150;
			bgmMusicSlider.height = 5;
			bgmMusicSlider.maxValue = 100;
			bgmMusicSlider.minValue = 0;
			bgmMusicSlider.value = parseInt(AppData.getInstane().bgmValue)?parseInt(AppData.getInstane().bgmValue):0;
			bgmMusicSlider.addEventListener(UIEvent.CHANGE,changebgmHandler);
			addChild(bgmMusicSlider);
			
			gameMusicLab = new Label();
			gameMusicLab.text = '游戏音效';
			addChild(gameMusicLab);
			
			gameMusicSlider = new SettingMusicSlider();
			gameMusicSlider.sliderBtnSource = 'assets/home/sliderBtn.png';
			gameMusicSlider.sliderBarImageSource = 'assets/home/sliderBg.png';
			gameMusicSlider.sliderCoverImageSource = 'assets/home/sliderBarCover.png';
			gameMusicSlider.width = 150;
			gameMusicSlider.height = 5;
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
			
			bgmMusicLab.width = 60;
			bgmMusicLab.height = 20;
			bgmMusicLab.x = 10;
			bgmMusicLab.y = 20;
			bgmMusicSlider.x = bgmMusicLab.x+bgmMusicLab.width;
			bgmMusicSlider.y = bgmMusicLab.y+5;
			gameMusicLab.width = 60;
			gameMusicLab.height = 20;
			gameMusicLab.x = bgmMusicLab.x;
			gameMusicLab.y = bgmMusicLab.y+bgmMusicLab.height+5;
			gameMusicSlider.x = gameMusicLab.x+gameMusicLab.width;
			gameMusicSlider.y = gameMusicLab.y+5;
		}
	}
}