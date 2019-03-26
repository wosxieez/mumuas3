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
		
		public function outCardCanTing(groupCards:Array, handCards:Array, huXi:int):Array {
			var outTingCards:Array = []
			for (var i:int = 0; i < handCards.length; i++) {
				var newHandCards:Array = handCards.concat([])
				var outCard:int = newHandCards[i]
				newHandCards.splice(i, 1)
				var tingCards:Array = canTing(groupCards, newHandCards, huXi)
				if (tingCards) {
					outTingCards.push({card: outCard, tingCards: tingCards})
				}
			}
			return outTingCards.length > 0 ? outTingCards : null
		}
		
		/**
		 * 是否能听牌 
		 * @param groupCards
		 * @param handCards
		 * @param huXi
		 * 
		 */		
		public function canTing(groupCards:Array, handCards:Array, huXi:int):Array {
			var tingCards:Array = []
			for (var i:int = 1; i <= 20; i++) {
				var canHuData:Array = canHu(handCards, groupCards, i)
				if (canHuData && getHuXi(canHuData) >= huXi) {
					tingCards.push(i)
				}
			}
			
			if (tingCards.length > 0) {
				return tingCards
			} else {
				return null
			}
		}
		
		
		public function canHu(handCards:Array, groupCards:Array, currntCard:int):Array {
			var totalHandCards:Array = handCards.concat([currntCard])
			var onHand:Array = shouShun(totalHandCards)
			if (onHand) {
				return groupCards.concat(onHand)
			} else {
				return null		
			}
		}
		
		/**
		 * 玩家的牌是否无单牌。
		 * @param cards: 手中的牌，或者手中的牌加新翻开的底牌。
		 */
		public function shouShun(cards):Array {
			var countedCards:Dictionary = countBy(cards)
			var results:Array = [];
			
			// 处理四张 三张
			for (var key:int in countedCards) {
				if (countedCards[key] == 4) {
					results.push({ name: Actions.Pao, cards: [key, key, key, key] });
				} else if (countedCards[key] === 3) {
					results.push({ name: Actions.Kan, cards: [key, key, key] });
					delete countedCards[key];
				}
			}
			
			var findShunzi:Function = function (singleCard:int):Array {
				// 贰柒拾
				if (singleCard == 2) {
					if (countedCards[7] && countedCards[10]) {
						countedCards[2]--
						countedCards[7]--
						countedCards[10]--
						return [2, 7, 10]
					}
				} else if (singleCard == 7) {
					if (countedCards[2] && countedCards[10]) {
						countedCards[2]--
						countedCards[7]--
						countedCards[10]--
						return [2, 7, 10]
					}
				} else if (singleCard == 10) {
					if (countedCards[2] && countedCards[7]) {
						countedCards[2]--
						countedCards[7]--
						countedCards[10]--
						return [2, 7, 10]
					}
				} else if (singleCard == 12) {
					if (countedCards[17] && countedCards[20]) {
						countedCards[12]--
						countedCards[17]--
						countedCards[20]--
						return [12, 17, 20]
					}
				} else if (singleCard == 17) {
					if (countedCards[12] && countedCards[20]) {
						countedCards[12]--
						countedCards[17]--
						countedCards[20]--
						return [12, 17, 20]
					}
				} else  if (singleCard == 20) {
					if (countedCards[12] && countedCards[17]) {
						countedCards[12]--
						countedCards[17]--
						countedCards[20]--
						return [12, 17, 20]
					}
				}
				
				// 顺子
				if (countedCards[singleCard + 1] && countedCards[singleCard + 2] && singleCard != 9 && singleCard != 10) {
					countedCards[singleCard]--;
					countedCards[singleCard + 1]--;
					countedCards[singleCard + 2]--;
					return [singleCard, singleCard + 1, singleCard + 2];
				}
				if (countedCards[singleCard + 1] && countedCards[singleCard - 1] && singleCard !== 10 && singleCard !== 11) {
					countedCards[singleCard]--;
					countedCards[singleCard + 1]--;
					countedCards[singleCard - 1]--;
					return [singleCard - 1, singleCard, singleCard + 1];
				}
				
				if (countedCards[singleCard - 1] && countedCards[singleCard - 2] && singleCard !== 11 && singleCard !== 12) {
					countedCards[singleCard]--;
					countedCards[singleCard - 1]--;
					countedCards[singleCard - 2]--;
					return [singleCard - 2, singleCard - 1, singleCard];
				}
				
				// 大小混搭
				if (singleCard > 10 && (countedCards[singleCard - 10] > 1)) {
					countedCards[singleCard]--;
					countedCards[singleCard - 10] -= 2;
					return [singleCard, singleCard - 10, singleCard - 10];
				}
				if (singleCard < 11 && (countedCards[singleCard + 10] > 1)) {
					countedCards[singleCard]--;
					countedCards[singleCard + 10] -= 2;
					return [singleCard, singleCard + 10, singleCard + 10];
				}
				
				return null
			}
			
			for (var key2:int in countedCards) {
				if (countedCards[key2] == 1) {
					const shunzi:Array = findShunzi(key2)
					if (shunzi) {
						results.push({ name: Actions.Chi, cards: shunzi })
					}
				} 
			}
			
			for (var key3:int in countedCards) {
				if (countedCards[key3] == 0) {
					delete countedCards[key3];
				} 
			}
			
			var keys:Array = []
			for (var key4:int in countedCards) {
				keys.push(key4)
			}
			
			if (keys.length > 1) {
				return null
			} else if (keys.length == 1) {
				if (countedCards[keys[0]] == 2) {
					results.push({ name: Actions.Jiang, cards: [parseInt(keys[0]), parseInt(keys[0])] })
				} else {
					return null
				}
			}
			
			return results
		}
		
		public function getHuXi(groups:Array):int {
			var totalHuXi:int = 0
			for each(var group:Object in groups) {
				totalHuXi = totalHuXi + getGroupHuXi(group)
			}
			return totalHuXi
		}
		
		private function getGroupHuXi(group:Object):int {
			var cards:Array = group.cards
			var type:String = group.name
			// 1. 四张大牌--提 12 胡息
			// 2. 四张小牌--提 9 胡
			// 3. 四张大牌--跑 9 胡息
			// 4. 四张小牌--跑 6 胡
			if (cards.length === 4) {
				switch (type) {
					case Actions.Ti:
						if (cards[0] > 10 && cards[0] < 21) {
							return 12;
						} else if (cards[0] > 0) {
							return 9
						}
						break;
					case Actions.Pao:
						if (cards[0] > 10 && cards[0] < 21) {
							return 9
						} else if (cards[0] > 0) {
							return 6
						}
						break;
					default:
						break;
				}
			}
			
			// 三张大牌-偎 6 胡
			// 三张小牌-偎 3 胡
			// 三张大牌-碰 3 胡
			// 三张小牌-碰 1 胡
			// 三张大牌-坎 6 胡
			// 三张小牌-坎 3 胡
			if (cards.length === 3) {
				switch (type) {
					case Actions.Wei:
						if (cards[0] > 10 && cards[0] < 21) {
							return 6
						} else if (cards[0] > 0) {
							return 3
						}
						break;
					case Actions.Peng:
						if (cards[0] > 10 && cards[0] < 21) {
							return 3
						} else if (cards[0] > 0) {
							return 1
						}
						break;
					case Actions.Kan:
						if (cards[0] > 10 && cards[0] < 21) {
							return 6
						} else if (cards[0] > 0) {
							return 3
						}
						break;
					default:
						break;
				}
			}
			
			
			if (cards.length === 3 && type === Actions.Chi) { 
				
				// 9. 壹贰叁、贰柒拾 6 胡
				if ((cards.indexOf(11) >= 0 && cards.indexOf(12) >= 0 && cards.indexOf(13) >= 0) || 
					(cards.indexOf(12) >= 0 && cards.indexOf(17) >= 0 && cards.indexOf(20) >= 0)) {
					return 6
				}
				
				// 9. 壹贰叁、贰柒拾 6 胡
				if ((cards.indexOf(1) >= 0 && cards.indexOf(2) >= 0 && cards.indexOf(3) >= 0) || 
					(cards.indexOf(2) >= 0 && cards.indexOf(7) >= 0 && cards.indexOf(10) >= 0)) {
					return 3
				}
				
			}
			
			return 0
		}
		
	}
}