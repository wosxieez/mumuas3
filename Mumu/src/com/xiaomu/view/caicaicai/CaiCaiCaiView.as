package com.xiaomu.view.caicaicai
{
	import com.xiaomu.component.AppAlertSmall;
	import com.xiaomu.component.ImageButton;
	import com.xiaomu.component.LabelhasBg;
	import com.xiaomu.event.AppDataEvent;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	import com.xiaomu.view.MainView;
	import com.xiaomu.view.home.HomeView;
	import com.xiaomu.view.userBarView.GoldOrCardShowBar;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import coco.component.Button;
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextAlign;
	import coco.component.TextArea;
	import coco.component.TextInput;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	
	public class CaiCaiCaiView extends UIComponent
	{
		public function CaiCaiCaiView()
		{
			super();
			width = 1280;
			height = 720;
			
			AppData.getInstane().addEventListener(AppDataEvent.USER_DATA_CHAGNED, user_dataChangedHandler)
		}
		
		private var allowClick:Boolean=true;
		
		private var newJinBin:Number;
		private var bgImg:Image;
		private var goback:ImageButton;
		private var resultLab:Label;
		private var bigBtn:Button;
		private var smallBtn:Button;
		private var numberBar:CaiBarTool;
		private var goldBar:GoldOrCardShowBar;
		private var xiazhuTitle:Label
		private var xiazhuInput:TextInput;
		private var xiazhuUnit:Label
		private var chu2Btn:Button;
		private var cheng2Btn:Button;
		private var minBtn:Button;
		private var maxBtn:Button;
		private var amountLab:LabelhasBg
		private var refreshButton:ImageButton;
		private var shuomingText:TextArea;
		private var lab:Label;
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			bgImg = new Image()
			bgImg.source = 'assets/hall/guild_hall_bg.png'
			addChild(bgImg)
			
			lab = new Label();
			lab.alpha = 0.5
			lab.color = 0xffffff;
			addChild(lab);
			
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
			
			refreshButton = new ImageButton()
			refreshButton.width = 85
			refreshButton.height = 91
			refreshButton.upImageSource = 'assets/group/btn_guild2_refresh_n.png';
			refreshButton.downImageSource = 'assets/group/btn_guild2_refresh_p.png';
			refreshButton.addEventListener(MouseEvent.CLICK, refreshButton_clickHandler)
			addChild(refreshButton)
			
			goldBar = new GoldOrCardShowBar();
			goldBar.width = 240;
			goldBar.height = 50;
			goldBar.iconWidthHeight = [goldBar.height,goldBar.height];
			goldBar.typeSource = 'assets/user/icon_jinbi_01.png';
			goldBar.unit = '金币'
			addChild(goldBar);
			
			bigBtn = new Button();
			bigBtn.label ='押大';
			bigBtn.color = 0xffffff;
			bigBtn.fontSize = 30;
			bigBtn.bold = true;
			bigBtn.width = 150*1.2;
			bigBtn.height = 60*1.2;
			bigBtn.radius = 10;
			bigBtn.backgroundColor = 0xf2c40b;
			bigBtn.addEventListener(MouseEvent.CLICK,bigHandler);
			addChild(bigBtn);
			
			smallBtn = new Button();
			smallBtn.label ='押小';
			smallBtn.color = 0xffffff;
			smallBtn.fontSize = 30;
			smallBtn.bold = true;
			smallBtn.width = 150*1.2;
			smallBtn.height = 60*1.2;
			smallBtn.radius = 10;
			smallBtn.backgroundColor = 0xf2c40b;
			smallBtn.addEventListener(MouseEvent.CLICK,smallHandler);
			addChild(smallBtn);
			
			numberBar = new CaiBarTool();
			numberBar.width = 250*1.2;
			numberBar.height = 80*1.2;
			addChild(numberBar);
			
			xiazhuInput =  new TextInput();
			xiazhuInput.borderAlpha = 0;
			xiazhuInput.radius = 10;
			xiazhuInput.backgroundColor = 0x09543f;
			xiazhuInput.color = 0xfeba02;
			xiazhuInput.bold = true;
			xiazhuInput.restrict = '0-9';
			xiazhuInput.text = '1';
			xiazhuInput.fontSize = 30;
			xiazhuInput.textAlign = TextAlign.CENTER;
			xiazhuInput.addEventListener(UIEvent.CHANGE,changeHandler);
			addChild(xiazhuInput);
			
			xiazhuTitle = new Label()
			xiazhuTitle.fontSize = 26
			xiazhuTitle.width = 120
			xiazhuTitle.borderAlpha = 0
			xiazhuTitle.topLeftRadius = xiazhuTitle.bottomLeftRadius = 10
			xiazhuTitle.autoDrawSkin = true
			xiazhuTitle.backgroundColor = 0x142f4d;
			xiazhuTitle.color = 0xffffff;
			xiazhuTitle.text = '每局投'
			addChild(xiazhuTitle)
			
			xiazhuUnit = new Label()
			xiazhuUnit.width = 108
			xiazhuUnit.borderAlpha = 0
			xiazhuUnit.topRightRadius = xiazhuUnit.bottomRightRadius = 10
			xiazhuUnit.autoDrawSkin = true
			xiazhuUnit.backgroundColor = 0x142f4d;
			xiazhuUnit.color = 0xffffff;
			xiazhuUnit.text = '金币'
			xiazhuUnit.fontSize = 26
			addChild(xiazhuUnit)
			
			amountLab = new LabelhasBg();
			amountLab.bgcolor = 0x142f4d;
			amountLab.color = 0xffffff;
			amountLab.text = '金币数';
			amountLab.fontSize = 26;
			amountLab.width = 100*1.2;
			amountLab.height = 70;
			addChild(amountLab);
			
			chu2Btn = new Button();
			chu2Btn.label = '/ 2';
			chu2Btn.width = 70*1.2;
			chu2Btn.height = 70;
			chu2Btn.fontSize = 26;
			chu2Btn.backgroundColor = 0x142f4d;
			chu2Btn.color = 0xffffff;
			chu2Btn.borderAlpha = 0;
			chu2Btn.addEventListener(MouseEvent.CLICK,chu2BtnHandler);
			addChild(chu2Btn);
			
			cheng2Btn = new Button();
			cheng2Btn.label = 'x 2';
			cheng2Btn.width = 70*1.2;
			cheng2Btn.height = 70;
			cheng2Btn.fontSize = 26;
			cheng2Btn.backgroundColor = 0x142f4d;
			cheng2Btn.color = 0xffffff;
			cheng2Btn.borderAlpha = 0;
			cheng2Btn.addEventListener(MouseEvent.CLICK,cheng2BtnHandler);
			addChild(cheng2Btn);
			
			minBtn = new Button();
			minBtn.label = '最小';
			minBtn.width = 90*1.2;
			minBtn.height = 70;
			minBtn.fontSize = 26;
			minBtn.backgroundColor = 0x142f4d;
			minBtn.color = 0xffffff;
			minBtn.borderAlpha = 0;
			minBtn.addEventListener(MouseEvent.CLICK,minBtnHandler);
			addChild(minBtn);
			
			maxBtn = new Button();
			maxBtn.topRightRadius = maxBtn.bottomRightRadius = 10;
			maxBtn.label = '最大';
			maxBtn.width = 90*1.2;
			maxBtn.height = 70;
			maxBtn.fontSize = 26;
			maxBtn.backgroundColor = 0x142f4d;
			maxBtn.color = 0xffffff;
			maxBtn.borderAlpha = 0;
			maxBtn.addEventListener(MouseEvent.CLICK,maxBtnHandler);
			addChild(maxBtn);
			
			var str:String = '<font  size="18"  color="#ffffff">游戏提示:<br><br>        点击大小按钮，系统会随机生成一个0到9999的数。<br>如果大于<font color="#feba02">5500</font>，则为大数，如果小于<font color="#feba02">4500</font>，则为小数。<br>        赔率为1赔1。比如押1个金币，押中后，系统会自<br>动给账户增加一个金币，没押中则减一个金币。</font>';
			shuomingText = new TextArea();
			shuomingText.htmlText = str;
			shuomingText.color = 0xffffff;
			shuomingText.borderAlpha = 0;
			shuomingText.backgroundAlpha = 0;
			shuomingText.editable = false;
			addChild(shuomingText);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if (AppData.getInstane().user) {
				goldBar.count = AppData.getInstane().user.jb
			} else {
				goldBar.count = "0"
			}
			
		}
		
		protected function user_dataChangedHandler(event:AppDataEvent):void
		{
			invalidateProperties()
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			bigBtn.y = smallBtn.y = 470;
			bigBtn.x = width/2-bigBtn.width-75;
			smallBtn.x = width/2+75;
			
			numberBar.x = (width-numberBar.width)/2;
			numberBar.y = 100
			
			goldBar.x = 200;
			goldBar.y = 15;
			
			xiazhuInput.width = bigBtn.width*2+150;
			xiazhuInput.height = 70;
			xiazhuInput.x = bigBtn.x;
			xiazhuInput.y = 300;
			
			xiazhuTitle.x = xiazhuInput.x
			xiazhuTitle.y = xiazhuInput.y
			xiazhuTitle.height = xiazhuInput.height
			
			xiazhuUnit.x = xiazhuInput.x + xiazhuInput.width - xiazhuUnit.width
			xiazhuUnit.y = xiazhuInput.y
			xiazhuUnit.height = xiazhuInput.height
			
			amountLab.x =xiazhuInput.x;
			amountLab.y = xiazhuInput.y+xiazhuInput.height+2;
			
			chu2Btn.x = amountLab.x+amountLab.width+2;
			chu2Btn.y = amountLab.y;
			
			cheng2Btn.x = chu2Btn.x+chu2Btn.width+2;
			cheng2Btn.y = chu2Btn.y;
			
			minBtn.x = cheng2Btn.x+cheng2Btn.width+2;
			minBtn.y = chu2Btn.y;
			
			maxBtn.x = minBtn.x+minBtn.width+2;
			maxBtn.y = chu2Btn.y;
			
			refreshButton.x = width - 20 - refreshButton.width
			refreshButton.y  = 10
			
			shuomingText.x = bigBtn.x-10;
			shuomingText.y = bigBtn.y+bigBtn.height+30;
			shuomingText.width = bigBtn.width*2+150+90;
			shuomingText.height = 240;
			
			lab.width = width;
		}
		
		protected function smallHandler(event:MouseEvent):void
		{
			if(!allowClick||!xiazhuInput.text){
				return
			}
			if(AppData.getInstane().user.jb==0){
				AppAlertSmall.show('您的金币不够了');
				allowClick = true;
				return
			}
			if(parseInt(xiazhuInput.text)>AppData.getInstane().user.jb){
				AppAlertSmall.show('押宝数不可大于剩余金币数');
				allowClick = true;
				return;
			}
			if(parseInt(xiazhuInput.text) < 0){
				AppAlertSmall.show('押宝数不可小于0');
				allowClick = true;
				return;
			}
			startHandler(false)
		}
		
		protected function bigHandler(event:MouseEvent):void
		{
			if(!allowClick||!xiazhuInput.text){
				return
			}
			if(AppData.getInstane().user.jb==0){
				AppAlertSmall.show('您的金币不够了');
				allowClick = true;
				return
			}
			if(parseInt(xiazhuInput.text)>AppData.getInstane().user.jb){
				AppAlertSmall.show('押宝数不可大于剩余金币数');
				allowClick = true;
				return;
			}
			if(parseInt(xiazhuInput.text) < 0){
				AppAlertSmall.show('押宝数不可小于0');
				allowClick = true;
				return;
			}
			startHandler(true)
		}
		
		protected function startHandler(guessBig:Boolean):void
		{
			allowClick = false;
			var result:Number = Math.floor((Math.random()*9999+1));
			trace("随机数：",result);
			lab.text = result+"";
			
			if(result<4500){
				if(!guessBig){
					winHandler();
				}else{
					loseHandler();
				}
			}else if(result>5500){
				if(guessBig){
					winHandler();
				}else{
					loseHandler();
				}
			}else{
				loseHandler();
			}
			
			var resStr:String;
			resStr = String(result)
			while(resStr.length<4){
				resStr = "0"+resStr
			}
			numberBar.numStr = resStr;
		}
		
		protected function cheng2BtnHandler(event:MouseEvent):void
		{
			var cheng2Num:Number = parseInt(xiazhuInput.text)*2
			if(cheng2Num>=AppData.getInstane().user.jb){
				xiazhuInput.text = AppData.getInstane().user.jb+""
			}else{
				xiazhuInput.text = cheng2Num+""
			}
		}
		
		protected function chu2BtnHandler(event:MouseEvent):void
		{
			var chu2Num:Number = Math.floor(parseInt(xiazhuInput.text)/2);
			if(chu2Num<1){
				xiazhuInput.text = 1+"";
			}else{
				xiazhuInput.text = chu2Num+""
			}
		}
		
		protected function maxBtnHandler(event:MouseEvent):void
		{
			if(AppData.getInstane().user.jb>0){
				xiazhuInput.text = AppData.getInstane().user.jb+""
			}else{
				xiazhuInput.text = '1';
			}
		}
		
		protected function minBtnHandler(event:MouseEvent):void
		{
			xiazhuInput.text = '1';
		}
		
		protected function changeHandler(event:UIEvent):void
		{
			var xiazhuNum:Number = parseInt(xiazhuInput.text);
			if(xiazhuNum>AppData.getInstane().user.jb){
				xiazhuInput.text = AppData.getInstane().user.jb+""
			}
		}
		
		private function winHandler():void
		{
			newJinBin = AppData.getInstane().user.jb+Math.floor(parseInt(xiazhuInput.text));
			updateHandler();
			setTimeout(function():void{
				AppAlertSmall.show('恭喜你，你猜对了！',AppAlertSmall.SUCCESS)
				allowClick = true;
				refreshData();
			},1000);
		}
		
		private function loseHandler():void
		{
			newJinBin= AppData.getInstane().user.jb-Math.floor(parseInt(xiazhuInput.text));
			updateHandler();
			setTimeout(function():void{
				AppAlertSmall.show('很遗憾，你猜错了。',AppAlertSmall.WARNING)
				allowClick = true;
				refreshData();
			},1000);
		}
		
		private function updateHandler():void
		{
			HttpApi.getInstane().updateUser({
				update: {jb:newJinBin}, 
				query: {id: AppData.getInstane().user.id}
			},function(e:Event):void{
			},null);
		}
		
		private function refreshData():void
		{
			AppData.getInstane().getUserData()
		}
		
		protected function refreshButton_clickHandler(event:MouseEvent):void
		{
			refreshData();
		}
	}
}