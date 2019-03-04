package com.xiaomu.view.home
{
	import com.xiaomu.view.HallView;
	import com.xiaomu.view.MainView;
	
	import flash.events.MouseEvent;
	
	import coco.component.Button;
	import coco.component.Image;
	import coco.component.Label;
	import coco.core.UIComponent;
	
	public class HomeView extends UIComponent
	{
		public function HomeView()
		{
			super();
		}
		
		private var bg : Image;
		private var lab : Label;
		private var myGroup:Button;
		override protected function createChildren():void
		{
			super.createChildren();
			
			bg = new Image()
			bg.source = 'assets/home/home_bg.png';
			addChild(bg)
			
			lab = new Label();
			lab.text = 'homeView';
			lab.color = 0xffffff;
			addChild(lab);
			
			myGroup = new Button();
			myGroup.label = '我的组群';
			myGroup.fontSize = 20;
			myGroup.addEventListener(MouseEvent.CLICK,clickHandler);
			addChild(myGroup);
		}
		
		override protected function updateDisplayList():void{
			super.updateDisplayList();
			
			bg.width = width;
			bg.height = height;
			myGroup.x = width/2-120;
			myGroup.y = height/2-20;
			
		}
		
		protected function clickHandler(event:MouseEvent):void
		{
			trace('选中我的组群');
			HallView(MainView.getInstane().pushView(HallView)).init()
		}
	}
}