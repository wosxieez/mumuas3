package
{
	import com.xiaomu.view.MainView;
	import com.xiaomu.view.registered.RegisterView;
	
	import coco.core.Application;
	
	public class Mumu extends Application
	{
		public function Mumu()
		{
			super();
		}
		
		override protected function createChildren():void {
			super.createChildren()
			
			addChild(MainView.getInstane())
			MainView.getInstane().pushView(RegisterView)
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			MainView.getInstane().width = width
			MainView.getInstane().height = height
		}
		
	}
	
}