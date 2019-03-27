package com.xiaomu.view.room
{
	import com.xiaomu.renderer.ChatRenderer;
	import com.xiaomu.util.Api;
	import com.xiaomu.util.AppData;
	
	import coco.component.List;
	import coco.component.Panel;
	import coco.event.UIEvent;
	import coco.manager.PopUpManager;
	
	public class RoomChatView extends Panel
	{
		public function RoomChatView()
		{
			super();
			
			borderColor = 0x000000
			backgroundColor = 0x000000
			backgroundAlpha = 0.6
			titleHeight = 40
			title = '聊天'
			width = 300
			height = 400
		}
		
		private static var instance:RoomChatView
		
		public static function getInstane(): RoomChatView {
			if (!instance) {
				instance = new RoomChatView()
			}
			
			return instance
		}
		
		private var list:List
		
		override protected function createChildren():void {
			super.createChildren()
			
			list = new List()
			list.verticalScrollEnabled = false
			list.itemRendererHeight = 40
			list.itemRendererClass = ChatRenderer
			list.dataProvider = ['快点啊，都等得我花儿都谢了',
				'怎么又短线了，网络怎么这么差啊',
				'不要走，决战到天亮', 
				'你的牌打的也太好了', 
				'你是MM还是GG',
				'和你合作真是太愉快了啊', 
				'大家好，很高兴见到各位', 
				'各位，真是不好意思我得离开一会', 
				'不要吵了不要吵了，吵啥嘛吵']
			list.addEventListener(UIEvent.CHANGE, list_changeHandler)
			addChild(list)
			
			titleDisplay.color = 0xFFFFFF
		}
		
		protected function list_changeHandler(event:UIEvent):void
		{
			Api.getInstane().sendRoomMessage({pn: AppData.getInstane().user.username, cmd: 1, data: list.selectedIndex}, function ():void {})
			list.selectedIndex = -1
			PopUpManager.removePopUp(this)
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			list.width = contentWidth
			list.height = contentHeight
		}
		
		public function open(x:Number, y:Number):void {
			this.x = x
			this.y = y
			PopUpManager.addPopUp(this, null, null, true)
		}
		
	}
}