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
		
		private var bgSound:Sound
		
		public function playBGM(url:String):void {
			bgSound = new Sound(new URLRequest(url))
			bgSound.play(0, 1000000)
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
			
			handleSound = new Sound(new URLRequest('sound/handle/v_' + name + '.mp3'))
			handleChannel = handleSound.play()
		}
		
	}
}