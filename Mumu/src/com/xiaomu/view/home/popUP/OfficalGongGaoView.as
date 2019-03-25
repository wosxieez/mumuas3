package com.xiaomu.view.home.popUP
{
	import com.xiaomu.component.ImageBtnWithUpAndDown;
	import com.xiaomu.view.MainView;
	
	import flash.events.MouseEvent;
	
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.List;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	import coco.manager.PopUpManager;
	
	/**
	 * 皮皮官方公告界面，多模块切换的公告通知界面组件
	 */
	public class OfficalGongGaoView extends UIComponent
	{
		public function OfficalGongGaoView()
		{
			super();
			width = 1280;
			height = 720;
		}
		
		private var bgImg:Image;
		private var bgImg1:Image;
		private var titleImg:Image;
		private var closeBtn:ImageBtnWithUpAndDown;
		private var viewChangeNavigation:MainView;
		private var leftList:List;
		override protected function createChildren():void
		{
			super.createChildren();
			
			bgImg = new Image();
			bgImg.source = 'assets/home/popUp/bg.png';
			bgImg.width = width;
			bgImg.height = height;
			addChild(bgImg);
			
			bgImg1 = new Image();
			bgImg1.source = 'assets/home/popUp/floor_08_new.png';
			bgImg1.width = width;
			bgImg1.height = height;
			addChild(bgImg1);
			
			titleImg = new Image();
			titleImg.source = 'assets/home/popUp/popup_title_notice_new.png';
			titleImg.width = 179;
			titleImg.height = 55;
			addChild(titleImg);
			
			closeBtn = new ImageBtnWithUpAndDown();
			closeBtn.upImageSource = 'assets/home/settingPanel/btn_close_normal.png';
			closeBtn.downImageSource = 'assets/home/settingPanel/btn_close_press.png';
			closeBtn.width = 79
			closeBtn.height = 156
			closeBtn.addEventListener(MouseEvent.CLICK,closeBtnHandler);
			addChild(closeBtn);
			
			leftList = new List();
			leftList.dataProvider = [{'name':'公告','image':'','view':GongGaoSubView},{'name':'通知','image':'','view':TongzhiSubView}];
			leftList.gap = 10;
			leftList.width = 210;
			leftList.height = height*0.8;
			leftList.itemRendererHeight = 65;
			leftList.labelField = 'name';
			leftList.addEventListener(UIEvent.CHANGE,leftListChangeHandler);
			addChild(leftList);
			leftList.selectedIndex = 0;
			
			addChild(InnerView.getInstane());
			InnerView.getInstane().pushView(GongGaoSubView);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			titleImg.x = 65;
			titleImg.y = 25;
			
			closeBtn.x = width-closeBtn.width-20;
			closeBtn.y = 20;
			
			leftList.x = 50;
			leftList.y = 100;
			
			InnerView.getInstane().x = 330;
			InnerView.getInstane().y = 120;
			InnerView.getInstane().width = 850;
			InnerView.getInstane().height = 500;
		}
		
		protected function closeBtnHandler(event:MouseEvent):void
		{
			PopUpManager.removePopUp(this);
		}
		
		private var oldSelectIndex:int;
		protected function leftListChangeHandler(event:UIEvent):void
		{
			if(leftList.selectedItem){
				oldSelectIndex = leftList.selectedIndex;
			}else{
				leftList.selectedIndex = oldSelectIndex;
			}
			InnerView.getInstane().pushView(leftList.selectedItem.view);
		}
	}
}