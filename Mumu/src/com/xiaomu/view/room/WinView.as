package com.xiaomu.view.room
{
	import com.xiaomu.component.ImageButton;
	import com.xiaomu.renderer.CardGroupRender;
	import com.xiaomu.util.Actions;
	import com.xiaomu.util.Api;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.CardUtil;
	
	import flash.events.MouseEvent;
	
	import coco.component.ButtonGroup;
	import coco.component.Image;
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	
	public class WinView extends UIComponent
	{
		public function WinView()
		{
			super();
			
			width = 960
			height = 540+80;
		}
		
		private static var instance:WinView
		
		public static function getInstane(): WinView {
			if (!instance) {
				instance = new WinView()
			}
			
			return instance
		}
		
		private var background:Image
		private var diban:Image
		private var diban1:Image
		/*private var winUserHead:RoomUserHead*/
		/*private var winUserCards:WinCards
		private var winUserTypes:WinTypes*/
		private var headView1:UserHeadInResult;
		private var headView2:UserHeadInResult;
		private var cardGroup1:ButtonGroup;
		private var cardGroup2:ButtonGroup;
		private var huxiResult1:HuXiResult;
		private var huxiResult2:HuXiResult;
		private var titleImage:Image
		private var closeImage:Image
		private var readyImage:ImageButton;
		
		private var _data:Object
		
		public function get data():Object
		{
			return _data;
		}
		
		public function set data(value:Object):void
		{
			// users hx: 40 wn: wosxieez  hts:[1,2, 3]
			_data = value;
			invalidateProperties()
		}
		
		override protected function createChildren():void {
			super.createChildren()
			
			background = new Image()
			background.source = 'assets/room/win_bg.png'
			addChild(background)
			
			titleImage = new Image()
			titleImage.width = 220
			titleImage.height = 64
			addChild(titleImage)
			
			diban = new Image()
			diban.scaleGrid = [20, 20, 20, 20]
			diban.width = 900
			diban.height = 202
			diban.y = 110
			diban.source = 'assets/room/diban_xiao.png'
			addChild(diban)
			
			diban1 = new Image()
			diban1.scaleGrid = [20, 20, 20, 20]
			diban1.width = 900
			diban1.height = 202
			diban1.y = diban.y + diban.height + 5
			diban1.source = 'assets/room/diban_xiao.png'
			addChild(diban1)
			
			/*winUserHead = new RoomUserHead()
			winUserHead.y = diban.y + 10
			winUserHead.username = '哈哈哈';
			winUserHead.thx = 2;
			winUserHead.huxi = 10;
			winUserHead.isZhuang = true;
			winUserHead.isNiao = true;
			winUserHead.isFocus = true;
			addChild(winUserHead)*/
			
			headView1 = new UserHeadInResult();
			addChild(headView1);
			
			headView2 = new UserHeadInResult();
			addChild(headView2);
			
			cardGroup1 = new ButtonGroup();
			cardGroup1.itemRendererHeight = 35;
			cardGroup1.height = 35*5;
			cardGroup1.gap = 10;
			cardGroup1.itemRendererClass = CardGroupRender;
			addChild(cardGroup1);
			
			cardGroup2 = new ButtonGroup();
			cardGroup2.itemRendererHeight = 35;
			cardGroup2.height = 35*5;
			cardGroup2.gap = 10;
			cardGroup2.itemRendererClass = CardGroupRender;
			addChild(cardGroup2);
			
			huxiResult1 = new HuXiResult();
			addChild(huxiResult1);
			
			huxiResult2 = new HuXiResult();
			addChild(huxiResult2);
			
			closeImage = new Image()
			closeImage.width = closeImage.height = 64
			closeImage.source = 'assets/room/pdk_btn_close.png'
			closeImage.addEventListener(MouseEvent.CLICK, closeImage_clickHandler)
			addChild(closeImage)
			
			readyImage = new ImageButton();
			readyImage.upImageSource = 'assets/room/Z_zhunbei2.png';
			readyImage.downImageSource = 'assets/room/Z_zhunbei2dianji.png';
			readyImage.width = 196;
			readyImage.height = 70;
			readyImage.addEventListener(MouseEvent.CLICK,readyImageHandler);
			addChild(readyImage);
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			trace("winView一把结束后的数据：",JSON.stringify(data));
			
			if(!data.hasOwnProperty("hn")){
				titleImage.source = 'assets/room/pingju.png'///荒庄
			}else if (data.hn == AppData.getInstane().user.username) {
				titleImage.source = 'assets/room/Z_you_win.png'
			} else if(data.hn != AppData.getInstane().user.username) {
				titleImage.source = 'assets/room/Z_nishul.png'
			}
			
			///判断us中哪个是胡的人
			if(data.hasOwnProperty("hn")){
				if(data.us.length>1){
					if(data.us[1].username==data.hn){
						///数据位置对调,把胡的人放在前面
						var newArr:Array = [];
						newArr[0]=data.us[1];
						newArr[1]=data.us[0];
						data.us = newArr;
						trace("数据位置对调");
					}
				}
			}
			///玩家1
			if(data.us[0].handCards.length>0){
				var arrs:Array = CardUtil.getInstane().riffle(data.us[0].handCards)///手里牌进行排序
				trace("胡的人手里的牌1：",JSON.stringify(arrs));
				for each (var item:Array in arrs) 
				{
					data.us[0].groupCards.push({"name":"no","cards":item})///
				}
				data.us[0].handCards = [];
			}
			cardGroup1.dataProvider = (data.us[0].groupCards as Array);
			cardGroup1.width = cardGroup1.dataProvider.length*40;
			headView1.isZhuang = data.zn==data.us[0].username;
			headView1.username = data.us[0].username;
			
			if(data.hasOwnProperty("hts")){ ///荒庄
				huxiResult1.data = data.hts;
			}else{
				huxiResult1.data = [];
				trace("荒庄");
				huxiResult1.isHuangzhuang = true;
				if(data.zn==data.us[0].username){
					trace("第一位又是庄");
					huxiResult1.isZhuang = true;
				}else{
					huxiResult1.isZhuang = false;
				}
			}
			huxiResult1.huxi = data.us[0].hx;
			huxiResult1.isHu = data.hn==data.us[0].username;
			///玩家2
			if(data.us.length>1){
				cardGroup2.visible = true;
				headView2.visible = true;
				huxiResult2.visible = true;
				if(data.us[1].handCards.length>0){
					var arrs1:Array = CardUtil.getInstane().riffle(data.us[1].handCards)///手里牌进行排序
					trace("手里的牌2：",JSON.stringify(arrs1));
					for each (var item1:Array in arrs1) 
					{
						data.us[1].groupCards.push({"name":"no","cards":item1})///
					}
					data.us[1].handCards = [];
				}
				cardGroup2.dataProvider = (data.us[1].groupCards as Array);
				cardGroup2.width = cardGroup2.dataProvider.length*40;
				headView2.isZhuang = data.zn==data.us[1].username;
				headView2.username = data.us[1].username;
				
				huxiResult2.huxi = data.us[1].hx;
				huxiResult2.isHu = data.hn==data.us[1].username;
				if(data.hasOwnProperty("hts")){
					huxiResult2.data = data.hts;
				}else{
					huxiResult2.data = [];///荒庄。又是庄
					trace("荒庄");
					huxiResult2.isHuangzhuang = true;
					if(data.zn==data.us[1].username){
						trace("又是庄2");
						huxiResult2.isZhuang = true;
					}else{
						huxiResult2.isZhuang = false;
					}
				}
				
			}else{
				cardGroup2.visible = false;
				headView2.visible = false;
				huxiResult2.visible = false;
			}
			///到底谁胡，谁放炮
			if(data.hasOwnProperty("hts")){
				if((data.hts as Array).indexOf(3)!=-1){
					if(data.hn==data.us[0].username){
						huxiResult2.isHu
						huxiResult2.data = [3];
						huxiResult1.data =  data.hts.filter(function (item:*, index:int, array:Array):Boolean {
							if (item == 3)  return false
							else return true
						})
					}else{
						huxiResult1.data = [3];
						huxiResult2.data =  data.hts.filter(function (item:*, index:int, array:Array):Boolean {
							if (item == 3)  return false
							else return true
						})
					}
				}
			}
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			background.width = width
			background.height = height
			
			titleImage.x = (width - titleImage.width) / 2 
			
			diban.x = ( width - diban.width ) / 2
			diban1.x = ( width - diban1.width ) / 2
			
			headView1.width = 260;
			headView1.height = 160;
			headView1.x = diban.x + 10
			headView1.y = diban.y+10;
			
			cardGroup1.x = headView1.x + headView1.width + 10;
			cardGroup1.y = headView1.y;
			
			headView2.width = 260;
			headView2.height = 160;
			headView2.x = diban1.x + 10
			headView2.y = diban1.y+10;
			
			cardGroup2.x = headView2.x + headView2.width + 10;
			cardGroup2.y = headView2.y;
			
			huxiResult1.x = 620
			huxiResult1.y = cardGroup1.y;
			huxiResult1.width = 300;
			huxiResult1.height = 200;
			
			huxiResult2.x = 620
			huxiResult2.y =  cardGroup2.y;
			huxiResult2.width = 300;
			huxiResult2.height = 200;
			
			closeImage.x = width - closeImage.width - 55
				
			readyImage.x = (width-readyImage.width)/2;
			readyImage.y = height - readyImage.height - 20;
		}
		
		override protected function drawSkin():void {
			super.drawSkin()
		}
		
		protected function readyImageHandler(event:MouseEvent):void
		{
			var action:Object = { name: Actions.Ready, data: true }
			Api.getInstane().sendAction(action)
			PopUpManager.removePopUp(this)
		}
		
		protected function closeImage_clickHandler(event:MouseEvent):void
		{
			var action:Object = { name: Actions.Ready, data: true }
			Api.getInstane().sendAction(action)
			PopUpManager.removePopUp(this)
		}
		
		
	}
}