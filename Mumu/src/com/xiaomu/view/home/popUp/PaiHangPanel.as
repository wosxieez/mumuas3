package com.xiaomu.view.home.popUp
{
	import com.xiaomu.component.AppPanelSmall;
	import com.xiaomu.itemRender.PaiHangRender;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	
	import coco.component.Image;
	import coco.component.List;
	
	public class PaiHangPanel extends AppPanelSmall
	{
		public function PaiHangPanel()
		{
			super();
		}
		
		private static var instance:PaiHangPanel;
		
		public static function getInstance():PaiHangPanel
		{
			if (!instance)
				instance = new PaiHangPanel();
			
			return instance;
		}
		
		private var list:List
		private var titleImg:Image;
		
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
			
			list = new List()
			list.itemRendererHeight = 80;
			list.itemRendererClass = PaiHangRender
			addChild(list)
		
			titleImg = new Image()
			titleImg.width = 293
			titleImg.height = 86
			titleImg.source = 'assets/home/paihang.png'
			addRawChild(titleImg)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
				
			list.dataProvider = usersData
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
				
			titleImg.x = (width - titleImg.width) / 2
			
			list.width = contentWidth
			list.height = contentHeight
		}
		
		override public function open():void {
			super.open()
			HttpApi.getInstane().getUser2({limit: 10, order: 'jb DESC'}, function (e:Event):void {
				try
				{
					var response:Object = JSON.parse(e.currentTarget.data)
					if (response.code == 0) {
						usersData = response.data
					}
				} 
				catch(error:Error) 
				{
					
				}
			})
		}
		
	}
}