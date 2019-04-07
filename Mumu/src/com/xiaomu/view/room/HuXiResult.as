package com.xiaomu.view.room
{
	import com.xiaomu.renderer.HuXiResultRender;
	
	import coco.component.ButtonGroup;
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextAlign;
	import coco.core.UIComponent;
	
	/**
	 * 胡息显示界面
	 */
	public class HuXiResult extends UIComponent
	{
		public function HuXiResult()
		{
			super();
		}
		private var _data:Array;
		
		public function get data():Array
		{
			return _data;
		}
		
		public function set data(value:Array):void
		{
			_data = value;
			invalidateProperties();
		}
		
		private var _huxi:Number;
		
		public function get huxi():Number
		{
			return _huxi;
		}
		
		public function set huxi(value:Number):void
		{
			_huxi = value;
			invalidateProperties();
		}
		
		private var _isHu:Boolean;
		
		public function get isHu():Boolean
		{
			return _isHu;
		}
		
		public function set isHu(value:Boolean):void
		{
			_isHu = value;
			invalidateProperties();
		}
		
		private var _isHuangzhuang:Boolean;
		
		public function get isHuangzhuang():Boolean
		{
			return _isHuangzhuang;
		}
		
		public function set isHuangzhuang(value:Boolean):void
		{
			_isHuangzhuang = value;
			invalidateProperties();
		}
		
		private var _isZhuang:Boolean
		
		public function get isZhuang():Boolean
		{
			return _isZhuang;
		}
		
		public function set isZhuang(value:Boolean):void
		{
			_isZhuang = value;
			invalidateProperties();
		}
		
		
		private var huxiImg:ButtonGroup;
		private var huxiLab:Label;
		private var jiaJianLab:Label;
		private var huImg:Image;
		override protected function createChildren():void
		{
			super.createChildren();
			
			huxiImg =  new ButtonGroup();
			huxiImg.itemRendererColumnCount = 4;
			huxiImg.gap = 10;
			huxiImg.itemRendererClass = HuXiResultRender;
			addChild(huxiImg);
			
			huxiLab = new Label();
			huxiLab.textAlign = TextAlign.LEFT;
			huxiLab.fontSize = 24;
			huxiLab.bold = true;
			huxiLab.color = 0x555555;
			addChild(huxiLab);
			
			jiaJianLab = new Label();
			jiaJianLab.textAlign = TextAlign.LEFT;
			jiaJianLab.fontSize = 24;
			jiaJianLab.bold = true;
			jiaJianLab.color = 0x555555;
			addChild(jiaJianLab);
			
			huImg = new Image();
			huImg.source = 'assets/room/hts/hu.png';
			huImg.width = 104*0.9;
			huImg.height = 186*0.9;
			addChild(huImg);
			huImg.visible = false;
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			huxiImg.width= width ;
			huxiImg.height=(huxiImg.width-3*huxiImg.gap)/4;
			huxiImg.y = 70;
			
			jiaJianLab.x = 180;
			
			huImg.x = 210;
			huImg.y = 10;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			huxiImg.dataProvider = data;
			if(!data){return}
			
			if(isHuangzhuang){
				huxiImg.visible = false;
				huxiLab.visible = false;
				if(isZhuang){
					jiaJianLab.text = huxi+"";
				}else{
					jiaJianLab.text = "+0";
				}
				return;
			}
			
			if(isHu){
				///胡了
				huxiLab.visible =true;
				huxiImg.visible = true;
				huxiLab.text = '胡息   '+huxi;
				jiaJianLab.text = '+'+huxi;
			}else{
				if(data.indexOf(3)!=-1){
					///没胡，放了炮
					huxiImg.visible = true;
					huxiLab.visible = false;
					jiaJianLab.text = huxi+"";
				}else{
					//没胡没放炮
					huxiImg.visible = false;
					huxiLab.visible = false;
					jiaJianLab.text = '+0'
				}
			}
			
			huImg.visible = isHu;
		}
		
//		override protected function drawSkin():void
//		{
//			super.drawSkin();
//			
//			graphics.clear();
//			graphics.beginFill(0xff0000,0.1);
//			graphics.drawRect(0,0,width,height);
//			graphics.endFill();
//		}
	}
}