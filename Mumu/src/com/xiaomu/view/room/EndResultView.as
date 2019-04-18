package com.xiaomu.view.room
{
	import com.xiaomu.component.ImageButton;
	import com.xiaomu.event.AppManagerEvent;
	import com.xiaomu.manager.AppManager;
	import com.xiaomu.util.AppData;
	
	import flash.events.MouseEvent;
	
	import coco.component.Image;
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	
	/**
	 * 一局游戏结束后的总结算界面
	 */
	public class EndResultView extends UIComponent
	{
		public function EndResultView()
		{
			super();
			width = 1280;
			height = 720;
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
		
		private var _ruleData:Object;
		
		public function get ruleData():Object
		{
			return _ruleData;
		}
		
		public function set ruleData(value:Object):void
		{
			_ruleData = value;
			invalidateProperties();
		}
		
		private var bgImg:Image;
		private var closeImg:ImageButton;
		private var titleImg:Image;
		private var winnerFrom:WinnerFromView;
		private var otherFrom:WinnerFromView;
		private var winnerHeadView:UserHeadViewInEnd;
		private var otherHeadView:UserHeadViewInEnd;
		private var niaoFenView:NiaoFenViewInEndResult;
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			bgImg = new Image();
			bgImg.source = 'assets/endAll/floor_zjs01.png';
			bgImg.width = width;
			bgImg.height = 566;
			addChild(bgImg);
			
			closeImg = new ImageButton();
			closeImg.upImageSource = 'assets/endAll/btn_close_normal.png';
			closeImg.downImageSource = 'assets/endAll/btn_close_press.png';
			closeImg.width = 79;
			closeImg.height = 156;
			closeImg.addEventListener(MouseEvent.CLICK,closeImgHandler);
			addChild(closeImg);
			
			titleImg = new Image();
			titleImg.source = 'assets/endAll/Title_end.png';
			titleImg.width = 523;
			titleImg.height = 102;
			addChild(titleImg);
			
			winnerFrom = new WinnerFromView();
			winnerFrom.isWinner = true;
			addChild(winnerFrom);
			
			otherFrom = new WinnerFromView();
			otherFrom.isWinner = false;
			addChild(otherFrom);
			
			niaoFenView = new NiaoFenViewInEndResult();
			niaoFenView.width = 280;
			niaoFenView.height = 80;
			addChild(niaoFenView);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			bgImg.x = (width-bgImg.width)/2;
			bgImg.y = (height-bgImg.height)/2;
			
			closeImg.x = width-closeImg.width;
			closeImg.y = 0;
			
			titleImg.x = (width-titleImg.width)/2;
			
			winnerFrom.x = width/2-winnerFrom.width-20;
			winnerFrom.y = bgImg.y+(bgImg.height-winnerFrom.height)/2;
			
			otherFrom.x = width/2+20;
			otherFrom.y = winnerFrom.y;
			
			niaoFenView.x = (width-niaoFenView.width)/2;
			niaoFenView.y = height-niaoFenView.height-10;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if(data && data.hn){
				if(data.hn==data.us[0].username){
					winnerFrom.data = data.us[0];
					otherFrom.data = data.us[1];
				}else if(data.hn==data.us[1].username){
					winnerFrom.data = data.us[1];
					otherFrom.data = data.us[0];
				}
			}else if(data && !data.hn){
				winnerFrom.data = data.us[0];
				if(data.us.length>1){
					otherFrom.data = data.us[1];
				}
			}
			
			if(ruleData){
				niaoFenView.data = ruleData;
				niaoFenView.visible = ruleData.rulename;
			}else{
				niaoFenView.visible = false;
			}
		}
		
		protected function closeImgHandler(event:MouseEvent):void
		{
			AppManager.getInstance().dispatchEvent(new AppManagerEvent(AppManagerEvent.REFRESH_GROUP_DATA))
			AppData.getInstane().getUserData()
			PopUpManager.removePopUp(this);
		}
	}
}