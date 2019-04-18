package com.xiaomu.view.group
{
	import com.xiaomu.component.AppPanelBig;
	import com.xiaomu.component.ImageButton;
	import com.xiaomu.event.AppManagerEvent;
	import com.xiaomu.itemRender.GroupUserRender;
	import com.xiaomu.manager.AppManager;
	import com.xiaomu.renderer.ApplyListRender;
	import com.xiaomu.renderer.TabBarRender;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.ButtonGroup;
	import coco.component.Image;
	import coco.component.List;
	import coco.event.UIEvent;
	
	public class GroupUsersPanel extends AppPanelBig
	{
		public function GroupUsersPanel()
		{
			super();
			
			//			title = '成员管理'
			commitEnabled = false;
			AppManager.getInstance().addEventListener(AppManagerEvent.CHANGE_MEMBER_SUCCESS,changeMemberHandler);
			AppManager.getInstance().addEventListener(AppManagerEvent.UPDATE_MEMBER_INFO_SUCCESS,changeMemberHandler);
			AppManager.getInstance().addEventListener(AppManagerEvent.CHANGE_APPLY_SUCCESS,changeApplySuccessHandler);
		}
		
		protected function changeApplySuccessHandler(event:AppManagerEvent):void
		{
			applyList.dataProvider = AppData.getInstane().allWaitApplys;
			tabBar.selectedIndex = 1;
		}
		
		private var titleImg:Image;
		private var bgImg:Image;
		private var usersList: List///成员列表
		private var addUserButton:ImageButton;
		private var tabBar:ButtonGroup;///顶部tab栏
		private var applyList:List;///待审核列表
		
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
			
			tabBar = new ButtonGroup();
			tabBar.height = tabBar.itemRendererHeight = 54*0.8;
			tabBar.itemRendererWidth = 203*0.8;
			tabBar.gap = 10;
			tabBar.width = 2*tabBar.itemRendererWidth+tabBar.gap;
			tabBar.labelField = 'name';
			tabBar.selectedIndex = 0;
			tabBar.itemRendererClass = TabBarRender;
			tabBar.addEventListener(UIEvent.CHANGE,tabBarHandler);
			addChild(tabBar);
			
			usersList = new List() ///群成员列表
			usersList.itemRendererHeight = 80;
			usersList.gap = 10;
			usersList.itemRendererClass = GroupUserRender
			addChild(usersList)
			
			applyList = new List();
			applyList.itemRendererHeight = 80;
			applyList.gap = 10;
			applyList.itemRendererClass = ApplyListRender;
			addChild(applyList)
			applyList.visible = false;
			
			addUserButton = new ImageButton()
			addUserButton.width = 196;
			addUserButton.height =70;
			addUserButton.upImageSource = 'assets/guild/btn_guild_add_n.png'
			addUserButton.downImageSource = 'assets/guild/btn_guild_add_p.png'
			addUserButton.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
				new AddUserPanel().open()
			})
			addChild(addUserButton)
			
			if(AppData.getInstane().groupLL>=3){
				tabBar.dataProvider = [{"name":"群成员","value":"btn_guild_members"},{"name":"待审核","value":"btn_guild_verify"}];
			}else{
				tabBar.dataProvider = [{"name":"群成员","value":"btn_guild_members"}];
			}
			
			tabBar.selectedIndex = 0;
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			usersData.sort(sortUser)
			usersList.dataProvider = usersData
		}
		
		private function sortUser(a:Object, b:Object):Number {
			if(a.ll > b.ll) {
				return -1	
			} else if(a.ll < b.ll) {
				return 1
			} else  {
				return 0;
			}
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			titleImg.x = (contentWidth-titleImg.width)/2;
			titleImg.y = -70;
			
			tabBar.x = 20;
			tabBar.y = 20;
			
			addUserButton.x = (contentWidth-addUserButton.width)/2;
			addUserButton.y = contentHeight-addUserButton.height-20;
			
			bgImg.x = 10;
			bgImg.y = 70;
			bgImg.width = contentWidth-20;
			bgImg.height = addUserButton.y-bgImg.y-20;
			
			applyList.y= usersList.y = bgImg.y+10;
			applyList.x= usersList.x = bgImg.x+10;
			applyList.width= usersList.width = contentWidth-40
			applyList.height= usersList.height = addUserButton.y-usersList.y-30;
		}
		
		override public function open():void {
			super.open()
			refreshData();
		}
		
		private var oldSelectedIndex:int;
		/**
		 * 切换tab
		 */
		protected function tabBarHandler(event:UIEvent):void
		{
			if(tabBar.selectedItem){
				oldSelectedIndex = tabBar.selectedIndex;
			}else{
				tabBar.selectedIndex = oldSelectedIndex;
			}
			if(tabBar.selectedItem.name=='群成员'){
				usersList.visible = true;
				applyList.visible = false;
				addUserButton.visible = true;
			}else if(tabBar.selectedItem.name=='待审核'){
				usersList.visible = false;
				applyList.visible = true;
				applyList.dataProvider = AppData.getInstane().allWaitApplys;
				addUserButton.visible = false;
			}
		}
		
		/**
		 * 添加或踢出了成员
		 * 或是给成员上下分
		 */
		protected function changeMemberHandler(event:AppManagerEvent):void
		{
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
								AppData.getInstane().groupUsers = groupusers;
								//								trace("当前群中的所有用户信息:",JSON.stringify(groupusers));
								refreshData();
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
		
		private function refreshData():void
		{
			trace("当前群中的成员信息：",AppData.getInstane().groupUsers);
			trace("你在这个群中的等级：",AppData.getInstane().groupLL);
			trace("你的id",AppData.getInstane().user.id);
			//			usersData = AppData.getInstane().groupUsers;
			if(AppData.getInstane().groupLL==4||AppData.getInstane().groupLL==3){
				trace("你是馆主或是副馆主");
				usersData =  AppData.getInstane().groupUsers; ///如果是馆主，副馆主则显示所有人
			}else if(AppData.getInstane().groupLL==2||AppData.getInstane().groupLL==1){
				trace("你是管理员");
				var wodexiaji:Array = [];///我的下级
				for each (var user:Object in AppData.getInstane().groupUsers) 
				{
					if(user.pid==AppData.getInstane().user.id){
						wodexiaji.push(user)
					}
				}
				usersData = wodexiaji;
			}
		}
	}
}