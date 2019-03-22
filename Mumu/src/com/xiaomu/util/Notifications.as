package com.xiaomu.util
{
	public class Notifications
	{
		public static const onJoinRoom:int = 1    // 新玩家加入通知
		public static const onJoinGroup:int = 2 // 玩家离开通知
		public static const onLeaveRoom:int = 3    // 新玩家加入通知
		public static const onLeaveGroup:int = 4 // 玩家离开通知
		public static const onReady:int = 5	   // 开局通知
		public static const onNewRound:int = 6     //等待玩家出牌
		public static const onGameStart:int = 7   	  // 玩家出的牌
		public static const onDisCard:int = 8         // 玩家吃牌
		public static const onCard:int = 9       // 玩家碰牌
		public static const onEat:int = 10         // 玩家偎牌
		public static const onPeng:int = 11        // 玩家胡牌
		public static const onWei:int = 12          // 玩家提牌
		public static const onWin:int = 13        // 玩家跑牌
		public static const onTi:int = 14    // 新底牌
		public static const onPao:int = 15    // 检查碰
		public static const onNewCard:int = 16      // 检查吃
		public static const checkPeng:int = 17       // 检查出牌
		public static const checkEat:int = 18       // 检查胡
		public static const checkNewCard:int = 19   // 一局结束
		public static const checkHu:int = 20     // 有玩家准备
		public static const onRoundEnd:int = 21     // 有玩家准备
		public static const onBi:int = 22
	}
}