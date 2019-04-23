package com.xiaomu.view.group
{
	import com.xiaomu.component.AppAlertSmall;
	import com.xiaomu.component.ImageButton;
	import com.xiaomu.renderer.HistoryListRenderForLeveL0;
	import com.xiaomu.renderer.HistoryListRenderForLeveL12;
	import com.xiaomu.renderer.HistoryListRenderForLeveL34;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	import com.xiaomu.util.TimeFormat;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Image;
	import coco.component.List;
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	
	/**
	 * 战绩，上下分界面
	 */
	public class ScoreHistoryPanel extends UIComponent
	{
		public function ScoreHistoryPanel()
		{
			super();
			width = 1200;
			height = 620;
		}
		
		private var titleImg:Image;
		private var bgImg:Image;
		private var historyList:List;
		private var closeBtn:ImageButton;
		
		private var _historyData:Array;
		
		public function get historyData():Array
		{
			return _historyData;
		}
		
		public function set historyData(value:Array):void
		{
			_historyData = value;
			invalidateProperties();
		}
		
		
		override protected function createChildren():void {
			super.createChildren()
			
			titleImg = new Image();
			titleImg.source = 'assets/group/Title_zhanji.png';
			titleImg.width = 293;
			titleImg.height = 86;
			addChild(titleImg);
			
			bgImg = new Image();
			bgImg.source = 'assets/guild/guild_diban01.png';
			addChild(bgImg);
			
			historyList = new List();
			historyList.itemRendererHeight = 160;
			historyList.gap = 15;
			addChild(historyList);
			
			closeBtn = new ImageButton();
			closeBtn.width = 86;
			closeBtn.height = 84;
			closeBtn.upImageSource = 'assets/component/pdk_btn_close.png';
			closeBtn.downImageSource = 'assets/component/pdk_btn_close_press.png';
			closeBtn.addEventListener(MouseEvent.CLICK,closeHandler);
			addChild(closeBtn);
		}
		
		protected function closeHandler(event:MouseEvent):void
		{
			PopUpManager.removePopUp(this);
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			historyList.dataProvider = historyData;
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			titleImg.x = (width-titleImg.width)/2;
			titleImg.y = -titleImg.height/2;
			
			closeBtn.x = width-closeBtn.width;
			closeBtn.y = 0;
			
			bgImg.x = 10;
			bgImg.y = 50;
			bgImg.width = width-20;
			bgImg.height = height-70;
			
			historyList.x = bgImg.x+10;
			historyList.y = bgImg.y+10;
			historyList.width = bgImg.width-20;
			historyList.height = bgImg.height-20
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xcbbb90);
			graphics.drawRoundRect(0,0,width,height,10,10);
			graphics.endFill();
		}
		
		 public function open():void {
			 PopUpManager.centerPopUp(PopUpManager.addPopUp(this,null,true,false,0,0.4));
			getNowDataFromDB();
		}
		
		/**
		 * 获取战绩数据
		 */
		private function getNowDataFromDB():void
		{
			trace('当前群id:',AppData.getInstane().group.id);
			//查询所有战绩
			checkUserLevel();
		}		
		
		private function checkUserLevel():void
		{
			trace("你是",AppData.getInstane().user.username,"当前群里，你的等级是：",AppData.getInstane().groupLL);
			if(AppData.getInstane().groupLL==4||AppData.getInstane().groupLL==3){ ///如果是馆主或副馆主。可以看到该群的所有分值变动情况
				HttpApi.getInstane().getfight({gid:AppData.getInstane().group.id},function(e:Event):void{
					trace("馆主，副馆主。查询这个群的所有战绩和上下分记录");
					var respones:Object = JSON.parse(e.currentTarget.data);
					if(respones.code==0){
						historyList.itemRendererClass = HistoryListRenderForLeveL34;
						respones.data.sortOn("id", Array.NUMERIC | Array.DESCENDING);
						(respones.data as Array).map(function(element:*,index:int, arr:Array):Object{
							element.beijingTime = TimeFormat.getTimeObj(element.createdAt).time;
							element.newDate = TimeFormat.getTimeObj(element.createdAt).date;
						})
						historyData = respones.data;
					}else{
						AppAlertSmall.show("查询失败")
					}
				},null);
			}else if(AppData.getInstane().groupLL==0){ ///如果是普通成员，只能看的自己的分值变动情况（上下分，和战绩）
				HttpApi.getInstane().getfight({gid:AppData.getInstane().group.id,
					'$or': [
						{'wid': AppData.getInstane().user.id},
						{'lid': AppData.getInstane().user.id},
					]
				},function(e:Event):void{
					trace('普通成员。查询赢家id,或输家id。可以查询到个人的战绩和上下分记录');///查wid,lid。
					var respones:Object = JSON.parse(e.currentTarget.data);
					if(respones.code==0){
						historyList.itemRendererClass = HistoryListRenderForLeveL0;
						respones.data.sortOn("id", Array.NUMERIC | Array.DESCENDING);
						(respones.data as Array).map(function(element:*,index:int, arr:Array):Object{
							element.beijingTime = TimeFormat.getTimeObj(element.createdAt).time;
							element.newDate = TimeFormat.getTimeObj(element.createdAt).date;
						})
						historyData = respones.data;
					}else{
						AppAlertSmall.show("查询失败")
					}
				},null);
			}else{///如果是一二级管理员，你能看到自己底下的人的分值变动情况。和自己的变动情况（战绩等）
				
				HttpApi.getInstane().getfight({gid:AppData.getInstane().group.id,
					'$or': [
						{'wid': AppData.getInstane().user.id},
						{'lid': AppData.getInstane().user.id},
						{'w1id': AppData.getInstane().user.id},
						{'w2id': AppData.getInstane().user.id},
						{'l1id': AppData.getInstane().user.id},
						{'l2id': AppData.getInstane().user.id},
					]
				},function(e:Event):void{
					trace("一二级管理员。自己的战绩，给别人的上下分。自己的提成");///查 wid,lid,w1id,w2id,l1id,l2id  （涉及到自己的id）
					var respones:Object = JSON.parse(e.currentTarget.data);
					if(respones.code==0){
						historyList.itemRendererClass = HistoryListRenderForLeveL12;
						respones.data.sortOn("id", Array.NUMERIC | Array.DESCENDING);
						(respones.data as Array).map(function(element:*,index:int, arr:Array):Object{
							element.beijingTime = TimeFormat.getTimeObj(element.createdAt).time;
							element.newDate = TimeFormat.getTimeObj(element.createdAt).date;
						})
						historyData = respones.data;
					}else{
						AppAlertSmall.show("查询失败")
					}
				},null);
			}
		}
	}
}