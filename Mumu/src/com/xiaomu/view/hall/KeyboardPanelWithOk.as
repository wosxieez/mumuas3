package com.xiaomu.view.hall
{
	import com.xiaomu.component.AppAlertSmall;
	import com.xiaomu.component.ImageButton;
	import com.xiaomu.renderer.KeyBoardRender;
	import com.xiaomu.util.AppData;
	import com.xiaomu.util.HttpApi;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.ButtonGroup;
	import coco.component.HorizontalAlign;
	import coco.component.Image;
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	
	public class KeyboardPanelWithOk extends UIComponent
	{
		public function KeyboardPanelWithOk()
		{
			super();
			width = 768;
			height = 563;
		}
		
		private var bgImg:Image;
		private var closeBtn:ImageButton;
		private var numberBarBgImg:Image;
		private var keyboradBgImg:Image;
		private var noticeTxtImg:Image;
		private var n1:ImageButton;
		private var n2:ImageButton;
		private var n3:ImageButton;
		private var n4:ImageButton;
		private var n5:ImageButton;
		private var n6:ImageButton;
		private var n7:ImageButton;
		private var n8:ImageButton;
		private var n9:ImageButton;
		private var n0:ImageButton;
		private var resetBtn:ImageButton;
		private var deleteOne:ImageButton;
		private var numberLab:ButtonGroup;
		private var okBtn:ImageButton;
		
		private var _numberArr:Array=[]
		public function get numberArr():Array
		{
			return _numberArr;
		}
		
		public function set numberArr(value:Array):void
		{
			_numberArr = value;
			invalidateProperties();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			bgImg = new Image();
			bgImg.source = 'assets/keyboard/input_bg.png';
			bgImg.width = 768;
			bgImg.height = 563;
			addChild(bgImg);
			
			closeBtn = new ImageButton();
			closeBtn.upImageSource = 'assets/keyboard/btn_close_normal.png';
			closeBtn.downImageSource ='assets/keyboard/btn_close_press.png';
			closeBtn.width = 80;
			closeBtn.height = 80;
			closeBtn.addEventListener(MouseEvent.CLICK, closeMe)
			addChild(closeBtn);
			
			numberBarBgImg = new Image();
			numberBarBgImg.source = 'assets/keyboard/floor_sz.png';
			numberBarBgImg.width = 680;
			numberBarBgImg.height = 60;
			addChild(numberBarBgImg);
			
			keyboradBgImg = new Image();
			keyboradBgImg.source = 'assets/keyboard/floor_012.png';
			keyboradBgImg.width = 680;
			keyboradBgImg.height = 400+20;
			addChild(keyboradBgImg);
			
			noticeTxtImg = new Image();
			noticeTxtImg.source = 'assets/keyboard/T_id.png';
			noticeTxtImg.width = 273;
			noticeTxtImg.height = 27;
			addChild(noticeTxtImg);
			
			okBtn = new ImageButton();
			okBtn.upImageSource = 'assets/keyboard/btn_qd_normal.png';
			okBtn.downImageSource = 'assets/keyboard/btn_qd_press.png';
			okBtn.width = 200;
			okBtn.height = 76;
			okBtn.addEventListener(MouseEvent.CLICK,okBtnHandler);
			addChild(okBtn);
			
			n1 = new ImageButton();
			n1.value = "1";
			n1.upImageSource = 'assets/keyboard/nineGrid/btn_1_normal.png';
			n1.downImageSource = 'assets/keyboard/nineGrid/btn_1_press.png';
			n1.width = 208;
			n1.height = 95;
			n1.addEventListener(MouseEvent.CLICK,clickHandler);
			addChild(n1);
			
			n2 = new ImageButton();
			n2.value = "2";
			n2.upImageSource = 'assets/keyboard/nineGrid/btn_2_normal.png';
			n2.downImageSource = 'assets/keyboard/nineGrid/btn_2_press.png';
			n2.width = 208;
			n2.height = 95;
			n2.addEventListener(MouseEvent.CLICK,clickHandler);
			addChild(n2);
			
			n3 = new ImageButton();
			n3.value = "3";
			n3.upImageSource = 'assets/keyboard/nineGrid/btn_3_normal.png';
			n3.downImageSource = 'assets/keyboard/nineGrid/btn_3_press.png';
			n3.width = 208;
			n3.height = 95;
			n3.addEventListener(MouseEvent.CLICK,clickHandler);
			addChild(n3);
			
			n4 = new ImageButton();
			n4.value = "4";
			n4.upImageSource = 'assets/keyboard/nineGrid/btn_4_normal.png';
			n4.downImageSource = 'assets/keyboard/nineGrid/btn_4_press.png';
			n4.width = 208;
			n4.height = 95;
			n4.addEventListener(MouseEvent.CLICK,clickHandler);
			addChild(n4);
			
			n5 = new ImageButton();
			n5.value = "5";
			n5.upImageSource = 'assets/keyboard/nineGrid/btn_5_normal.png';
			n5.downImageSource = 'assets/keyboard/nineGrid/btn_5_press.png';
			n5.width = 208;
			n5.height = 95;
			n5.addEventListener(MouseEvent.CLICK,clickHandler);
			addChild(n5);
			
			n6 = new ImageButton();
			n6.value = "6";
			n6.upImageSource = 'assets/keyboard/nineGrid/btn_6_normal.png';
			n6.downImageSource = 'assets/keyboard/nineGrid/btn_6_press.png';
			n6.width = 208;
			n6.height = 95;
			n6.addEventListener(MouseEvent.CLICK,clickHandler);
			addChild(n6);
			
			n7 = new ImageButton();
			n7.value = "7";
			n7.upImageSource = 'assets/keyboard/nineGrid/btn_7_normal.png';
			n7.downImageSource = 'assets/keyboard/nineGrid/btn_7_press.png';
			n7.width = 208;
			n7.height = 95;
			n7.addEventListener(MouseEvent.CLICK,clickHandler);
			addChild(n7);
			
			n8 = new ImageButton();
			n8.value = "8";
			n8.upImageSource = 'assets/keyboard/nineGrid/btn_8_normal.png';
			n8.downImageSource = 'assets/keyboard/nineGrid/btn_8_press.png';
			n8.width = 208;
			n8.height = 95;
			n8.addEventListener(MouseEvent.CLICK,clickHandler);
			addChild(n8);
			
			n9 = new ImageButton();
			n9.value = "9";
			n9.upImageSource = 'assets/keyboard/nineGrid/btn_9_normal.png';
			n9.downImageSource = 'assets/keyboard/nineGrid/btn_9_press.png';
			n9.width = 208;
			n9.height = 95;
			n9.addEventListener(MouseEvent.CLICK,clickHandler);
			addChild(n9);
			
			resetBtn = new ImageButton();
			resetBtn.value = "reset";
			resetBtn.upImageSource = 'assets/keyboard/nineGrid/btn_cs_normal.png';
			resetBtn.downImageSource = 'assets/keyboard/nineGrid/btn_cs_press.png';
			resetBtn.width = 208;
			resetBtn.height = 95;
			resetBtn.addEventListener(MouseEvent.CLICK,clickHandler);
			addChild(resetBtn);
			
			n0 = new ImageButton();
			n0.value = "0";
			n0.upImageSource = 'assets/keyboard/nineGrid/btn_0_normal.png';
			n0.downImageSource = 'assets/keyboard/nineGrid/btn_0_press.png';
			n0.width = 208;
			n0.height = 95;
			n0.addEventListener(MouseEvent.CLICK,clickHandler);
			addChild(n0);
			
			deleteOne = new ImageButton();
			deleteOne.value = "deleteOne";
			deleteOne.upImageSource = 'assets/keyboard/nineGrid/btn_sc_normal.png';
			deleteOne.downImageSource = 'assets/keyboard/nineGrid/btn_sc_press.png';
			deleteOne.width = 208;
			deleteOne.height = 95;
			deleteOne.addEventListener(MouseEvent.CLICK,clickHandler);
			addChild(deleteOne);
			
			numberLab = new ButtonGroup();
			numberLab.itemRendererClass = KeyBoardRender;
			numberLab.backgroundAlpha = 0;
			numberLab.borderAlpha = 0;
			numberLab.itemRendererColumnCount = 4;
			numberLab.horizontalAlign = HorizontalAlign.JUSTIFY;
			addChild(numberLab);
		}
		
		protected function closeMe(event:MouseEvent):void
		{
			PopUpManager.removePopUp(this)
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			numberLab.dataProvider = numberArr;
			noticeTxtImg.visible = numberArr.length==0
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			okBtn.x =   (width-okBtn.width)/2;
			okBtn.y = height-35;
			
			closeBtn.x = width-60;
			closeBtn.y = -20;
			
			numberBarBgImg.x = (width-numberBarBgImg.width)/2;
			numberBarBgImg.y = 40;
			
			numberLab.x = numberBarBgImg.x;
			numberLab.y = numberBarBgImg.y;
			numberLab.height = numberBarBgImg.height;
			numberLab.width = numberBarBgImg.width;
			
			keyboradBgImg.x = numberBarBgImg.x;
			keyboradBgImg.y = numberBarBgImg.y+numberBarBgImg.height+10
			
			noticeTxtImg.x = (numberBarBgImg.width-noticeTxtImg.width)/2+numberBarBgImg.x;
			noticeTxtImg.y = (numberBarBgImg.height-noticeTxtImg.height)/2+numberBarBgImg.y;
			
			n1.x = keyboradBgImg.x+10;
			n1.y = keyboradBgImg.y+5;
			
			n2.x = n1.x+n1.width+20;
			n2.y = n1.y;
			
			n3.x = n2.x+n2.width+20;
			n3.y = n1.y;
			
			n4.x = n1.x;
			n4.y = n1.y+n1.height+10;
			
			n5.x = n2.x;
			n5.y = n4.y;
			
			n6.x = n3.x;
			n6.y = n4.y;
			
			n7.x = n1.x;
			n7.y = n4.y+n4.height+10;
			
			n8.x = n5.x;
			n8.y = n7.y;
			
			n9.x = n6.x;
			n9.y = n7.y;
			
			resetBtn.x = n7.x;
			resetBtn.y = n7.y+n7.height+10;
			
			n0.x = n8.x;
			n0.y = resetBtn.y;
			
			deleteOne.x =  n9.x;
			deleteOne.y = resetBtn.y;
		}
		
		
		
		protected function clickHandler(event:MouseEvent):void
		{
			if(event.currentTarget.value=='deleteOne'){
				//执行删除最后一位
				if(numberArr.length>0){
					numberArr.pop();
				}else{
					numberArr = [];
				}
			}else if(event.currentTarget.value=='reset'){
				//重置
				numberArr = [];
			}else{
				if(numberArr.length<4){
					numberArr.push(event.currentTarget.value)
				}
			}
			if (numberArr.length == 4) {
				//				Loading.getInstance().open()
				closeHandler();
				actionHandler();
			} else {
				invalidateProperties();
			}
		}
		
		private function closeHandler():void
		{
			PopUpManager.removePopUp(this)
		}
		
		protected function okBtnHandler(event:MouseEvent):void
		{
			if(numberArr.length==0){
				AppAlertSmall.show("请输入正确的群号");
				return;
			}
			actionHandler();
		}
		
		/**
		 *申请操作
		 * 1，自己是不是已经加入了这个群？
		 * 2，先查询这个群是否存在。
		 * 3，存在的话，再提交申请 。
		 * 4，你的申请是否已经存在
		 */
		private function actionHandler():void
		{
			var groupNumber:int = parseInt(numberArr.join(''));
			if(AppData.getInstane().alljoinedGroups&&AppData.getInstane().alljoinedGroups.indexOf(groupNumber)!=-1){
				AppAlertSmall.show('您已经在该群中了');
				numberArr = [];
				return
			}
			
			HttpApi.getInstane().getGroup({id:groupNumber},function(e:Event):void{
				var respones : Object = JSON.parse(e.currentTarget.data);
				if(respones.data.length>0){
					///说明该群存在，再查你的申请是否已经存在，群未处理。
					HttpApi.getInstane().findApplyrecord({uid:AppData.getInstane().user.id,gid:groupNumber,finish:'F'},function(e:Event):void{
						trace("申请表查询结果：",e.currentTarget.data);
						var respone:Object = JSON.parse(e.currentTarget.data);
						if((respone.data as Array).length==0){///说明同样的（未处理的）请求不存在。可以发起该请求。向表中插入该条数据
							trace('可以插入该条申请记录');
							HttpApi.getInstane().joinApplyrecord({uid:AppData.getInstane().user.id,gid:groupNumber,finish:'F',uname:AppData.getInstane().user.username},function(e:Event):void{
								var respone1:Object = JSON.parse(e.currentTarget.data);
								if(respone1.code==0){
									AppAlertSmall.show('申请提交成功，请等待群主确认')
									numberArr = [];
									closeHandler();
								}else{
									AppAlertSmall.show('申请提交失败')
								}
							},null);
							
						}else{
							AppAlertSmall.show('该申请已经存在，请等待群主确认')
							numberArr = [];
						}
					},null);
					
				}else{
					AppAlertSmall.show("输入的群号不存在")
					numberArr = [];
				}
			},null);
		}
	}
}

