package com.xiaomu.component
{
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import caurina.transitions.Tweener;
	
	import coco.component.Image;
	import coco.component.Label;
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	
	public class AppSmallAlertView extends UIComponent
	{
		public function AppSmallAlertView()
		{
			super();
			width = 1280;
			height = 720;
			this.addEventListener(Event.ADDED_TO_STAGE,addHandler);
		}
		
		private var _text:String;
		
		public function get text():String
		{
			return _text;
		}
		
		public function set text(value:String):void
		{
			_text = value;
			invalidateProperties();
		}
		
		private var _time:Number;
		
		public function get time():Number
		{
			return _time;
		}
		
		public function set time(value:Number):void
		{
			_time = value;
		}
		
		private var bgImg:Image;
		private var lab:Label;
		override protected function createChildren():void
		{
			super.createChildren();
			
			bgImg = new Image();
			bgImg.source = 'assets/component/autoEndTimeBg.png';
			addChild(bgImg);
			
			lab = new Label();
			lab.fontSize = 24;
			lab.color = 0xffffff;
			bgImg.addChild(lab);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			lab.text = text;
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			lab.width =bgImg.width = 828;
			lab.height =bgImg.height = 50
			bgImg.x = (width-bgImg.width)/2;
			bgImg.y = (height-bgImg.height)/2;
		}
		
		protected function addHandler(event:Event):void
		{
			///开始移动
			setTimeout(function():void{
				Tweener.addTween(bgImg,{x:(width-bgImg.width)/2,y:20, time:time, onComplete:completeHandler})
			},100);
		}
		
		private function completeHandler():void
		{
			PopUpManager.removePopUp(this);
		}
	}
}