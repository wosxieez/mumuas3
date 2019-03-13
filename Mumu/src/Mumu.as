package
{
	import com.xiaomu.view.MainView;
	import com.xiaomu.view.login.LoginView;
	
	import coco.component.Image;
	import coco.core.Application;
	
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
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
				
			bg.width = width
			bg.height = height
			
			MainView.getInstane().width = width
			MainView.getInstane().height = height
		}
		
	}
	
}