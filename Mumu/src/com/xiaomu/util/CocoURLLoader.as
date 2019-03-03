package com.xiaomu.util
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	
	import coco.net.URLLoaderWithTimeout;
	
	public class CocoURLLoader extends URLLoaderWithTimeout
	{
		private var resultCallback:Function;
		private var faultCallback:Function;
		
		public function CocoURLLoader(resultHandler:Function, faultHandler:Function, useQueue:Boolean=false, timeout:Number=-1)
		{
			super(timeout);
			addEventListener(Event.COMPLETE, loadCompleteHandler);
			addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
			
			resultCallback = resultHandler;
			faultCallback = faultHandler;
		}
		
		protected function errorHandler(event:Event):void
		{
			if (faultCallback != null && !isReleased)
				faultCallback.call(null, event);
		}
		
		protected function loadCompleteHandler(event:Event):void
		{
			if (resultCallback != null && !isReleased)
				resultCallback.call(null, event);
		}
		
		private var isReleased:Boolean = false;
		
		override public function load(request:URLRequest):void
		{
			super.load(request);
		}
		
		public function release():void
		{
			isReleased = true;
		}
		
	}
}