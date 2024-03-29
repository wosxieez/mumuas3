package com.xiaomu.renderer
{
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextAlign;
	
	/**
	 * 馆主和副馆主的渲染界面
	 */
	public class HistoryListRenderForLeveL34 extends DefaultItemRenderer
	{
		public function HistoryListRenderForLeveL34()
		{
			super();
			autoDrawSkin = false;
		}
		
		private var bgImg:Image;
		private var timeLab:Label;///时间
		private var wanfaLab:Label;///玩法名 （1园放炮罚，上下分）
		private var tcLab:Label;
		
		private var winNameTitle:Label;
		private var winName:Label///赢家名  （接收上分的人的名称）
		private var winTotal:Label;///赢之后的总分
		
		private var loseNameTitle:Label;
		private var loseName:Label;///输家名  （下分的人的名称）
		private var loseTotal:Label//输之后的总分
		
		private var winTcTitle:Label;
		private var winL1name:Label;///赢家1级管理员名称
		private var winL1total:Label;////赢家1级管理员提成后的分数
		private var winL2name:Label;///赢家2级管理员名称
		private var winL2total:Label;////赢家2级管理员提成后的分数
		
		private var loseTcTitle:Label;
		private var loseL1name:Label;///输家1级管理员名称
		private var loseL1total:Label;////输家1级管理员提成后的分数
		private var loseL2name:Label;///输家2级管理员名称
		private var loseL2total:Label;////输家2级管理员提成后的分数
		
		private var hostTitle:Label;
		private var hostNameLab:Label;
		private var hostTotal:Label;////馆长提成后的分数
		
		override protected function createChildren():void
		{
			super.createChildren();
			labelDisplay.visible = false;
			
			bgImg = new Image();
			bgImg.source = 'assets/guild/guild_diban02.png';
			addChild(bgImg);
			
			timeLab = new Label();
			timeLab.textAlign = TextAlign.LEFT;
			timeLab.width = 240;
			timeLab.height = 30;
			timeLab.color = 0x6f1614;
			addChild(timeLab);
			
			wanfaLab = new Label();
			wanfaLab.textAlign = TextAlign.LEFT;
			wanfaLab.width = 200;
			wanfaLab.height = 30;
			wanfaLab.color = 0x6f1614;
			addChild(wanfaLab);
			
			tcLab = new Label();
			tcLab.textAlign = TextAlign.LEFT;
			tcLab.width = 200;
			tcLab.height = 30;
			tcLab.color = 0x6f1614;
			addChild(tcLab);
			
			 winNameTitle = new Label();
			 winNameTitle.width = 150;
			 winNameTitle.height = 30;
			 winNameTitle.color = 0x6f1614;
			 addChild(winNameTitle);
			 
			 winName = new Label();
			 winName.width = 150;
			 winName.height = 30;
			 winName.color = 0x6f1614;
			 addChild(winName);
			 
			 winTotal = new Label();
			 winTotal.width = 200;
			 winTotal.height = 70;
			 winTotal.color = 0x6f1614;
			 addChild(winTotal);
			 
			 loseNameTitle = new Label();
			 loseNameTitle.width = 150;
			 loseNameTitle.height = 30;
			 loseNameTitle.color = 0x6f1614;
			 addChild(loseNameTitle);
			 
			 loseName = new Label();
			 loseName.width = 150;
			 loseName.height = 30;
			 loseName.color = 0x6f1614;
			 addChild(loseName);
			 
			 loseTotal = new Label();
			 loseTotal.width = 200;
			 loseTotal.height = 70;
			 loseTotal.color = 0x6f1614;
			 addChild(loseTotal);
			 
			 winTcTitle = new Label();
			 winTcTitle.width = 200;
			 winTcTitle.height = 30;
			 winTcTitle.color = 0x6f1614;
			 winTcTitle.text = '赢方提成';
			 addChild(winTcTitle);
			 
			 winL1name= new Label();
			 winL1name.width = 200;
			 winL1name.height = 30;
			 winL1name.color = 0x6f1614;
			 addChild(winL1name);
			 
			 winL1total= new Label();
			 winL1total.width = 200;
			 winL1total.height = 30;
			 winL1total.color = 0x6f1614;
			 addChild(winL1total);
			 
			 winL2name= new Label();
			 winL2name.width = 200;
			 winL2name.height = 30;
			 winL2name.color = 0x6f1614;
			 addChild(winL2name);
			 
			 winL2total= new Label();
			 winL2total.width = 200;
			 winL2total.height = 30;
			 winL2total.color = 0x6f1614;
			 addChild(winL2total);
			 
			 loseTcTitle = new Label();
			 loseTcTitle.width = 200;
			 loseTcTitle.height = 30;
			 loseTcTitle.color = 0x6f1614;
			 loseTcTitle.text = '输方提成';
			 addChild(loseTcTitle);
			 
			 loseL1name= new Label();
			 loseL1name.width = 200;
			 loseL1name.height = 30;
			 loseL1name.color = 0x6f1614;
			 addChild(loseL1name);
			 
			 loseL1total= new Label();
			 loseL1total.width = 200;
			 loseL1total.height = 30;
			 loseL1total.color = 0x6f1614;
			 addChild(loseL1total);
			 
			 loseL2name= new Label();
			 loseL2name.width = 200;
			 loseL2name.height = 30;
			 loseL2name.color = 0x6f1614;
			 addChild(loseL2name);
			 
			 loseL2total= new Label();
			 loseL2total.width = 200;
			 loseL2total.height = 30;
			 loseL2total.color = 0x6f1614;
			 addChild(loseL2total);
			 
			 hostTitle = new Label();
			 hostTitle.width = 200;
			 hostTitle.height = 30;
			 hostTitle.color = 0x6f1614;
			 hostTitle.text = '(副)馆主提成';
			 addChild(hostTitle);
			 
			 hostNameLab = new Label();
			 hostNameLab.width = 200;
			 hostNameLab.height = 30;
			 hostNameLab.color = 0x6f1614;
			 addChild(hostNameLab);

			 hostTotal = new Label();
			 hostTotal.width = 200;
			 hostTotal.height = 30;
			 hostTotal.color = 0x6f1614;
			 addChild(hostTotal);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			timeLab.text = data.newDate;
			wanfaLab.text = data.tc==0?"上下分":"玩法:"+data.run;
			tcLab.text = data.tc==0?"":"提成:"+data.tc;
			winNameTitle.text = data.tc==0?"得分者":"赢家";
			winName.text = data.wn!=""?("名:"+data.wn):("id:"+data.wid)
			winTotal.text = data.wtfs+"(+"+data.wfs+")";
			loseNameTitle.text = data.tc==0?"出分者":"输家";
			loseName.text = data.ln!=""?("名:"+data.ln):("id:"+data.lid)
			loseTotal.text = data.ltfs+"("+data.lfs+")";
			
			winL1name.text = "一级id:"+data.w1id;
			winL2name.text = "二级id:"+data.w2id+"\r"+data.w2tfs+"(+"+data.w2tc+")";
			winL1total.text = data.w1tfs+"(+"+data.w1tc+")";
			winL2total.text = data.w2tfs+"(+"+data.w2tc+")";
			
			loseL1name.text = "一级id:"+data.l1id;
			loseL2name.text = "二级id:"+data.l2id;
			loseL1total.text = data.l1tfs+"(+"+data.l1tc+")";
			loseL2total.text = data.l2tfs+"(+"+data.l2tc+")";
			
			hostNameLab.text = "id："+data.zid;
			hostTotal.text = data.ztfs+"(+"+data.ztc+")";
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			bgImg.width = width;
			bgImg.height = height;
			
			timeLab.x = timeLab.y = 10;
			wanfaLab.x = timeLab.x;
			wanfaLab.y = timeLab.y+timeLab.height+10;
			tcLab.x = timeLab.x;
			tcLab.y = wanfaLab.y+wanfaLab.height+10;
			
			winNameTitle.x = timeLab.x+timeLab.width-10;
			winNameTitle.y = timeLab.y;
			
			winName.x = winNameTitle.x;
			winName.y = winNameTitle.y+winNameTitle.height+10;
			
			winTotal.x = winNameTitle.x+winNameTitle.width/2-winTotal.width/2;
			winTotal.y = winName.y+winName.height+10;
			
			loseNameTitle.x = winNameTitle.x+winNameTitle.width;
			loseNameTitle.y = winNameTitle.y;
			
			loseName.x = loseNameTitle.x;
			loseName.y = loseNameTitle.y+loseNameTitle.height+10;
			
			loseTotal.x = loseNameTitle.x+loseNameTitle.width/2-loseTotal.width/2;
			loseTotal.y = loseName.y+loseName.height+10;
			
			winTcTitle.x = loseNameTitle.x+loseNameTitle.width+10;
			winTcTitle.y = winNameTitle.y;
			
			winL1name.x = winTcTitle.x;
			winL1name.y = winTcTitle.y+winTcTitle.height+5;
			
			winL1total.x = winL1name.x;
			winL1total.y = winL1name.y+winL1name.height-5;
			
			winL2name.x = winTcTitle.x;
			winL2name.y = winL1total.y+winL1total.height;
			
			winL2total.x = winL2name.x;
			winL2total.y = winL2name.y+winL2name.height-5;
			
			loseTcTitle.x = winTcTitle.x+winTcTitle.width+10;
			loseTcTitle.y = winNameTitle.y;
			
			loseL1name.x = loseTcTitle.x;
			loseL1name.y = loseTcTitle.y+loseTcTitle.height+5;
			
			loseL1total.x = loseL1name.x;
			loseL1total.y = loseL1name.y+loseL1name.height-5;
			
			loseL2name.x = loseTcTitle.x;
			loseL2name.y = winL2name.y;
			
			loseL2total.x = loseL2name.x;
			loseL2total.y = winL2total.y;
			
			hostTitle.x = loseTcTitle.x+loseTcTitle.width;
			hostTitle.y = loseTcTitle.y;
			
			hostNameLab.x = hostTitle.x;
			hostNameLab.y = loseL1name.y;
			
			hostTotal.x = hostTitle.x;
			hostTotal.y = hostNameLab.y+hostNameLab.height-5;
		}
	}
}