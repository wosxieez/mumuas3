package com.xiaomu.view.room
{
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextAlign;
	import coco.core.UIComponent;
	
	public class WinnerFromView extends UIComponent
	{
		public function WinnerFromView()
		{
			super();
			width = 244;
			height = 468;
		}
		
		private var _isWinner:Boolean;
		
		public function get isWinner():Boolean
		{
			return _isWinner;
		}
		
		public function set isWinner(value:Boolean):void
		{
			_isWinner = value;
			invalidateProperties();
		}
		
		private var _data:Object;

		public function get data():Object
		{
			return _data;
		}

		public function set data(value:Object):void
		{
			_data = value;
			invalidateProperties();
		}
		
		private var bgImg:Image;
		private var winnerHeadView:UserHeadViewInEnd;
		private var rankBgImg:Image;
		private var zongHuxiImg:Image;
		private var zongHuxiLab:Label;
		private var gaoShouImg:Image;
		override protected function createChildren():void
		{
			super.createChildren();
			
			bgImg = new Image();
			bgImg.width = 244;
			bgImg.height = 468;
			addChild(bgImg);
			
			winnerHeadView = new UserHeadViewInEnd();
			addChild(winnerHeadView);
			
			rankBgImg = new Image();
			rankBgImg.source = 'assets/endAll/floor_zjs03.png';
			rankBgImg.width = 220;
			rankBgImg.height = 222-20;
			addChild(rankBgImg);
			
			zongHuxiImg = new Image();
			zongHuxiImg.source = 'assets/endAll/zhx.png';
			zongHuxiImg.width = 92;
			zongHuxiImg.height = 34;
			rankBgImg.addChild(zongHuxiImg);
			
			zongHuxiLab = new Label();
			zongHuxiLab.fontSize = 40;
			zongHuxiLab.textAlign= TextAlign.RIGHT;
			zongHuxiLab.color = 0x89755c;
			rankBgImg.addChild(zongHuxiLab);
			
			gaoShouImg = new Image();
			gaoShouImg.source = 'assets/endAll/icon_gs.png';
			gaoShouImg.width = 96;
			gaoShouImg.height = 81;
			rankBgImg.addChild(gaoShouImg);
			gaoShouImg.visible = false;
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			winnerHeadView.width = width;
			winnerHeadView.height = 90;
			winnerHeadView.y = 80;
			winnerHeadView.x = 20;
			
			rankBgImg.x = (width-rankBgImg.width)/2;
			rankBgImg.y = winnerHeadView.y+winnerHeadView.height+10;
			
			zongHuxiImg.x = 5;
			zongHuxiImg.y = 5;
			
			zongHuxiLab.width = width/2;
			zongHuxiLab.height = 45;
			zongHuxiLab.x = rankBgImg.x+rankBgImg.width-zongHuxiLab.width-20
				
			gaoShouImg.x = 60;
			gaoShouImg.y = 80;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			bgImg.source = 'assets/endAll/'+(isWinner?'floor_zjs04':'bac_02')+'.png';
			
			if (!data) return
			zongHuxiLab.text = data.thx+"";
			winnerHeadView.data = data;
			gaoShouImg.visible = isWinner;
		}
		
	}
}