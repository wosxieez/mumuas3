package com.xiaomu.view.group
{
	import com.xiaomu.renderer.UserRenderer;
	
	import coco.component.Button;
	import coco.component.Image;
	import coco.component.List;
	import coco.core.UIComponent;
	import coco.util.FontFamily;
	
	/**
	 * 隐藏弹出的用户列表
	 */
	public class HideUserListView extends UIComponent
	{
		public function HideUserListView()
		{
			super();
		}
		
		private var bgImg:Image;
		private var bgImg1:Image;
		private var usersList:List;
		public var statusImg:Image;
		public var changeShowAndHide:Image;
		public var addMemberBtn:Button;
		private var _dataProvider:Array=[]
		public function get dataProvider():Array
		{
			return _dataProvider;
		}

		public function set dataProvider(value:Array):void
		{
			_dataProvider = value;
			invalidateProperties();
		}
		
		private var _showFlag:Boolean;

		public function get showFlag():Boolean
		{
			return _showFlag;
		}

		public function set showFlag(value:Boolean):void
		{
			_showFlag = value;
			invalidateProperties();
		}
		
		private var _isNowGroupAdmin:Boolean;

		public function get isNowGroupAdmin():Boolean
		{
			return _isNowGroupAdmin;
		}

		public function set isNowGroupAdmin(value:Boolean):void
		{
			_isNowGroupAdmin = value;
			invalidateDisplayList();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			bgImg = new Image();
			bgImg.source = 'assets/group/club_bar_shezhi.png';
			addChild(bgImg);
			
			bgImg1 = new Image();
			bgImg1.source = 'assets/group/floor_hdsm.png';
			bgImg1.radius = 50;
			addChild(bgImg1);
			
			usersList = new List();
			usersList.backgroundAlpha = 0;
			usersList.radius = 10;
//			usersList.padding = 10;
//			usersList.paddingTop = 0;
//			usersList.paddingRight = 0;
//			usersList.paddingLeft = 0;
			usersList.gap = 10;
			usersList.itemRendererClass = UserRenderer;
			usersList.itemRendererHeight = 55;
			addChild(usersList);
			
			changeShowAndHide = new Image();
			changeShowAndHide.source = 'assets/group/club_invite_btn_handle.png';
			addChild(changeShowAndHide);
			
			///弹出或隐藏的标志图片
			statusImg = new Image();
			statusImg.source = 'assets/group/club_invite_unfold.png';
			addChild(statusImg);
			
			addMemberBtn = new Button();
			addMemberBtn.radius = 10;
			addMemberBtn.label = '添加成员';
			addMemberBtn.fontFamily = FontFamily.MICROSOFT_YAHEI;
			addMemberBtn.fontSize = 24;
			addChild(addMemberBtn);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			usersList.dataProvider = dataProvider;
			if(showFlag){
				statusImg.source = 'assets/group/club_invite_fold.png';
			}else{
				statusImg.source = 'assets/group/club_invite_unfold.png';
			}
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			bgImg.width = width;
			bgImg.height = height;
			
			bgImg1.width = width-20;
			bgImg1.height = height-20;
			bgImg1.x = (width-bgImg1.width)/2;
			bgImg1.y = (height-bgImg1.height)/2;
			
			usersList.width = width*0.9;
			usersList.height = isNowGroupAdmin?height*0.9-usersList.itemRendererHeight-usersList.gap:height*0.9;
			usersList.x = (width-usersList.width)/2;
			usersList.y = bgImg1.y+20;
			
			changeShowAndHide.width = 40;
			changeShowAndHide.height = height/5;
			changeShowAndHide.x = -changeShowAndHide.width;
			changeShowAndHide.y = (height-changeShowAndHide.height)/2;
			
			statusImg.width = 30;
			statusImg.height = 40;
			statusImg.y = changeShowAndHide.y+(changeShowAndHide.height-statusImg.height)/2;
			statusImg.x = changeShowAndHide.x+(changeShowAndHide.width-statusImg.width)/2;
			
			addMemberBtn.visible = isNowGroupAdmin;
			addMemberBtn.width = usersList.width;
			addMemberBtn.height = usersList.itemRendererHeight;
			addMemberBtn.x = usersList.x;
			addMemberBtn.y = bgImg1.y+bgImg1.height-addMemberBtn.height-20;
			
		}
	}
}