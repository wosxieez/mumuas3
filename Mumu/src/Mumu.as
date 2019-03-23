package
{
	import com.xiaomu.view.MainView;
	import com.xiaomu.view.login.LoginView;
	
	import coco.component.Image;
	import coco.core.Application;
	import coco.core.coco;
	
	public class Mumu extends Application
	{
		public function Mumu()
		{
			super();
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
		}
		
		override protected function measure():void {
			if (stage) {
				measuredWidth = stage.stageWidth;
				measuredHeight = stage.stageHeight;
			}
		}
		
		override protected function updateDisplayList():void {
//			super.updateDisplayList()
			
			this.coco::applicationPopUp.width = 1280   // 16 / 9 分辨率
			this.coco::applicationPopUp.height = 720
			this.coco::applicationPopUp.scaleX = width / this.coco::applicationPopUp.width
			this.coco::applicationPopUp.scaleY = height / this.coco::applicationPopUp.height
			trace(this.coco::applicationPopUp.width, this.coco::applicationPopUp.height, this.coco::applicationPopUp.scaleX,
				this.coco::applicationPopUp.scaleY)
			this.coco::applicationContent.width = this.coco::applicationPopUp.width
			this.coco::applicationContent.height = this.coco::applicationPopUp.height
			this.coco::applicationContent.scaleX = this.coco::applicationPopUp.scaleX
			this.coco::applicationContent.scaleY = this.coco::applicationPopUp.scaleX
				
			MainView.getInstane().width = this.coco::applicationPopUp.width
			MainView.getInstane().height = this.coco::applicationPopUp.height
		}
		
	}
	
}