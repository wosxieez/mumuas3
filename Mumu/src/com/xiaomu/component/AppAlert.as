/**
 * Copyright (c) 2014-present, ErZhuan(coco) Xie
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */
package com.xiaomu.component
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import coco.component.Alert;
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.SkinComponent;
	import coco.core.coco;
	import coco.event.UIEvent;
	import coco.manager.PopUpManager;
	import coco.util.CocoUI;
	
	use namespace coco;
	
	
	[Event(name="ui_close", type="coco.event.UIEvent")]
	
	/**
	 * 弹出 提示组件
	 * 
	 *   10     titleDisplay    10
	 *              10
	 *   10     textDisplay     10
	 *              10
	 *  cancelButton | okButton
	 * 
	 * @author Coco
	 */    
	public class AppAlert extends SkinComponent
	{
		public function AppAlert()
		{
			super();
			backgroundAlpha = borderAlpha = 0
		}
		
		public static const OK:uint = 0x0004;
		public static const CANCEL:uint= 0x0008;
		
		/**
		 * 显示
		 * 
		 * @param text 提示信息
		 * @param title 提示标题
		 * @param flags 提示操作按钮Alert.OK|Alert.CANCEL, Alert.OK, Alert.CANCEL
		 * @param closeHandler 提示窗口关闭响应事件
		 * @param parent 所属组件
		 * @param modal 是否是模态显示
		 * @param closeWhenMouseDownOutSide 点击外部区域是否自动关闭
		 * @param backgroundColor 模态背景颜色
		 * @param backgroundAlpha 模态背景透明度
		 * @return 
		 */     
		public static function show(text:String = "", 
									title:String = "",
									flags:uint = 0x4 /* Alert.OK */, 
									closeHandler:Function = null,
									parent:Sprite = null, 
									modal:Boolean = true,
									closeWhenMouseClickOutside:Boolean = false,
									backgroundColor:uint = 0x000000,
									backgroundAlpha:Number = .1):AppAlert
		{
			
			var alert:AppAlert = new AppAlert();
			alert.buttonFlags = flags;
			alert.text = text;
			
			if (closeHandler != null)
				alert.addEventListener(UIEvent.CLOSE, closeHandler);
			
			PopUpManager.addPopUp(alert, parent, modal, closeWhenMouseClickOutside, backgroundColor, backgroundAlpha);
			PopUpManager.centerPopUp(alert);
			
			return alert;
		}
		
		private var _text:String;
		
		public function get text():String
		{
			return _text;
		}
		
		public function set text(value:String):void
		{
			if (_text == value) return;
			_text = value;
			invalidateProperties();
			invalidateSize();
			invalidateDisplayList();
		}
		
		private var _padding:Number = 20
		
		public function get padding():Number
		{
			return _padding;
		}
		
		public function set padding(value:Number):void
		{
			_padding = value;
			invalidateDisplayList()
		}
		
		private var _textAlign:String = CocoUI.fontAlign;
		
		/**
		 * Alert 的文本对齐方式 
		 */
		public function get textAlign():String
		{
			return _textAlign;
		}
		
		/**
		 * @private
		 */
		public function set textAlign(value:String):void
		{
			if (_textAlign == value) return;
			_textAlign = value;
			invalidateProperties();
		}
		
		private var bacground:Image
		private var titleImage:Image
		protected var textDisplay:Label;
		protected var cancelButton:ImageButton;
		protected var okButton:ImageButton;
		public var buttonFlags:uint;
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			bacground = new Image()
			bacground.source = 'assets/component/bac_04.png'
			addChild(bacground)
			
			titleImage = new Image()
			titleImage.width = 293
			titleImage.height = 86
			titleImage.source = 'assets/component/Tishi.png'
			addChild(titleImage)
			
			if (buttonFlags & Alert.CANCEL)
			{
				cancelButton = new ImageButton();
				cancelButton.upImageSource = 'assets/component/Z_cancelNormal.png'
				cancelButton.width = 166
				cancelButton.height = 70
				cancelButton.addEventListener(MouseEvent.CLICK, cancelButton_clickHandler);
				addChild(cancelButton);
			}
			
			if (buttonFlags & Alert.OK)
			{
				okButton = new ImageButton();
				okButton.width = 166
				okButton.height = 70
				okButton.upImageSource = 'assets/component/btn_confirm_normal.png'
				okButton.downImageSource = 'assets/component/btn_confirm_press.png'
				okButton.addEventListener(MouseEvent.CLICK, okButton_clickHandler);
				addChild(okButton);
			}
			
			textDisplay = new Label();
			textDisplay.color = 0x8E6E38
			textDisplay.leading = 5;
			textDisplay.fontSize = 25
			textDisplay.x = 10;
			textDisplay.addEventListener(UIEvent.RESIZE, child_resizeHandler);
			addChild(textDisplay);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			textDisplay.text = text;
			textDisplay.textAlign = textAlign;
		}
		
		override protected function measure():void
		{
			super.measure();
			
			//    10  titleDisplay 10
			//             10
			//    10  textDiplay   10
			//             10
			//  cancelButton  okButton
			
			// 如果titleDisplay存在  则有标题
			
			var minWidth:Number = 918;
			var minHeight:Number = 510;
			
			// header width
			var realWidth:Number = 0;
			var realHeight:Number = titleImage.height + padding
			
			realWidth = Math.max(realWidth, textDisplay.width + 300);
			realHeight += textDisplay.height + padding;
			
			if (okButton || cancelButton)
			{
				realHeight += okButton.height + padding
			}
			
			measuredWidth = Math.max(minWidth, realWidth);
			measuredHeight = Math.max(minHeight, realHeight);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			bacground.width = width
			bacground.height = height
				
			titleImage.x = (width - titleImage.width)  / 2
			
			textDisplay.setSizeWithoutDispatchResizeEvent(width - 280)
			textDisplay.x = 140
			textDisplay.y = titleImage.y + titleImage.height + 50 + padding;
			
			if (okButton || cancelButton)
				textDisplay.setmeasuredSizeWithoutDispatchResizeEvent(width - padding * 2, height - okButton.height - padding * 2 - textDisplay.y);
			else
				textDisplay.setmeasuredSizeWithoutDispatchResizeEvent(width - padding * 2, height - padding - textDisplay.y);
			
			if (okButton && cancelButton)
			{
				okButton.y = height - okButton.height - padding;
				okButton.x = (width - okButton.width - cancelButton.width - padding) / 2
				cancelButton.y = okButton.y
				cancelButton.x = okButton.x + okButton.width + padding
			}
			else if (okButton)
			{
				okButton.y = height - okButton.height - padding;
				okButton.x = (width - okButton.width) / 2
			}
			else if (cancelButton)
			{
				cancelButton.y = height - cancelButton.height;
				cancelButton.x = (width - cancelButton.width) / 2
			}
		}
		
		protected function child_resizeHandler(event:UIEvent):void
		{
			invalidateSize();
			invalidateDisplayList();
		}
		
		protected function cancelButton_clickHandler(event:MouseEvent):void
		{
			var ce:UIEvent = new UIEvent(UIEvent.CLOSE);
			ce.detail = Alert.CANCEL;
			dispatchEvent(ce);
			
			PopUpManager.removePopUp(this);
		}
		
		protected function okButton_clickHandler(event:MouseEvent):void
		{
			var ce:UIEvent = new UIEvent(UIEvent.CLOSE);
			ce.detail = Alert.OK;
			dispatchEvent(ce);
			
			PopUpManager.removePopUp(this);
		}
		
	}
}


