package com.xiaomu.itemRender
{
	import com.xiaomu.component.ImageButton;
	import com.xiaomu.view.group.GroupUserMenu;
	
	import flash.events.MouseEvent;
	
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	import coco.component.Label;
	import coco.manager.PopUpManager;
	
	public class GroupUserRender extends DefaultItemRenderer
	{
		public function GroupUserRender()
		{
			super();
			mouseChildren = true
			backgroundAlpha = 0;
		}
		
		private var bgImg:Image;
		private var manageButton:ImageButton
		private var labFen:Label;
		private var labZhiWei:Label;
		private var labName:Label;
		
		override protected function createChildren():void {
			super.createChildren()
			
			bgImg = new Image();
			bgImg.source = 'assets/guild/guild_diban02.png';
			addChild(bgImg);
			
			labName = new Label();
			labName.fontSize = 24;
			labName.color = 0x845525;
			addChild(labName);
			
			labZhiWei = new Label();
			labZhiWei.fontSize = 24;
			labZhiWei.color = 0x845525;
			addChild(labZhiWei);
			
			labFen = new Label();
			labFen.fontSize = 24;
			labFen.color = 0x845525;
			addChild(labFen);
			
			manageButton = new ImageButton()
			manageButton.upImageSource = 'assets/guild/btn_guild_manager_n.png';
			manageButton.downImageSource = 'assets/guild/btn_guild_manager_p.png';
			manageButton.addEventListener(MouseEvent.CLICK, manageButton_clickHandler)
			addChild(manageButton)
		}
		
		override protected function commitProperties():void {
			super.commitProperties()
			
			if (data) {
				var flag:String
				switch(data.ll)
				{
					case 4:
					{
						flag = '馆长'
						break;
					}
					case 3:
					{
						flag = '副馆长'
						break;
					}
					case 2:
					{
						flag = '一级管理员'
						break;
					}
					case 1:
					{
						flag = '二级管理员'
						break;
					}
					default:
					{
						flag = '普通成员'
						break;
					}
				}
				
//				lab.text = data.username + ' 积分 ' + data.fs + ' 职位' + flag
				labName.text = data.nn && data.nn.length > 0 ? data.nn + '(' + data.username +  ')' : data.username;
				labZhiWei.text = flag;
				labFen.text = data.fs + ' 疲劳值';
			}
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList()
			
			bgImg.width = width;
			bgImg.height = height;
			
			manageButton.height =  51
			manageButton.width = 132
			manageButton.x = width - manageButton.width-20
			manageButton.y = ( height-manageButton.height)/2
				
			labName.x = 0;
			labName.width = 300;
			labName.height = 40;
			labName.y = (height-labName.height)/2;
			
			labZhiWei.x = labName.x+labName.width;
			labZhiWei.width = 200;
			labZhiWei.height = 40;
			labZhiWei.y = (height-labZhiWei.height)/2;
			
			labFen.x = labZhiWei.x+labZhiWei.width;
			labFen.width = 200;
			labFen.height = 40;
			labFen.y = (height-labFen.height)/2;
		}
		
		/**
		 * 点击管理按钮，对群成员进行设置
		 */
		protected function manageButton_clickHandler(event:MouseEvent):void
		{
			event.preventDefault()
			event.stopImmediatePropagation()
			
			GroupUserMenu.getInstane().x = width+GroupUserMenu.getInstane().width+35;
			GroupUserMenu.getInstane().y = 150;
			GroupUserMenu.getInstane().targetUser = data
			PopUpManager.addPopUp(GroupUserMenu.getInstane(), null, false, true)
		}
		
	}
}