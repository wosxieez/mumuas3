package com.xiaomu.util
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
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
		
		private var bgSoundChannel:SoundChannel
		private var bgSound:Sound
		
		public function playBGM(url:String):void {
			if (bgSoundChannel) {
				try
				{
					bgSoundChannel.stop()
				} 
				catch(error:Error) 
				{
					
				}
			}
			
			bgSound = new Sound(new URLRequest(url))
			bgSoundChannel = bgSound.play(0, 1000000)
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
		}
		
		private var cardChannel:SoundChannel
		private var cardSound:Sound
		
		public function playCard(card:int):void {
			
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
		}
		
		private var chatChannel:SoundChannel
		private var chatSound:Sound
		
		public function playChat(name:String):void {
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
		}
		
		public function changeBgmGain(gainValue:int):void{
			trace('bgm增益：',gainValue);
		}
		
		public function changeGameGain(gainValue:int):void{
			trace('game增益：',gainValue);
		}
		
	}
}