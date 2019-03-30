package com.xiaomu.view.home.popUp1
{
	import com.xiaomu.component.ImageButton;
	
	import flash.events.MouseEvent;
	
	import coco.component.Image;
	import coco.component.TextArea;
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	import coco.util.FontFamily;
	
	/**
	 * 皮皮官方弹出设置界面--按钮为确定按钮-和取消按钮
	 */
	public class OfficalNoticeViewOfOkAndCancel extends UIComponent
	{
		public function OfficalNoticeViewOfOkAndCancel()
		{
			super();
			width = 915;
			height = 518;
		}
		
		private var _showText:String="测试数据。测试数据。测试数据。测试数据。测试数据。测试数据。测试数据。测试数据。测试数据。测试数据。测试数据。测试数据。vv";

		public function get showText():String
		{
			return _showText;
		}

		public function set showText(value:String):void
		{
			_showText = value;
			invalidateProperties();
		}

		private var bgImg:Image;
		private var titleImg:Image;
		private var okImg:ImageButton;
		private var cancelImg:ImageButton;
		private var lab:TextArea;
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			bgImg = new Image();
			bgImg.source = 'assets/home/popUp/bac_04.png';
			bgImg.width = width;
			bgImg.height = height;
			addChild(bgImg);
			
			titleImg = new Image();
			titleImg.source = 'assets/home/popUp/shezhi.png';
			titleImg.width = 293;
			titleImg.height = 86;
			addChild(titleImg);
			
			lab = new TextArea();
			lab.leading = 10;
			lab.editable = false;
			lab.fontSize = 24;
			lab.fontFamily = FontFamily.MICROSOFT_YAHEI;
			lab.width = width*0.7;
			lab.height = height*0.5;
			lab.backgroundAlpha = 0;
			lab.borderAlpha = 0;
			lab.color = 0x6f1614;
			addChild(lab);
			
			okImg = new ImageButton();
			okImg.upImageSource = 'assets/home/popUp/btn_confirm_normal.png';
			okImg.downImageSource = 'assets/home/popUp/btn_confirm_press.png';
			okImg.width = 166;
			okImg.height = 70;
			okImg.addEventListener(MouseEvent.CLICK,okImgHandler);
			addChild(okImg);
			
			cancelImg = new ImageButton();
			cancelImg.upImageSource = 'assets/home/popUp/Z_cancelNormal.png';
			cancelImg.downImageSource = 'assets/home/popUp/Z_cancelPress.png';
			cancelImg.width = 166;
			cancelImg.height = 70;
			cancelImg.addEventListener(MouseEvent.CLICK,cancelImgHandler);
			addChild(cancelImg);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			lab.text = showText;
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			bgImg.x = bgImg.y = 0;
			titleImg.x = (width-titleImg.width)/2;
			titleImg.y = 0;
			
			lab.x = (width-lab.width)/2;
			lab.y = height/3;
			
			okImg.x = width/2-okImg.width-20;
			okImg.y = height-okImg.height-20
				
			cancelImg.x = width/2+20;
			cancelImg.y = okImg.y
		}
		
		protected function okImgHandler(event:MouseEvent):void
		{
			PopUpManager.removePopUp(this);
		}
		
		protected function cancelImgHandler(event:MouseEvent):void
		{
			PopUpManager.removePopUp(this);
		}
		
	}
}