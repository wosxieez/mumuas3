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
		
		private var _type:String;

		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
			invalidateSkin();
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
		
		override protected function drawSkin():void
		{
			super.drawSkin();
		
			switch(type)
			{
				case "normal":
				{
					lab.color = 0xffffff;
					break;
				}
				case "success":
				{
					lab.color = 0x99FF99;
					break;
				}
				case "warning":
				{
					lab.color = 0xFF0033;
					break;
				}
				default:
				{
					break;
				}
			}
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