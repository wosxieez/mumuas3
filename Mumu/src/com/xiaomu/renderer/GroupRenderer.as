package com.xiaomu.renderer
{
	import com.xiaomu.util.AppData;
	
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextAlign;
	
	public class GroupRenderer extends DefaultItemRenderer
	{
		public function GroupRenderer()
		{
			super();
		    borderAlpha = 0
			backgroundAlpha = 0
		}
		
		private var _data:Object;

		override public function get data():Object
		{
			return _data;
		}

		override public function set data(value:Object):void
		{
			_data = value;
			invalidateProperties();
		}

		private var adminTitleImg:Image;
		private var bgImg:Image
		private var nameLab:Label;
		private var headBg:Image;
		private var headImg:Image;
		private var qunzhuLab:Label;
		private var chengyuanLab:Label;
		private var qunId:Label;
		override protected function createChildren():void {
			super.createChildren()
				
			labelDisplay.visible = false;
			
			bgImg = new Image()
			bgImg.source = 'assets/hall/floor_qun.png'
			addChild(bgImg)
			
			adminTitleImg = new Image();
			adminTitleImg.source ='assets/hall/T_qz.png';
			adminTitleImg.width = 117;
			adminTitleImg.height = 77;
			addChild(adminTitleImg);
			
			nameLab = new Label();
			nameLab.color = 0x844219;
			addChild(nameLab);
			
			headBg = new Image();
			headBg.source = "assets/hall/headback.png";
			addChild(headBg);
			
			headImg = new Image();
			headImg.source = "assets/hall/headIcon.png";
			addChild(headImg);
			
			qunzhuLab = new Label();
			qunzhuLab.textAlign = TextAlign.LEFT;
			qunzhuLab.height = 30;
			qunzhuLab.fontSize = 24;
			qunzhuLab.color =  0x844219;
			qunzhuLab.textAlign = TextAlign.LEFT;
			addChild(qunzhuLab);
			
			chengyuanLab = new Label();
			chengyuanLab.textAlign = TextAlign.LEFT;
			chengyuanLab.height = 30;
			chengyuanLab.fontSize = 24;
			chengyuanLab.color =  0x844219;
			chengyuanLab.textAlign = TextAlign.LEFT;
			addChild(chengyuanLab);
			
			qunId = new Label();
			qunId.textAlign = TextAlign.LEFT;
			qunId.height = 30;
			qunId.fontSize = 24;
			qunId.color =  0x844219;
			qunId.textAlign = TextAlign.LEFT;
			addChild(qunId);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			nameLab.text = data.groupname ? data.groupname: '/';
//			trace("群：",JSON.stringify(data));
//			trace("群id:",data.id);
			
			adminTitleImg.visible = data.adminName==AppData.getInstane().username
			qunzhuLab.text ="群主："+data.adminName;
			chengyuanLab.text ="成员："+data.userArr.length+"";
			qunId.text = "群ID："+data.id+""
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			bgImg.width = 298
			bgImg.height = 378
			bgImg.x = (width-bgImg.width)/2;
			bgImg.y = (height-bgImg.height)/2;
		
			adminTitleImg.x = bgImg.x+10;
			adminTitleImg.y = bgImg.y-20;
			
			nameLab.width = width;
			nameLab.height = 40;
			nameLab.fontSize = 30;
			nameLab.y = bgImg.y+35;
			
			headBg.width = headBg.height =  width/4;
			headImg.width = headImg.height = headBg.width*0.8;
			headBg.x = (width-headBg.width)/2;
			headBg.y = 140-10
			headImg.x = headBg.x+(headBg.width-headImg.width)/2;
			headImg.y = headBg.y+(headBg.height-headImg.height)/2;
			
			qunzhuLab.width = chengyuanLab.width = qunId.width = bgImg.width-40;
			qunzhuLab.x = chengyuanLab.x = qunId.x = bgImg.x+20;
			qunzhuLab.y = headBg.y+headBg.height+20;
			chengyuanLab.y = qunzhuLab.y+qunzhuLab.height+3;
			qunId.y = chengyuanLab.y+chengyuanLab.height+3;
		}
		
	}
}