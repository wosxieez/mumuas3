package com.xiaomu.view.group
{
	import com.xiaomu.component.ImageButton;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	import com.xiaomu.view.MainView;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Button;
	import coco.component.HGroup;
	import coco.component.List;
	import coco.core.UIComponent;
	
	public class GroupUsersView extends UIComponent
	{
		public function GroupUsersView()
		{
			super();
		}
		
		private var usersList: List
		private var bottomGroup: HGroup
		private var backButton: ImageButton
		
		private var _usersData:Array
		
		public function get usersData():Array
		{
			return _usersData;
		}
		
		public function set usersData(value:Array):void
		{
			_usersData = value;
			invalidateProperties()
		}
		
		override protected function createChildren():void {
			super.createChildren()
			
			usersList = new List()
			usersList.itemRendererColumnCount = 4
			usersList.labelField = 'username'
			addChild(usersList)
			
			bottomGroup = new HGroup()
			addChild(bottomGroup)
			
			var addUserButton:Button = new Button()
			addUserButton.label = '添加成员'
			addUserButton.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
				new AddUserPanel().open()
			})
			bottomGroup.addChild(addUserButton)
			
			backButton = new ImageButton()
			backButton.upImageSource = 'assets/club_btn_back.png';
			backButton.width = 71;
			backButton.height = 86;
			backButton.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
				MainView.getInstane().popView()
			})
			addChild(backButton)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			usersList.dataProvider = usersData
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			bottomGroup.width = width
			bottomGroup.height = 100
			bottomGroup.y = height - bottomGroup.height
			
			usersList.itemRendererWidth = width / 4
			usersList.itemRendererHeight = usersList.itemRendererWidth / 2
			usersList.width = width
			usersList.height = bottomGroup.y
			
			backButton.x = width - backButton.width - 10
			backButton.y = 10
		}
		
		public function init():void {
			HttpApi.getInstane().getGroupUser({gid: AppData.getInstane().group.id}, function (e:Event):void {
				try
				{
					var response:Object = JSON.parse(e.currentTarget.data)
					if (response.code == 0) {
						var groupusers:Array = response.data
						var uids:Array = []
						for each(var groupuser:Object in groupusers) {
							uids.push(groupuser.uid)
						}
						HttpApi.getInstane().getUser({id: {'$in': uids}}, function (ee:Event):void {
							var response2:Object = JSON.parse(ee.currentTarget.data)
							if (response2.code == 0) {
								usersData = response2.data
							}
						})
					} else {
					}
				} 
				catch(error:Error) 
				{
				}
			})
		}
		
	}
}