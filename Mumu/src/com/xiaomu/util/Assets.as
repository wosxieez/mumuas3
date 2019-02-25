package com.xiaomu.util  {
	
	import com.adobe.serialization.json.JSONDecoder;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	
	public class Assets extends EventDispatcher {
		
		private var thisBitmaData:BitmapData;
		private var thisFrameData:Object;
		private var loadCounter:int;
		
		
		private static var instance:Assets
		
		public static function getInstane(): Assets {
			if (!instance) {
				instance = new Assets()
			}
			
			return instance
		}
		
		/**
		 * Constructor
		 */ 
		public function Assets() {
			thisFrameData = new Object();
		}
		
		public function loadAssets(png: String, json:String):void {
			
			loadCounter = 0
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void {
				var bitmapData:BitmapData = Bitmap(e.target.content).bitmapData;
				thisBitmaData = bitmapData;
				
				var jsonLoader:URLLoader = new URLLoader();
				jsonLoader.addEventListener(Event.COMPLETE, function(f:Event):void {
					var jsonFile:JSONDecoder = new JSONDecoder(f.target.data, true);
					var frames:Object = jsonFile.getValue()['frames'];
					var dict:Object = new Object();
					for (var fileName:String in frames){
						
						dict[fileName] = frames[fileName];
					}
					thisFrameData = dict;
					loadCounter++;
					if (loadCounter == length) {
						dispatchEvent(new Event(Event.COMPLETE));
						trace('资源加载完毕')
					}
				});
				jsonLoader.load(new URLRequest(json));
			}
				
			)
			loader.load(new URLRequest(png));
		}
		
		public function getAssets(name:String):Bitmap {
			
			var bitmap:Bitmap = null;
			try
			{
				if (thisBitmaData != null) {
					
					var sheet:BitmapData  = thisBitmaData;
					var frameData:Object = thisFrameData[name];
					var object:Object = frameData["frame"];
					var width:int = object["w"];
					var height:int = object["h"];
					var x:int = object["x"];
					var y:int = object["y"];
					var canvas:BitmapData = new BitmapData(width, height);
					canvas.copyPixels(sheet, new Rectangle(x, y, width, height), new Point());
					bitmap = new Bitmap(canvas);
				}
			} 
			catch(error:Error) 
			{
				trace('找不到资源', name)
			}
			return bitmap;
		}
		
		
	}
}