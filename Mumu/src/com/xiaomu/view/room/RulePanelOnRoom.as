package com.xiaomu.view.room
{
	import com.xiaomu.renderer.RuleListRender;
	
	import coco.component.Image;
	import coco.component.List;
	import coco.core.UIComponent;
	
	public class RulePanelOnRoom extends UIComponent
	{
		public function RulePanelOnRoom()
		{
			super();
			width = 225;
			height = 286;
		}
		
		private var _data:Object;
		
		public function get data():Object
		{
			return _data;
		}
		
		public function set data(value:Object):void
		{
			_data = value;
			invalidateProperties();
		}
		
		private var bgImg:Image;
		private var ruleList:List;
		override protected function createChildren():void
		{
			super.createChildren();
			
			bgImg = new Image();
			bgImg.source = 'assets/room/diban_wanfa.png';
			bgImg.width = width;
			bgImg.height = height;
			addChild(bgImg);
			
			ruleList = new List();
			ruleList.verticalScrollEnabled = false;
			ruleList.itemRendererHeight = 34;
			ruleList.width = width-20;
			ruleList.height = 8*ruleList.itemRendererHeight;
			ruleList.itemRendererClass = RuleListRender;
			addChild(ruleList);
		}
		
		/*
		{
		"hx": 15,
		"tc1": 1.8,
		"fd": 200,
		"tf": 60,
		"gid": 23,
		"xf": 0.5,
		"tc2": 2,
		"tc": 5,
		"rulename": "5毛放炮罚",
		"id": 68,
		"cc": 2,
		"updatedAt": "2019-04-10T13:03:53.000Z",
		"nf": 20,
		"plz": 50,
		"createdAt": "2019-04-10T13:03:53.000Z"
		}
		*/
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			///把object=>array
			var tempArr:Array = [];
			for(var k :* in data) 
			{
				switch(k)
				{
					case 'rulename':
					{
						tempArr[0] = {"name":k,"value":data[k]};
						break;
					}
					case 'fd':
					{
						tempArr[1] = {"name":k,"value":data[k]};
						break;
					}
					case 'cc':
					{
						tempArr[2] = {"name":k,"value":data[k]};
						break;
					}
					case 'xf':
					{
						tempArr[3] = {"name":k,"value":data[k]};
						break;
					}
					case 'hx':
					{
						tempArr[4] = {"name":k,"value":data[k]};
						break;
					}
					case 'nf':
					{
						tempArr[5] = {"name":k,"value":data[k]};
						break;
					}
					default:
					{
						break;
					}
				}
			}
//			trace("tempArr",JSON.stringify(tempArr));
			ruleList.dataProvider = tempArr;
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			ruleList.x = 10
			ruleList.y = 32;
		}
		
	}
}