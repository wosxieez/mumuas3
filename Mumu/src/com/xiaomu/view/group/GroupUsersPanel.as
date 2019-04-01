package com.xiaomu.view.group
{
	import com.xiaomu.component.AppPanelBig;
	import com.xiaomu.itemRender.GroupUserRender;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Button;
	import coco.component.HGroup;
	import coco.component.List;
	
	public class GroupUsersPanel extends AppPanelBig
	{
		public function GroupUsersPanel()
		{
			super();
			
			title = '成员管理'
		}
		
		private var usersList: List
		private var bottomGroup: HGroup
		
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
			usersList.itemRendererClass = GroupUserRender
			addChild(usersList)
			
			bottomGroup = new HGroup()
			addChild(bottomGroup)
			
			var addUserButton:Button = new Button()
			addUserButton.label = '添加成员'
			addUserButton.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
				new AddUserPanel().open()
			})
			bottomGroup.addChild(addUserButton)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			usersList.dataProvider = usersData
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			bottomGroup.width = contentWidth
			bottomGroup.height = 50
			bottomGroup.y = contentHeight - bottomGroup.height
			
			usersList.width = contentWidth
			usersList.height = bottomGroup.y
		}
		
		override public function open():void {
			super.open()
				
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
								var users:Array = response2.data
								
								function getUser(id:int):Object {
									for each(var user:Object in users) {
										if (user.id == id) {
											return user
										} 
									}
									return null
								}
								
								for each(var groupuser:Object in groupusers) {
									var guser:Object = getUser(groupuser.uid)
									if (guser) {
										groupuser.username = guser.username
									}
								}
								
								usersData = groupusers
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