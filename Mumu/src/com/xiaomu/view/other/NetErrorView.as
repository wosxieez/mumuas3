package com.xiaomu.view.other
{
	import com.xiaomu.component.AppAlert;
	import com.xiaomu.util.Api;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	import coco.manager.PopUpManager;
	
	public class NetErrorView extends UIComponent
	{
		public function NetErrorView()
		{
			super();
			
			width = 1280 
			height = 720
				
			addEventListener(Event.ENTER_FRAME, this_enterFrameHandler);
		}
		
		private static var instance:NetErrorView;
		
		public static function getInstance():NetErrorView
		{
			if (!instance)
				instance = new NetErrorView();
			
			return instance;
		}
		
		private var count:int = 0
		private var timeid:uint
		public var degreeGap:Number = 30;
		public var radiusIn:Number = 25;
		public var radiusOut:Number = 50;
		public var edgeLen:Number = 3;
		private var degreeStart:Number = 0;
		private var degreeAlpha:Number;
		private var xIn:Number, yIn:Number, xOut:Number, yOut:Number, xDis:Number, yDis:Number;
		private var p1:Point, p2:Point, p3:Point, p4:Point;
		private var currentFrame:int = 0;
		
		public function open():void {
			PopUpManager.addPopUp(this, null, true)
			count = 0
			clearTimeout(timeid)
			timeid = setTimeout(checkNetwork, 1000)
		}
		
		public function close():void {
			PopUpManager.removePopUp(this)
			clearTimeout(timeid)
		}
		
		private function checkNetwork():void {
			count++;
			trace('网络尝试重连中...', count)
			HttpApi.getInstane().getVersion(
				function (e:Event):void {
					// net work ok
					trace('网络已经恢复')
					close()
					Api.getInstane().reconnect()
				}, 
				function (e:Event):void {
					// net error
					trace('网络重连失败')
					if (count >= 15) {
						AppAlert.show('网络连接断开，请检查网络设置，重新连接', "", 0x4, function (e:UIEvent):void {
							NetErrorView.getInstance().open()
						})
					} else {
						timeid = setTimeout(checkNetwork, 1000)
					}
				})
		}
		
		protected function this_enterFrameHandler(event:Event):void
		{
			graphics.clear();
			graphics.beginFill(0x000000, .5);
			graphics.drawRoundRect(0, 0, width, height, 14);
			graphics.endFill();
			
			degreeAlpha = 1;
			
			currentFrame++;
			if (currentFrame == 2)
			{
				currentFrame = 0;
				degreeStart += degreeGap;
				degreeStart = degreeStart % 360;
			}
			
			var degreeNum:int = Math.floor(360 / degreeGap);
			for (var i:int = 0; i < degreeNum; i++)
			{
				drawRect(i);
			}
		}
		
		private function drawRect(index:int):void
		{
			var degree:Number = (degreeStart + 360 - index * degreeGap) % 360;
			xIn = Math.sin(degree * Math.PI / 180) * radiusIn;
			yIn = Math.cos(degree * Math.PI / 180) * radiusIn;
			xOut = Math.sin(degree * Math.PI / 180) * radiusOut;
			yOut = Math.cos(degree * Math.PI / 180) * radiusOut;
			xDis = Math.cos(degree * Math.PI / 180) * edgeLen;
			yDis = Math.sin(degree * Math.PI / 180) * edgeLen;
			p1 = new Point(xIn - xDis, -yIn - yDis);
			p2 = new Point(xIn + xDis, -yIn + yDis);
			p3 = new Point(xOut + xDis, -yOut + yDis);
			p4 = new Point(xOut - xDis, -yOut - yDis);
			
			graphics.beginFill(0xFFFFFF, Math.max(degreeAlpha, .3));
			graphics.moveTo(p1.x + width / 2, p1.y + height / 2);
			graphics.lineTo(p2.x + width / 2, p2.y + height / 2);
			graphics.lineTo(p3.x + width / 2, p3.y + height / 2);
			graphics.lineTo(p4.x + width / 2, p4.y + height / 2);
			graphics.endFill();
			
			degreeAlpha *= .8;
		}
		
	}
}