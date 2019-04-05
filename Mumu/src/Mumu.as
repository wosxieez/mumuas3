package
{
	import com.xiaomu.component.AppAlert;
	import com.xiaomu.util.Assets;
	import com.xiaomu.util.Audio;
	import com.xiaomu.util.HttpApi;
	import com.xiaomu.view.MainView;
	import com.xiaomu.view.login.LoginView;
	
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.Keyboard;
	
	import coco.component.Alert;
	import coco.component.Image;
	import coco.core.Application;
	import coco.core.coco;
	import coco.event.UIEvent;
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
			
			Assets.getInstane().loadAssets('assets/niu.png', 'assets/niu.json')
			
			// 检查版本更新
			HttpApi.getInstane().getVersion(function (e:Event):void {
				try
				{
					var data:Object = JSON.parse(e.currentTarget.data)
					var localXML:XML = NativeApplication.nativeApplication.applicationDescriptor;
					var nss:Namespace = localXML.namespace();
					var curVersionNumber:String = localXML.nss::versionNumber;
					var latestVersionNumber:String = data.vn
					var nowVersion:String = curVersionNumber.split('.').join('');
					var remoteVersion:String = latestVersionNumber.split('.').join('');
					if (Number(nowVersion) < Number(remoteVersion)) {
						var versionAlert:AppAlert = AppAlert.show('发现新版本' + latestVersionNumber + '\r是否立即更新?', '',
							Alert.OK|Alert.CANCEL)
						versionAlert.addEventListener(UIEvent.CLOSE, function (e:UIEvent):void {
							if (e.detail == Alert.OK) {
								navigateToURL(new URLRequest(data.ul))
							}
						})
					}
				} 
				catch(error:Error) 
				{
					
				}
			})
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
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, this_deactivateHandler)
			NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, this_activateHandler)
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, handleKeys);
		}
		
		protected function this_activateHandler(event:Event):void
		{
			trace('activate')
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
			Audio.getInstane().resumeBGM()
			Audio.getInstane().isActivate = true
		}
		
		protected function this_deactivateHandler(event:Event):void
		{
			trace('deactivate')
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.NORMAL;
			Audio.getInstane().pauseBGM()
			Audio.getInstane().isActivate = false
		}
		
		protected function handleKeys(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.BACK)
				NativeApplication.nativeApplication.exit();  //退出程序
		}
		
	}
	
}