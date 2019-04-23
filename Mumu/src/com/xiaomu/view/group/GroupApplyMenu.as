package com.xiaomu.view.group
{
	import com.xiaomu.component.AppAlert;
	import com.xiaomu.component.AppAlertSmall;
	import com.xiaomu.event.AppManagerEvent;
	import com.xiaomu.manager.AppManager;
	import com.xiaomu.renderer.GroupRuleMenuRender;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	import com.xiaomu.util.TimeFormat;
	
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import coco.component.Alert;
	import coco.component.ButtonGroup;
	import coco.event.UIEvent;
	import coco.manager.PopUpManager;
	
	public class GroupApplyMenu extends ButtonGroup
	{
		public function GroupApplyMenu()
		{
			super();
			
			itemRendererClass = GroupRuleMenuRender
			itemRendererColumnCount = 1
			itemRendererHeight = 51;
			gap = 30;
			paddingTop = paddingBottom = 20;
			dataProvider = [{"name":"同意","image":"btn_guild_agree"},{"name":"拒绝","image":"btn_guild_disagree"}]
			width = 200
			height = 2 * itemRendererHeight+1*gap+paddingTop*2;
			addEventListener(UIEvent.CHANGE, this_changeHandler)
		}
		
		private static var instance:GroupApplyMenu
		
		public static function getInstane(): GroupApplyMenu {
			if (!instance) {
				instance = new GroupApplyMenu()
			}
			
			return instance
		}
		
		public var applyData:Object;
		
		
		protected function this_changeHandler(event:UIEvent):void
		{
			if(!applyData){
				selectedIndex = -1;
				return;
			}
			if(selectedItem.name=='同意'){
				trace("同意",JSON.stringify(applyData));
				updateGroupusers()
			}else if(selectedItem.name=='拒绝'){
				trace("拒绝");
				updateApplyrecords(false)
			}
			PopUpManager.removePopUp(this)
			selectedIndex = -1
		}
		
		/**
		 * 更新数据库中的groupusers表
		 */
		private function updateGroupusers():void
		{
			HttpApi.getInstane().addGroupUser({ 
				gid: AppData.getInstane().group.id, 
				uid: applyData.uid, 
				pid: AppData.getInstane().user.id,
				fs: 0,
				ll: 0}, 
				function (ee:Event):void {
					var response:Object = JSON.parse(ee.currentTarget.data)
					if (response.code == 0) {
						AppAlertSmall.show("添加成员成功");
						///修改申请表状态
						updateApplyrecords(true);
						AppManager.getInstance().dispatchEvent(new AppManagerEvent(AppManagerEvent.CHANGE_MEMBER_SUCCESS));
					} 
				})
		}
		
		/**
		 * 更新数据库中的applyrecord表
		 */
		private function updateApplyrecords(agree:Boolean):void
		{
			HttpApi.getInstane().updateApplyrecord({
				update: { finish:'T',result:(agree?'T':'F')}, query: {uid: applyData.uid,gid:applyData.gid}}, 
				function(e:Event):void{
//					trace('applyrecord表更新：',e.currentTarget.data);
					var response:Object = JSON.parse(e.currentTarget.data);
					if(response.code==0){
						///applyrecord表更新成功。
						getApplyTableFromDB();
					}
				},null);
		}
		
		private function getApplyTableFromDB():void
		{
			HttpApi.getInstane().findApplyrecord({gid:AppData.getInstane().group.id,finish:'F'},function(e:Event):void{
				var response:Object = JSON.parse(e.currentTarget.data);
				if(response.code == 0){
					(response.data as Array).map(function(element:*,index:int, arr:Array):Object{
						element.beijingTime = TimeFormat.getTimeObj(element.createdAt).time;
						element.newDate = TimeFormat.getTimeObj(element.createdAt).date;
					})
					
					AppData.getInstane().allWaitApplys = response.data as Array;
					trace('当前群中所有的待审核的申请：',JSON.stringify(AppData.getInstane().allWaitApplys));
					AppManager.getInstance().dispatchEvent(new AppManagerEvent(AppManagerEvent.CHANGE_APPLY_SUCCESS));
				}
			},null);
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xe8dab5);
			graphics.drawRoundRect(0,0,width,height,8,8);
			graphics.endFill();
		}
		
	}
}


