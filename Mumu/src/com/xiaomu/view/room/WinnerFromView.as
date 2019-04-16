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
		private var zongHuxiLab2:Label;
		private var zongFenImg:Image;
		private var zongFenLab:Label;
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
			zongHuxiImg.width = 92*0.8;
			zongHuxiImg.height = 34*0.8;
			rankBgImg.addChild(zongHuxiImg);
			
			zongHuxiLab = new Label();
			zongHuxiLab.fontSize = 24;
			zongHuxiLab.textAlign= TextAlign.LEFT;
			zongHuxiLab.color = 0x89755c;
			rankBgImg.addChild(zongHuxiLab);
			
			zongHuxiLab2 = new Label();
			zongHuxiLab2.fontSize = 34;
			zongHuxiLab2.textAlign= TextAlign.RIGHT;
			zongHuxiLab2.color = 0x89755c;
			rankBgImg.addChild(zongHuxiLab2);
			
			gaoShouImg = new Image();
			gaoShouImg.source = 'assets/endAll/icon_gs.png';
			gaoShouImg.width = 96;
			gaoShouImg.height = 81;
			rankBgImg.addChild(gaoShouImg);
			gaoShouImg.visible = false;
			
			zongFenImg = new Image();
			zongFenImg.source = 'assets/endAll/text_total_score_n.png';
			zongFenImg.width = 48*1.5;
			zongFenImg.height = 31*1.5;
			bgImg.addChild(zongFenImg);
			
			zongFenLab = new Label();
			zongFenLab.fontSize = 40;
			zongFenLab.textAlign= TextAlign.CENTER;
			zongFenLab.color = 0x89755c;
			bgImg.addChild(zongFenLab);
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
			
			zongHuxiLab.width = 90;
			zongHuxiLab.height = 40;
			zongHuxiLab.x = zongHuxiImg.x+zongHuxiImg.width
			zongHuxiLab.y = zongHuxiImg.y;
			
			zongHuxiLab2.width = 90;
			zongHuxiLab2.height = 40;
			zongHuxiLab2.x =rankBgImg.x+rankBgImg.width-zongHuxiLab2.width-10
			zongHuxiLab2.y = zongHuxiImg.y;
			
			gaoShouImg.x = 60;
			gaoShouImg.y = 80;
			
			zongFenImg.x = 30;
			zongFenImg.y = bgImg.y+bgImg.height-zongFenImg.height-20;
			
			zongFenLab.x = zongFenImg.x+zongFenImg.width;
			zongFenLab.y = zongFenImg.y;
			zongFenLab.width = bgImg.width-zongFenLab.x;
			zongFenLab.height = 45;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			bgImg.source = 'assets/endAll/'+(isWinner?'floor_zjs04':'bac_02')+'.png';
			
			if (!data) return
			//			trace('data:',JSON.stringify(data),data.tjs);
			zongHuxiLab.text = "("+data.thx+")";
			zongHuxiLab2.text = action(data.thx)+"";
			zongFenLab.text = isWinner?"+"+data.tjs:""+data.tjs
			zongFenLab.color = isWinner?0xed5330:0x459ad7;
			winnerHeadView.data = data;
			gaoShouImg.visible = isWinner;
		}
		
		/**
		 * 四舍五入
		 */
		protected function action(number:Number):Number{
			var yuShu:Number = number%10;
			if(Math.abs(yuShu)>=5){
				if(number>0){
					number=number+(10-Math.abs(yuShu));
				}else{
					number=number-(10-Math.abs(yuShu));
				}
			}else{
				if(number>0){
					number=number-Math.abs(yuShu);
				}else{
					number=number+Math.abs(yuShu);
				}
			}
			return number
		}
		
	}
}