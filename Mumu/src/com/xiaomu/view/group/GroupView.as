package com.xiaomu.view.group
{
	import com.xiaomu.component.ImageButton;
	import com.xiaomu.component.Loading;
	import com.xiaomu.event.ApiEvent;
	import com.xiaomu.renderer.RoomRenderer;
	import com.xiaomu.util.Api;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	import com.xiaomu.util.Notifications;
	import com.xiaomu.view.MainView;
	import com.xiaomu.view.hall.HallView;
	import com.xiaomu.view.room.RoomView;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Alert;
	import coco.component.Button;
	import coco.component.HGroup;
	import coco.component.HorizontalAlign;
	import coco.component.Image;
	import coco.component.List;
	import coco.component.VerticalAlign;
	import coco.core.UIComponent;
	
	
	/**
	 * 群视图---测试
	 */	
	public class GroupView extends UIComponent
	{
		public function GroupView()
		{
			super();
			
			Api.getInstane().addEventListener(ApiEvent.JOIN_ROOM_SUCCESS, joinRoomSuccessHandler)
			Api.getInstane().addEventListener(ApiEvent.JOIN_ROOM_FAULT, joinRoomFaultHandler)
			Api.getInstane().addEventListener(ApiEvent.ON_GROUP, onGroupHandler)
		}
		
		private var bg:Image
		private var bg1:Image
		private var roomsList:List
		private var goback:ImageButton
		private var refreshButton:ImageButton
		private var userSettingButton:ImageButton
		private var startButton:ImageButton
		private var bottomGroup:HGroup
		
		private var _roomsData:Array
		
		public function get roomsData():Array
		{
			return _roomsData;
		}
		
		public function set roomsData(value:Array):void
		{
			_roomsData = value;
			invalidateProperties()
		}
		
		override protected function createChildren():void {
			super.createChildren()
			
			bg = new Image()
			bg.source = 'assets/group/guild2_bg.png'
			addChild(bg)
			
			bg1 = new Image()
			bg1.height = 114
			bg1.source = 'assets/group/guild2_bg2.png'
			addChild(bg1)
			
			roomsList = new List()
			roomsList.itemRendererClass = RoomRenderer
			roomsList.itemRendererColumnCount = 4
			roomsList.horizontalAlign = HorizontalAlign.JUSTIFY;
			roomsList.gap = 10;
			roomsList.padding = 10;
			roomsList.paddingTop = 0;
			addChild(roomsList)
			
			bottomGroup = new HGroup()
			bottomGroup.verticalAlign = VerticalAlign.MIDDLE
			bottomGroup.horizontalAlign = HorizontalAlign.CENTER
			bottomGroup.height = 114
			addChild(bottomGroup)
			
			var addRuleButton:Button = new Button()
			addRuleButton.label = '添加玩法'
			addRuleButton.addEventListener(MouseEvent.CLICK, addRuleButton_clickHandler)
			bottomGroup.addChild(addRuleButton)
			
			var switchRuleButton:Button = new Button()
			switchRuleButton.label = '切换玩法'
			switchRuleButton.addEventListener(MouseEvent.CLICK, switchRuleButton_clickHandler)
			bottomGroup.addChild(switchRuleButton)
			
			var ruleSettingButton:Button = new Button()
			ruleSettingButton.label = '玩法管理'
			ruleSettingButton.addEventListener(MouseEvent.CLICK, ruleSettingButton_clickHandler)
			bottomGroup.addChild(ruleSettingButton)
			
			userSettingButton = new ImageButton()
			userSettingButton.width = 85
			userSettingButton.height = 91
			userSettingButton.upImageSource = 'assets/group/btn_guild2_guildManage_n.png';
			userSettingButton.downImageSource = 'assets/group/btn_guild2_guildManage_p.png';
			userSettingButton.addEventListener(MouseEvent.CLICK, userSettingButton_clickHandler)
			addChild(userSettingButton)
			
			refreshButton = new ImageButton()
			refreshButton.width = 85
			refreshButton.height = 91
			refreshButton.upImageSource = 'assets/group/btn_guild2_refresh_n.png';
			refreshButton.downImageSource = 'assets/group/btn_guild2_refresh_p.png';
			addChild(refreshButton)
			
			goback= new ImageButton()
			goback.upImageSource = 'assets/group/btn_guild2_return_n.png';
			goback.downImageSource = 'assets/group/btn_guild2_return_p.png';
			goback.x = 20
			goback.y = 10
			goback.width = 85;
			goback.height = 91;
			goback.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
				Api.getInstane().leaveGroup()			
				MainView.getInstane().popView(HallView)
			})
			addChild(goback)
			
			startButton = new ImageButton()
			startButton.width = 133
			startButton.height = 133
			startButton.upImageSource = 'assets/group/btn_guild2_quick_n.png';
			startButton.downImageSource = 'assets/group/btn_guild2_quick_p.png';
			startButton.addEventListener(MouseEvent.CLICK, startButton_clickHandler)
			addChild(startButton)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			bg.width = width
			bg.height = height
				
			bg1.width = width
			bg1.y = height - bg1.height
			
			roomsList.y = roomsList.padding;
			roomsList.height = height - roomsList.y
			roomsList.width = width
			roomsList.itemRendererHeight = (roomsList.width- roomsList.padding * 3 - roomsList.gap*2) / 4
			
			bottomGroup.width = width
			bottomGroup.y = height - bottomGroup.height
				
			userSettingButton.x = width - userSettingButton.width - 20
			userSettingButton.y = 10
				
			refreshButton.x = userSettingButton.x - 20 - refreshButton.width
			refreshButton.y  = 10
				
			startButton.x = width - startButton.width
			startButton.y = height - startButton.height
		}
		
		public function init(): void {
			HttpApi.getInstane().getRule({gid: AppData.getInstane().group.id}, function (e:Event):void {
				try
				{
					var response:Object = JSON.parse(e.currentTarget.data)
					if (response.code == 0 && response.data.length > 0) {
						AppData.getInstane().rule = response.data[0]
						trace(JSON.stringify(AppData.getInstane().rule))
					} else {
					}
				} 
				catch(error:Error) 
				{
				}
			})
		}
		
		protected function joinRoomSuccessHandler(event:ApiEvent):void
		{
			trace('跳转到房间')
			RoomView(MainView.getInstane().pushView(RoomView)).init(AppData.getInstane().rule)
			Loading.getInstance().close()
		}
		
		protected function joinRoomFaultHandler(event:ApiEvent):void
		{
			Loading.getInstance().close()
			Alert.show(JSON.stringify(event.data))
		}
		
		protected function onGroupHandler(event:ApiEvent):void
		{
			const notification:Object = event.data
			//			trace('notification:',JSON.stringify(notification));
			switch(notification.name)
			{
				case Notifications.onJoinGroup:
				{
					break;
				}
				case Notifications.onLeaveGroup:
				{
					break;
				}
				case Notifications.onJoinRoom:
				{
					break;
				}
				case Notifications.onLeaveRoom:
				{
					break;
				}
				default:
				{
					break;
				}
			}
		}
		
		protected function addRuleButton_clickHandler(event:MouseEvent):void
		{
			new AddRulePanel().open()
		}
		
		protected function switchRuleButton_clickHandler(event:MouseEvent):void
		{
			new SwitchRulePanel().open()
		}
		
		protected function userSettingButton_clickHandler(event:MouseEvent):void
		{
			new GroupUsersPanel().open()
		}
		
		protected function ruleSettingButton_clickHandler(event:MouseEvent):void
		{
			new GroupRulesPanel().open()
		}
		
		protected function startButton_clickHandler(event:MouseEvent):void
		{
			Api.getInstane().joinRoom(AppData.getInstane().rule)
		}
		
	}
}