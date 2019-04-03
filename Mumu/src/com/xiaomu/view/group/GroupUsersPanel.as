package com.xiaomu.view.group
{
	import com.xiaomu.component.AppPanelBig;
	import com.xiaomu.component.ImageButton;
	import com.xiaomu.itemRender.GroupUserRender;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Button;
	import coco.component.Image;
	import coco.component.List;
	
	public class GroupUsersPanel extends AppPanelBig
	{
		public function GroupUsersPanel()
		{
			super();
			
//			title = '成员管理'
			commitEnabled = false;
		}
		
		private var titleImg:Image;
		private var bgImg:Image;
		private var usersList: List
		private var addUserButton:ImageButton;
		
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
				
			titleImg = new Image();
			titleImg.source = 'assets/guild/guild_title_guildManage.png';
			titleImg.width = 293;
			titleImg.height = 86;
			addChild(titleImg);
				
			bgImg = new Image();
			bgImg.source = 'assets/guild/guild_diban01.png';
			addChild(bgImg);
			
			usersList = new List()
			usersList.itemRendererHeight = 70;
			usersList.gap = 10;
			usersList.itemRendererClass = GroupUserRender
			addChild(usersList)
			
			addUserButton = new ImageButton()
			addUserButton.width = 196;
			addUserButton.height =70;
			addUserButton.upImageSource = 'assets/guild/btn_guild_add_n.png'
			addUserButton.downImageSource = 'assets/guild/btn_guild_add_p.png'
			addUserButton.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
				new AddUserPanel().open()
			})
			addChild(addUserButton)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			usersList.dataProvider = usersData
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
				
			titleImg.x = (contentWidth-titleImg.width)/2;
			titleImg.y = -60;
			
			addUserButton.x = (contentWidth-addUserButton.width)/2;
			addUserButton.y = contentHeight-addUserButton.height-20;
			
			bgImg.x = 10;
			bgImg.y = 70;
			bgImg.width = contentWidth-20;
			bgImg.height = addUserButton.y-bgImg.y-20;
			
			usersList.y = bgImg.y+10;
			usersList.x = bgImg.x+10;
			usersList.width = contentWidth-40
			usersList.height = addUserButton.y-usersList.y-30;
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