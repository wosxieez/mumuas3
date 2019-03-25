package com.xiaomu.view.room
{
	import com.xiaomu.util.AppData;
	
	import flash.events.MouseEvent;
	
	import coco.component.Image;
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	
	public class WinView extends UIComponent
	{
		public function WinView()
		{
			super();
			
			width = 960
			height = 540
		}
		
		private static var instance:WinView
		
		public static function getInstane(): WinView {
			if (!instance) {
				instance = new WinView()
			}
			
			return instance
		}
		
		private var background:Image
		private var diban:Image
		private var diban1:Image
		private var winUserHead:RoomUserHead
		private var winUserCards:WinCards
		private var winUserTypes:WinTypes
		
		private var titleImage:Image
		private var closeImage:Image
		
		private var _data:Object
		
		public function get data():Object
		{
			return _data;
		}
		
		public function set data(value:Object):void
		{
			// users hx: 40 wn: wosxieez  hts:[1,2, 3]
			_data = value;
			invalidateProperties()
		}
		
		override protected function createChildren():void {
			super.createChildren()
			
			background = new Image()
			background.source = 'assets/room/win_bg.png'
			addChild(background)
			
			titleImage = new Image()
			titleImage.width = 220
			titleImage.height = 64
			addChild(titleImage)
			
			diban = new Image()
			diban.scaleGrid = [20, 20, 20, 20]
			diban.width = 900
			diban.height = 180
			diban.y = 110
			diban.source = 'assets/room/diban_xiao.png'
			addChild(diban)
			
			winUserHead = new RoomUserHead()
			winUserHead.y = diban.y + 10
			addChild(winUserHead)
			
			winUserCards = new WinCards()
			winUserCards.y = diban.y + 10
			winUserCards.height = 160
			addChild(winUserCards)
			
			winUserTypes = new WinTypes()
			winUserTypes.height = 160
			winUserTypes.y = diban.y + 10
			addChild(winUserTypes)
			
			diban1 = new Image()
			diban1.scaleGrid = [20, 20, 20, 20]
			diban1.width = 900
			diban1.height = 225
			diban1.y = diban.y + diban.height + 5
			diban1.source = 'assets/room/diban_xiao.png'
			addChild(diban1)
			
			closeImage = new Image()
			closeImage.width = closeImage.height = 64
			closeImage.source = 'assets/room/pdk_btn_close.png'
			closeImage.addEventListener(MouseEvent.CLICK, closeImage_clickHandler)
			addChild(closeImage)
		}
		
		protected function closeImage_clickHandler(event:MouseEvent):void
		{
			PopUpManager.removePopUp(this)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			if (!data) {
				titleImage.source = 'assets/room/pingju.png'
				winUserCards.data = []
				winUserTypes.data = {hx: 0, hts: []}
				return
			} 
			
			if (data.wn == AppData.getInstane().user.username) {
				titleImage.source = 'assets/room/Z_you_win.png'
			} else {
				titleImage.source = 'assets/room/Z_nishul.png'
			}
			
			for each(var user:Object in data.users) {
				if (user.username == data.wn) {
					winUserCards.data = user.groupCards
				}
			}
			
			winUserTypes.data = {hx: data.hx, hts: data.hts}
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			background.width = width
			background.height = height
			
			titleImage.x = (width - titleImage.width) / 2 
			
			diban.x = ( width - diban.width ) / 2
			winUserHead.x = diban.x + 10
			winUserCards.x = winUserHead.x + winUserHead.width + 10
			winUserTypes.x = winUserCards.x + winUserCards.width + 10
			winUserTypes.width = width - 40 - winUserTypes.x
			diban1.x = ( width - diban1.width ) / 2
			
			closeImage.x = width - closeImage.width - 55
		}
		
		override protected function drawSkin():void {
			super.drawSkin()
		}
		
		
	}
}