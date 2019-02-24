package
{
	import com.xiaomu.util.Assets;
	import com.xiaomu.view.LoginView;
	import com.xiaomu.view.MainView;
	
	import coco.core.Application;
	
	public class Mumu extends Application
	{
		public function Mumu()
		{
			super();
			
			Assets.getInstane().loadAssets('assets/mumu.png', 'assets/mumu.json');
		}
		
		override protected function createChildren():void {
			super.createChildren()
				
			addChild(MainView.getInstane())
			MainView.getInstane().pushView(LoginView)
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
				
			MainView.getInstane().width = width
			MainView.getInstane().height = height
		}
		
	}
	
}