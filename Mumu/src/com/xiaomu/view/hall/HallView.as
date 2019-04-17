package com.xiaomu.view.hall
{
	import com.xiaomu.component.AppAlert;
	import com.xiaomu.component.ImageButton;
	import com.xiaomu.component.Loading;
	import com.xiaomu.event.AppManagerEvent;
	import com.xiaomu.manager.AppManager;
	import com.xiaomu.renderer.GroupRenderer;
	import com.xiaomu.util.Api;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.Audio;
	import com.xiaomu.util.HttpApi;
	import com.xiaomu.view.MainView;
	import com.xiaomu.view.group.GroupView;
	import com.xiaomu.view.hall.popUpPanel.AddGroupPanel;
	import com.xiaomu.view.home.HomeView;
	import com.xiaomu.view.userBarView.UserInfoView;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.HorizontalAlign;
	import coco.component.Image;
	import coco.component.List;
	import coco.component.VerticalAlign;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	
	/**
	 * 大厅界面
	 */
	public class HallView extends UIComponent
	{
		public function HallView()
		{
			super();
			AppManager.getInstance().addEventListener(AppManagerEvent.CREATE_GROUP_SUCCESS,createGroupSuccessHandler);
		}
		
		protected function createGroupSuccessHandler(event:AppManagerEvent):void
		{
			init();
		}
		
		private var bg:Image
		private var infoImg:Image;
		private var npcImg:Image;
		private var titleImg:Image;
		private var groupsList:List
		private var signoutBtn:Image
		private var goback:ImageButton
		private var userInfoView : UserInfoView
		private var createGroupBtn : ImageButton
		private var joinGroupBtn:ImageButton;
		
		private var _groupsData:Array
		
		public function get groupsData():Array
		{
			return _groupsData;
		}
		
		public function set groupsData(value:Array):void
		{
			_groupsData = value;
			invalidateProperties()
		}
		
		override protected function createChildren():void {
			super.createChildren()
			
			bg = new Image()
			bg.source = 'assets/hall/guild_hall_bg.png'
			addChild(bg)
			
			titleImg = new Image();
			titleImg.source ='assets/hall/title_wdpyq.png';
			addChild(titleImg);
			
			infoImg = new Image();
			infoImg.source = 'assets/hall/guild_hall_info.png';
			addChild(infoImg);
			infoImg.visible = false;
			
			npcImg = new Image();
			npcImg.source = 'assets/hall/guild_hall_npc.png';
			addChild(npcImg);
			npcImg.visible = false;
			
			groupsList = new List()
			groupsList.padding = 20
			groupsList.gap = 10
			groupsList.horizontalScrollEnabled = true
			groupsList.verticalScrollEnabled = false
			groupsList.itemRendererClass = GroupRenderer
			groupsList.itemRendererRowCount = 1
			groupsList.itemRendererHeight = 456
			groupsList.itemRendererWidth = 345
			groupsList.horizontalAlign = HorizontalAlign.CENTER
			groupsList.verticalAlign = VerticalAlign.MIDDLE
			groupsList.addEventListener(UIEvent.CHANGE, groupsList_changeHandler)
			addChild(groupsList)
			
			goback= new ImageButton()
			goback.upImageSource = 'assets/group/btn_guild2_return_n.png';
			goback.downImageSource = 'assets/group/btn_guild2_return_p.png';
			goback.x = 20
			goback.y = 10
			goback.width = 85;
			goback.height = 91;
			goback.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
				MainView.getInstane().popView(HomeView);
			})
			addChild(goback)
			
			createGroupBtn = new ImageButton();
			createGroupBtn.width = 196
			createGroupBtn.height = 70
			createGroupBtn.upImageSource = 'assets/hall/btn_guild_create_group_n.png';
			createGroupBtn.downImageSource = 'assets/hall/btn_guild_create_group_p.png';
			createGroupBtn.addEventListener(MouseEvent.CLICK,createGroupHandler);
			addChild(createGroupBtn);
			
			joinGroupBtn = new ImageButton();
			joinGroupBtn.width = 196
			joinGroupBtn.height = 70
			joinGroupBtn.upImageSource = 'assets/hall/btn_guild_request_n.png';
			joinGroupBtn.downImageSource = 'assets/hall/btn_guild_request_p.png';
			joinGroupBtn.addEventListener(MouseEvent.CLICK,joinGroupBtnHandler);
			addChild(joinGroupBtn);
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			groupsList.dataProvider = groupsData
			if(groupsData==null||JSON.stringify(groupsData) == "[]"){
				infoImg.visible = npcImg.visible = true;
			}else{
				infoImg.visible = npcImg.visible = false;
			}
		}
		
		override protected function updateDisplayList():void{
			super.updateDisplayList();
			
			bg.width = width
			bg.height = height
			
			infoImg.width = 462*0.7;
			infoImg.height = 554*0.7;
			infoImg.y = (height-infoImg.height)/2+30;
			infoImg.x = (width-infoImg.width)/2
			
			npcImg.width = 244*0.8;
			npcImg.height = 445*0.8;
			npcImg.y = (height-npcImg.height)/2+20;
			npcImg.x = infoImg.x+infoImg.width+30;
			
			titleImg.width = 308;
			titleImg.height = 74;
			titleImg.y = 80;
			titleImg.x = (width-titleImg.width)/2;
			
			groupsList.width = width
			groupsList.height = groupsList.itemRendererHeight
			groupsList.y = (height-groupsList.height) / 2 - 20
			
			createGroupBtn.x = width/2- createGroupBtn.width-20
			createGroupBtn.y = height - createGroupBtn.height - 30
			
			joinGroupBtn.x = width/2+30;
			joinGroupBtn.y = createGroupBtn.y;
		}
		
		protected function groupsList_changeHandler(event:UIEvent):void
		{
			if(!groupsList.selectedItem){
				return
			}
			AppData.getInstane().group = groupsList.selectedItem;
			Loading.getInstance().open()
			Api.getInstane().joinGroup(AppData.getInstane().user.username, AppData.getInstane().group.id, 
				function (response:Object):void {
					Loading.getInstance().close()
					if (response.code == 0) {
						var rooms:Array = response.data as Array
						Loading.getInstance().close()
						GroupView(MainView.getInstane().pushView(GroupView)).init(rooms)
					} else {
						AppData.getInstane().group = null
						AppAlert.show(JSON.stringify(response.data))
					}
				})
			groupsList.selectedIndex = -1
		}
		
		public function init():void {
			////查询出所有的GroupUser数据
			var allGroupUsersArr:Array = [];
			HttpApi.getInstane().getGroupUser({},function(e:Event):void{
				var response3:Object = JSON.parse(e.currentTarget.data)
				allGroupUsersArr = response3.data;///当前群里的用户信息
				////查询出所有的User数据
				var allUsersArr:Array = [];
				HttpApi.getInstane().getUser({},function(e:Event):void{
					var response4:Object = JSON.parse(e.currentTarget.data)
					if(response4.code==0){
						allUsersArr = response4.data; ///获取到所有用户的信息
						// 加载群信息
						HttpApi.getInstane().getGroupUser({uid: AppData.getInstane().user.id}, 
							function (e:Event):void {
								try
								{
									var response:Object = JSON.parse(e.currentTarget.data)
									if (response.code == 0) {
										var groupusers:Array = response.data
										var gids:Array = []
										for each(var groupuser:Object in groupusers) {
											gids.push(groupuser.gid)
											//trace("加入过哪些群：",JSON.stringify(gids));
										}
										HttpApi.getInstane().getGroup({id: {'$in': gids}}, 
											function (ee:Event):void {
												var response2:Object = JSON.parse(ee.currentTarget.data)
												if (response2.code == 0) {
													for each (var j:Object in response2.data) 
													{
														j.userArr=[];///这个群里有哪些成员，包含群主
														j.adminId=null;
														//trace("我有这些群::",JSON.stringify(j));
														for each (var i:Object in allGroupUsersArr) 
														{
															if(j.id==i.gid){
																j.userArr.push(i.uid)
																//trace("群",j.id,"人",i.uid,"等级",i.ll);
																if(i.ll==4){
																	j.adminId = i.uid;
																}
															}
														}
													}
													for each (var k:Object in response2.data) 
													{
														k.adminName='/';
														for each (var userObj:Object in allUsersArr) 
														{
															if(userObj.id==k.adminId){
																k.adminName=userObj.username
															}
														}
													}
													groupsData = response2.data
													//													trace("groupsData:",JSON.stringify(response2.data));
												} else {
													groupsData = null
												}
											})
									} else {
										groupsData = null
									}
								} 
								catch(error:Error) 
								{
									groupsData = null
								}
							})
					}
				},null);
				
			},null);
		}
		
		public function dispose():void {
			Audio.getInstane().stopBGM()
		}
		
		/**
		 * 创建亲友圈
		 */
		protected function createGroupHandler(event:MouseEvent):void{
			
			if (AppData.getInstane().user.ll >= 2) {
				new AddGroupPanel().open()
			} else {
				AppAlert.show('您没有权限操作')
			}
		}
		
		/**
		 * 加入亲友圈
		 */
		protected function joinGroupBtnHandler(event:MouseEvent):void
		{
			AppAlert.show('程序员小哥哥正在努力的开发中....\r请联系群主手动添加')
		}
	}
}