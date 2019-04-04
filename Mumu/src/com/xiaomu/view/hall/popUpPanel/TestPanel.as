package com.xiaomu.view.hall.popUpPanel
{
	import com.xiaomu.component.AppPanelBig;
	import com.xiaomu.component.ImageButton;
	
	import coco.component.Image;
	import coco.component.Label;
	import coco.manager.PopUpManager;
	
	/**
	 * 一盘游戏结果显示界面
	 */
	public class TestPanel extends AppPanelBig
	{
		public function TestPanel()
		{
			super();
			commitEnabled = false;
		}
		
		private static var instance:TestPanel
		
		public static function getInstane(): TestPanel {
			if (!instance) {
				instance = new TestPanel()
			}
			
			return instance
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
		
		private var titleImg:Image; ///你赢了，还是你输了
		private var subBgImg1:Image;///两个用户的背景
		private var subBgImg2:Image;///两个用户的背景
		private var userIcon1:Image;///用户头像 暂时固定图片
		private var userName1:Label;
		private var userIcon2:Image;///用户头像 暂时固定图片
		private var userName2:Label;
		private var zhunbeiBtn:ImageButton;
		
		override protected function createChildren():void {
			super.createChildren()
				
			titleImg = new Image();
			titleImg.width = 357;
			titleImg.height = 104;
			titleImg.source = 'assets/result/Z_you_win.png';
			addRawChild(titleImg);
			
			subBgImg1 = new Image();
			subBgImg1.source = 'assets/guild/guild_diban01.png';
			addChild(subBgImg1);
			
			subBgImg2 = new Image();
			subBgImg2.source = 'assets/guild/guild_diban01.png';
			addChild(subBgImg2);
			
			zhunbeiBtn = new ImageButton();
			zhunbeiBtn.upImageSource = 'assets/result/Z_zhunbei2.png';
			zhunbeiBtn.downImageSource = 'assets/result/Z_zhunbei2dianji.png';
			zhunbeiBtn.width = 196;
			zhunbeiBtn.height = 70;
			addChild(zhunbeiBtn);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			subBgImg1.x = 10;
			subBgImg1.y = 40;
			subBgImg1.width = contentWidth-20;
			subBgImg1.height = contentHeight/2-20-60
			
			subBgImg2.x = 10;
			subBgImg2.y = subBgImg1.y+subBgImg1.height+10;
			subBgImg2.width = contentWidth-20;
			subBgImg2.height = contentHeight/2-20-60
				
			zhunbeiBtn.x = (contentWidth-zhunbeiBtn.width)/2;
			zhunbeiBtn.y = contentHeight-zhunbeiBtn.height-20;
			
			titleImg.x = (width-titleImg.width)/2;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			trace("数据：",JSON.stringify(data));
		}
		
		override public function open():void {
			PopUpManager.centerPopUp(PopUpManager.addPopUp(this, null, true, false, 0x000000,0.5))
		}
	}
}