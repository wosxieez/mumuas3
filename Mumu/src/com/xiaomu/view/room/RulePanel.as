package com.xiaomu.view.room
{
	import coco.component.Image;
	import coco.component.Label;
	import coco.core.UIComponent;
	
	/**
	 * RoomView中弹出的显示玩法的小界面
	 */
	public class RulePanel extends UIComponent
	{
		public function RulePanel()
		{
			super();
			width = 225;
			height = 286;
		}
		
		private static var instance:RulePanel
		
		public static function getInstane(): RulePanel {
			if (!instance) {
				instance = new RulePanel()
			}
			return instance
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

		private var bgImg:Image;  //225 286
		private var nameLab:Label;//名称
		private var playerNumLab:Label//人数
		override protected function createChildren():void
		{
			bgImg = new Image();
			bgImg.source = 'assets/other/diban_wanfa.png';
			addChild(bgImg);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			bgImg.width = width;
			bgImg.height = height;
		}
	}
}