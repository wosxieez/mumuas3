package
{
	import com.xiaomu.view.MainView;
	import com.xiaomu.view.login.LoginView;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import coco.component.Image;
	import coco.core.Application;
	import coco.core.coco;
	import coco.util.CocoUI;
	
	public class Mumu extends Application
	{
		public function Mumu()
		{
			super();
			
			CocoUI.fontSize = 20
			addEventListener(Event.ADDED_TO_STAGE, this_addedToStageHandler)
		}
		
		
		[Embed(source="assets/bg.png")]
		private var BgClass:Class
		
		private var bg:Image
		
		override protected function createChildren():void {
			super.createChildren()
			bg = new Image()
			bg.source = new BgClass().bitmapData
			addChild(bg)
			
			addChild(MainView.getInstane())
			LoginView(MainView.getInstane().pushView(LoginView)).init()
				
//			var button1:Button = new Button()
//			button1.label = 'disconnect'
//			button1.addEventListener(MouseEvent.CLICK, button1_clickHandler)
//			addChild(button1)
//			
//			var button2:Button = new Button()
//			button2.label = 'reconnect'
//			button2.x = 200
//			button2.addEventListener(MouseEvent.CLICK, button2_clickHandler)
//			addChild(button2)
		}
		
		protected function button1_clickHandler(event:MouseEvent):void
		{	
//			Api.getInstane().disconnect()
		}
		
		protected function button2_clickHandler(event:MouseEvent):void
		{
//			Api.getInstane().reconnect()
		}
		
		override protected function measure():void {
			if (stage) {
				measuredWidth = stage.stageWidth;
				measuredHeight = stage.stageHeight;
			}
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			this.coco::applicationPopUp.width = 1280   // 16 / 9 分辨率
			this.coco::applicationPopUp.height = 720
			this.coco::applicationPopUp.scaleX = width / this.coco::applicationPopUp.width
			this.coco::applicationPopUp.scaleY = height / this.coco::applicationPopUp.height
			this.coco::applicationContent.width = this.coco::applicationPopUp.width
			this.coco::applicationContent.height = this.coco::applicationPopUp.height
			this.coco::applicationContent.scaleX = this.coco::applicationPopUp.scaleX
			this.coco::applicationContent.scaleY = this.coco::applicationPopUp.scaleY
				
			MainView.getInstane().width = this.coco::applicationPopUp.width
			MainView.getInstane().height = this.coco::applicationPopUp.height
		}
		
		protected function this_addedToStageHandler(event:Event):void
		{
			stage.nativeWindow.addEventListener(Event.DEACTIVATE, this_deactivateHandler)
			stage.nativeWindow.addEventListener(Event.ACTIVATE, this_activateHandler)
		}
		
		protected function this_activateHandler(event:Event):void
		{
			trace('activate')
//			Api.getInstane().reconnect()
		}
		
		protected function this_deactivateHandler(event:Event):void
		{
			trace('deactivate')
		}
		
	}
	
}