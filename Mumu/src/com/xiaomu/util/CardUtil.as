package com.xiaomu.util
{
	import flash.utils.Dictionary;
	
	public class CardUtil
	{
		public function CardUtil()
		{
		}
		
		private static var instance:CardUtil
		
		public static function getInstane(): CardUtil {
			if (!instance) {
				instance = new CardUtil()
			}
			
			return instance
		}
		
		/**
		 * 整理牌 
		 * @param cards
		 */		
		public function riffle(cards:Array):Array {
			var countedCards:Dictionary = countBy(cards)
			var riffledCards:Array = [];
			var card:int
			
			// 四张 三张
			for (card in countedCards) {
				if (countedCards[card] == 4) {
					riffledCards.push([card, card, card, card])
					delete countedCards[card]
				} else if (countedCards[card] == 3) {
					riffledCards.push([card, card, card])
					delete countedCards[card]
				}
			}
			
			// 贰柒拾
			if (countedCards[12] && countedCards[17] && countedCards[20]){
				riffledCards.push([12, 17, 20]);
				countedCards[12]--
				countedCards[17]--
				countedCards[20]--
			}
			if (countedCards[12] && countedCards[17] && countedCards[20]){
				riffledCards.push([12, 17, 20]);
				countedCards[12]--;
				countedCards[17]--;
				countedCards[20]--;
			}
			
			// 3. 壹贰叁
			if (countedCards[11] && countedCards[12] && countedCards[13]){
				riffledCards.push([11, 12, 13]);
				countedCards[11]--;
				countedCards[12]--;
				countedCards[13]--;
			}
			if (countedCards[11] && countedCards[12] && countedCards[13]){
				riffledCards.push([11, 12, 13]);
				countedCards[11]--;
				countedCards[12]--;
				countedCards[13]--;
			}
			
			// 4. 二七十
			if (countedCards[2] && countedCards[7] && countedCards[10]){
				riffledCards.push([2, 7, 10]);
				countedCards[2]--;
				countedCards[7]--;
				countedCards[10]--;
			}
			if (countedCards[2] && countedCards[7] && countedCards[10]){
				riffledCards.push([2, 7, 10]);
				countedCards[2]--;
				countedCards[7]--;
				countedCards[10]--;
			}
			
			// 5. 一二三
			if (countedCards[1] && countedCards[2] && countedCards[3]){
				riffledCards.push([1, 2, 3]);
				countedCards[1]--;
				countedCards[2]--;
				countedCards[3]--;
			}
			if (countedCards[1] && countedCards[2] && countedCards[3]){
				riffledCards.push([1, 2, 3]);
				countedCards[1]--;
				countedCards[2]--;
				countedCards[3]--;
			}
			
			// 6. 对子
			for (card in countedCards) {
				if (countedCards[card] == 2) {
					riffledCards.push([card, card])
					delete countedCards[card]
				}
			}
			
			// 7. 一句话
			for (card in countedCards) {
				if(countedCards[card] && countedCards[card+1] && countedCards[card+2] && (card!==10) && (card!==9)){
					riffledCards.push([card, card+1, card+2]);
					countedCards[card]--;
					countedCards[card+1]--;
					countedCards[card+2]--;
					
				} else if (!countedCards[card]){
					delete countedCards[card];
				}
			}
			
			// 8. 两张
			for (card in countedCards) {
				if(countedCards[card] && countedCards[card+1] && (card!==10)){
					riffledCards.push([card, card+1]);
					countedCards[card]--;
					countedCards[card+1]--;
				} else if (!countedCards[card]){
					delete countedCards[card];
				}
			}
			
			// 9. 散牌
			var countedCardsArray:Array = [];
			for (card in countedCards) {
				if (countedCards[card]){
					countedCardsArray.push(card);
					if(countedCardsArray.length === 3){
						riffledCards.push(countedCardsArray);
						countedCardsArray = [];
					}
				} else {
					delete countedCards[card];
				}
			}
			if(countedCardsArray.length > 0){
				riffledCards.push(countedCardsArray);
			}
			
			return riffledCards;
		}
		
		/**
		 * 是否可以碰牌 
		 * @param cards
		 * @param card
		 * @return 
		 * 
		 */		
		public function canPeng(cardsOnHand:Array, currentCard:int):Array {
			var canPengCards:Array = null
			var countedCards:Dictionary = countBy(cardsOnHand)
			if(countedCards[currentCard] === 2){
				canPengCards = [currentCard, currentCard];
			}
			return canPengCards;
		}
		
		/**
		 * 判断是否能吃 
		 * @param cardsOnHand
		 * @param currentCard
		 * @return 
		 */		
		public function canChi(cardsOnHand:Array, currentCard:int):Array {
			var canChiCards:Array = []
			var card:int
			var countedCards:Dictionary = countBy(cardsOnHand)
			for (card in countedCards) {
				if (countedCards[card] == 3) {
					delete countedCards[card]
				}
			}
			
			// 比方 currentCard = 8
			if (countedCards[currentCard - 1]) {
				if (countedCards[currentCard - 2] && currentCard !== 11 && currentCard !== 12) {
					canChiCards.push([currentCard - 1, currentCard - 2]) // 判断8在尾部 查询 6 7 '8'  尾牌不能等于 11 12
				} 
				if (countedCards[currentCard + 1] && currentCard !== 10 && currentCard !== 11) {
					canChiCards.push([currentCard - 1, currentCard + 1]) // 判断8在中部 查询 7 '8' 9  中牌不能等于 10 11
				}
			} 
			
			if (currentCard < 11) {
				if (countedCards[currentCard] && countedCards[currentCard + 10]) {
					canChiCards.push([currentCard, currentCard + 10]) // 判断 8 8 18
				}
				if (countedCards[currentCard + 10] > 2) {
					canChiCards.push([currentCard + 10, currentCard + 10]) // 判断 8 18 18
				}
			} else {
				if (countedCards[currentCard] && countedCards[currentCard - 10]) {
					canChiCards.push([currentCard, currentCard - 10]) // 判断 8 8 18
				}
				if (countedCards[currentCard - 10] > 2) {
					canChiCards.push([currentCard - 10, currentCard - 10]) // 判断 8 18 18
				}
			}
			
			if (canChiCards.length > 0) {
				return canChiCards
			} else {
				return null
			}
		}
		
		private function countBy(cards:Array):Dictionary {
			var countedCards:Dictionary = new Dictionary()
			for each(var card:int in cards) {
				if (countedCards.hasOwnProperty(card)) {
					countedCards[card] = countedCards[card] + 1
				} else {
					countedCards[card] = 1
				}
			}
			return countedCards
		}
		
	}
}