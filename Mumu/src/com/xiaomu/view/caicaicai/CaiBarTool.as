package com.xiaomu.view.caicaicai
{
	import com.xiaomu.renderer.NumberBarRender;
	
	import flash.events.Event;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import coco.component.ButtonGroup;
	import coco.component.HorizontalAlign;
	import coco.core.UIComponent;
	
	/**
	 * 随机数字条
	 */
	public class CaiBarTool extends UIComponent
	{
		public function CaiBarTool()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE,addToStageHandler);
		}
		
		protected function addToStageHandler(event:Event):void
		{
			getRoundArr();
		}
		private var tempArr:Array;
		
		private var _numStr:String;
		
		public function get numStr():String
		{
			return _numStr;
		}
		
		public function set numStr(value:String):void
		{
			_numStr = value;
			numberChangeAnimate();
		}
		
		private var numberBar:ButtonGroup;
		override protected function createChildren():void
		{
			super.createChildren();
			
			numberBar = new ButtonGroup();
			numberBar.dataProvider = ["0","0","0","0"]
			numberBar.horizontalAlign = HorizontalAlign.JUSTIFY;
			numberBar.gap = 10;
			numberBar.itemRendererClass = NumberBarRender;
			addChild(numberBar);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			numberBar.width = width;
			numberBar.height = height;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if(numStr){
				var dataArray:Array =  String(numStr).split("");
				trace("数据：",JSON.stringify(dataArray));
				numberBar.dataProvider = dataArray
			}
		}
		
		private function getRoundArr():void
		{
			tempArr = [];
			var iStr:String;
			for (var i:int = 1; i < 9999; i++) 
			{
				iStr = i+"";
				while(iStr.length<4){
					iStr= "0"+iStr;
				}
				tempArr.push(iStr)
			}
		}
		
		protected function numberChangeAnimate():void{
			if(!tempArr){
				return;
			}
			
			var count:Number = 0;
			var time1:uint = setInterval(function():void{
				numberBar.dataProvider = tempArr[Math.floor(Math.random()*9000)].split("");///随机刷新数字界面
				count++;
				
				if(count==10){
					clearInterval(time1);
					setTimeout(function():void{
						var dataArray:Array =  String(numStr).split("");
						numberBar.dataProvider = dataArray
					},50);
				}
			},80);
		}
		
		
	}
}