package com.xiaomu.util
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	/**
	 * 音频管理器 
	 * @author coco
	 * 
	 */	
	public class Audio
	{
		public function Audio()
		{
		}
		
		private static var instance:Audio
		
		public static function getInstane(): Audio {
			if (!instance) {
				instance = new Audio()
			}
			
			return instance
		}
		
		public var isActivate:Boolean = true
		
		private var bgSoundChannel:SoundChannel
		private var bgSound:Sound
		
		public function playBGM():void {
			if (bgSoundChannel) {
				try
				{
					bgSoundChannel.stop()
				} 
				catch(error:Error) 
				{
					
				}
			}
			
			bgSound = new Sound(new URLRequest('assets/bgm.mp3'))
			bgSoundChannel = bgSound.play(0, 1000000)
			bgSoundChannel.soundTransform = new SoundTransform(int(AppData.getInstane().bgmValue) / 100, 0)
		}
		
		public function stopBGM():void {
			if (bgSoundChannel) {
				try
				{
					bgSoundChannel.stop()
				} 
				catch(error:Error) 
				{
					
				}
			}
			
			bgSoundChannel = null
			bgSound = null
		}
		
		public function pauseBGM():void {
			trace('暂停音乐')
			if (bgSoundChannel) {
				bgSoundChannel.stop()
			}
		}
		
		public function resumeBGM():void {
			trace('恢复音乐')
			if (bgSoundChannel && bgSound) {
				bgSoundChannel.stop()
				bgSoundChannel = bgSound.play(0, 1000000)
				bgSoundChannel.soundTransform = new SoundTransform(int(AppData.getInstane().bgmValue) / 100, 0)
			}
		}
		
		private var cardChannel:SoundChannel
		private var cardSound:Sound
		
		public function playCard(card:int):void {
			if (!isActivate) return
			if (cardChannel) {
				try
				{
					cardChannel.stop()
				} 
				catch(error:Error) 
				{
					
				}
			}
			
			cardSound = new Sound(new URLRequest('sound/card/v' + card + '.mp3'))
			cardChannel = cardSound.play()
			cardChannel.soundTransform = new SoundTransform(int(AppData.getInstane().gameMusicValue) / 100, 0)
		}
		
		private var handleChannel:SoundChannel
		private var handleSound:Sound
		
		public function playHandle(name:String):void {
			if (handleChannel) {
				try
				{
					handleChannel.stop()
				} 
				catch(error:Error) 
				{
					
				}
			}
			
			handleSound = new Sound(new URLRequest('sound/handle/' + name + '.mp3'))
			handleChannel = handleSound.play()
			handleChannel.soundTransform = new SoundTransform(int(AppData.getInstane().gameMusicValue) / 100, 0)
		}
		
		private var chatChannel:SoundChannel
		private var chatSound:Sound
		
		public function playChat(name:String):void {
			if (!isActivate) return
			if (chatChannel) {
				try
				{
					chatChannel.stop()
				} 
				catch(error:Error) 
				{
					
				}
			}
			
			chatSound = new Sound(new URLRequest('sound/msg/' + name + '.mp3'))
			chatChannel = chatSound.play()
			chatChannel.soundTransform = new SoundTransform(int(AppData.getInstane().gameMusicValue) / 100, 0)
		}
		
		
		
		private var buttonChannel:SoundChannel
		private var buttonSound:Sound  = new Sound(new URLRequest('sound/btnClick.mp3'))
		public function playButton():void {
			if (!isActivate) return
			if (buttonChannel) {
				try
				{
					buttonChannel.stop()
				} 
				catch(error:Error) 
				{
				}
			}
			
			buttonChannel = buttonSound.play()
			buttonChannel.soundTransform = new SoundTransform(int(AppData.getInstane().gameMusicValue) / 100, 0)
		}
		
	}
}