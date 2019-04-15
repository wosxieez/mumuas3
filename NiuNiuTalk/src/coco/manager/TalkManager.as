package coco.manager
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	
	import coco.event.TalkEvent;
	
	import org.as3wavsound.WavSound;
	import org.bytearray.micrecorder.MicRecorder;
	import org.bytearray.micrecorder.encoder.WaveEncoder;
	
	
	[Event(name="success", type="coco.event.TalkEvent")]
	[Event(name="fault", type="coco.event.TalkEvent")]
	
	public class TalkManager extends EventDispatcher
	{
		public function TalkManager(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		
		private static var instance:TalkManager
		
		public static function getInstane(): TalkManager {
			if (!instance) {
				instance = new TalkManager()
			}
			
			return instance
		}
		
		private var rec: MicRecorder
		
		public function start():void {
			trace('对讲开始...')
			rec = new MicRecorder(new WaveEncoder())
			rec.addEventListener(Event.COMPLETE, okHandler)
			rec.record()
		}
		
		public function stop():void {
			if (!rec) return
			trace('对讲结束...')
			rec.stop()
		}
		
		public function cancel():void {
			if (!rec) return
			trace('对讲取消...')
			rec.removeEventListener(Event.COMPLETE, okHandler)
			rec.stop()
		}
		
		public function play(uuid:String):void {
			var urlrequest:URLRequest = new URLRequest('http://hefeixiaomu.com:3008/get_audio');
			urlrequest.method = URLRequestMethod.POST
			urlrequest.contentType = 'application/json'
			urlrequest.data = JSON.stringify({uuid: uuid})
			
			var wavLoader:URLLoader = new URLLoader();
			wavLoader.dataFormat = URLLoaderDataFormat.BINARY;
			wavLoader.addEventListener(Event.COMPLETE, wavLoader_CompleteHandler)
			wavLoader.addEventListener(IOErrorEvent.IO_ERROR, wavLoader_errorHandler)
			wavLoader.load(urlrequest);
		}
		
		private function wavLoader_CompleteHandler(e:Event):void
		{
			try
			{
				var soundBytes:ByteArray = e.currentTarget.data as ByteArray
				if (soundBytes)
					new WavSound(soundBytes).play()
			} 
			catch(error:Error) 
			{
				
			}
			
		}
		
		private function wavLoader_errorHandler(e:IOErrorEvent):void
		{
			
		}
		
		private const BOUNDARY:String = "---------------------------7d93b91e2404d";
		
		protected function okHandler(event:Event):void
		{
			trace('保存对讲数据...')
			var cb:ByteArray = new ByteArray();			
			cb.writeUTFBytes("--" + BOUNDARY + "\r\n");
			cb.writeUTFBytes("Content-Disposition: form-data; name=\"audio\"; filename=\"audio.wav\"\r\n");
			cb.writeUTFBytes("Content-Type: audio/wav\r\n\r\n");
			cb.writeBytes(rec.output);
			cb.writeUTFBytes("\r\n--" + BOUNDARY + "--\r\n");
			
			var urlReq:URLRequest = new URLRequest('http://hefeixiaomu.com:3008/upload_audio');
			urlReq.method = URLRequestMethod.POST;
			urlReq.contentType = "multipart/form-data; boundary=" + BOUNDARY;
			urlReq.data = cb;
			
			// load request
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			urlLoader.addEventListener(Event.COMPLETE, urlLoader_CompleteHandler);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, urlLoader_errorHandler);
			urlLoader.load(urlReq);
			
			rec.removeEventListener(Event.COMPLETE, okHandler)
			rec = null
		}
		
		private function urlLoader_CompleteHandler(e:Event):void
		{
			try
			{
				var ae:TalkEvent
				var result:Object = JSON.parse(e.currentTarget.data)
				if (result.code == 0) {
					ae = new TalkEvent(TalkEvent.SUCCESS)
					ae.data = result.data
				} else {
					ae = new TalkEvent(TalkEvent.FAULT)
				}
			} 
			catch(error:Error) 
			{
				ae = new TalkEvent(TalkEvent.FAULT)
			}
			dispatchEvent(ae)
		}
		
		private function urlLoader_errorHandler(e:IOErrorEvent):void
		{
			dispatchEvent(new TalkEvent(TalkEvent.FAULT))
		}
		
	}
}