package com.xiaomu.view
{
	import com.xiaomu.util.Api;
	import com.xiaomu.util.Assets;
	import com.xiaomu.view.registered.RegisterView;
	import com.xiaomu.view.user.UserInfo;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Button;
	import coco.component.Image;
	import coco.core.UIComponent;
	
	/**
	 * 大厅界面
	 */
	public class HallView extends UIComponent
	{
		public function HallView()
		{
			super();
		}
		
		private var bg : Image;
		private var createRoom:Button;
		private var joinRoom:Button;
		private var goBackBtn : Button;
		private var userInfo : UserInfo;
		override protected function createChildren():void {
			super.createChildren()
			
			bg = new Image()
			bg.source = Assets.getInstane().getAssets('hall_bg.png')
			addChild(bg)
			
			userInfo = new UserInfo();
			addChild(userInfo);
			
			createRoom = new Button()
			createRoom.width = 100;
			createRoom.height = 30;
			createRoom.label = '创建房间'
			createRoom.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
				Api.getInstane().createRoom('001', {count: 3}, 'wosxieez' + new Date().getMilliseconds())
				MainView.getInstane().pushView(HomeView)
			})
			addChild(createRoom)
			
			joinRoom = new Button()
			joinRoom.width = 100;
			joinRoom.height = 30;
			joinRoom.label = '加入房间'
			joinRoom.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
				Api.getInstane().joinRoom('001', 'wosxieez' + new Date().getMilliseconds())
				MainView.getInstane().pushView(HomeView)
			})
			addChild(joinRoom)
			
			goBackBtn = new Button();
			goBackBtn.width = 50;
			goBackBtn.height = 20;
			goBackBtn.label = '返回';
			goBackBtn.addEventListener(MouseEvent.CLICK,goBackHandler);
			addChild(goBackBtn);
		}
		
		protected function goBackHandler(event:MouseEvent):void
		{
			MainView.getInstane().pushView(RegisterView);
		}
		
		override protected function updateDisplayList():void{
			super.updateDisplayList();
			
			bg.width = width;
			bg.height = height;
			
			createRoom.x = (width-createRoom.width)/2;
			createRoom.y = height/2
			
			joinRoom.x = (width-joinRoom.width)/2;
			joinRoom.y = createRoom.y+createRoom.height+20
			
			goBackBtn.x = width-goBackBtn.width;
		}
		
	}
}