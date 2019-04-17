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
			
			// 6. 对子
			for (card in countedCards) {
				if (countedCards[card] == 2) {
					if (countedCards[card + 10] == 1) {
						riffledCards.push([card, card, card + 10])
						delete(countedCards[card + 10])
					} else if (countedCards[card - 10] == 1) {
						riffledCards.push([card, card, card - 10])
						delete(countedCards[card - 10])
					} else {
						riffledCards.push([card, card])
					}
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
			
			// 7. 一句话
			for (card in countedCards) {
				if(countedCards[card] && countedCards[card] > 0 && countedCards[card+1] && countedCards[card+2] && (card!==10) && (card!==9)){
					riffledCards.push([card, card+1, card+2]);
					countedCards[card]--;
					countedCards[card+1]--;
					countedCards[card+2]--;
				}
			}
			
			// 大小混搭
			for (card in countedCards) {
				// 大小混搭
				if (card > 10 && countedCards[card] > 0 && (countedCards[card - 10] > 1)) {
					countedCards[card]--;
					countedCards[card - 10] -= 2;
					riffledCards.push([card, card - 10, card - 10]);
					
				}
				if (card < 11 && countedCards[card] > 0 && (countedCards[card + 10] > 1)) {
					countedCards[card]--;
					countedCards[card + 10] -= 2;
					riffledCards.push([card, card + 10, card + 10]);
				}
			}
			
			// 8. 两张
			for (card in countedCards) {
				if(countedCards[card] && countedCards[card] > 0 && countedCards[card+1] && (card!==10)){
					riffledCards.push([card, card+1]);
					countedCards[card]--;
					countedCards[card+1]--;
				}
			}
			
			// 8. 大小牌
			for (card in countedCards) {
				if(countedCards[card] && countedCards[card] > 0 && countedCards[card+10]){
					riffledCards.push([card, card+10]);
					countedCards[card]--;
					countedCards[card+10]--;
				}
			}
			
			// 9. 散牌
			var countedCardsArray:Array = [];
			for (card in countedCards) {
				if (countedCards[card] && countedCards[card] > 0){
					countedCardsArray.push(card);
					if(countedCardsArray.length === 1){
						riffledCards.push(countedCardsArray);
						countedCardsArray = [];
					}
				}
			}
			if(countedCardsArray.length > 0){
				riffledCards.push(countedCardsArray);
			}
			
			function sortGroup(a:Object, b:Object):Number {
				if((a[0] - 1)%10 > (b[0] - 1)%10) {
					return 1
				} else if((a[0] - 1)%10 < (b[0] - 1)%10) {
					return -1
				} else  {
					return 0;
				}
			}
			riffledCards.sort(sortGroup)
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
		
		public function canOutCardTing(groupCards:Array, handCards:Array, huXi:int):Array {
			var outTingCards:Array = []
			
			var myGroupCards:Array = groupCards.concat([])
			var myhandCards:Array = handCards.concat([])
			var countedCards:Dictionary = countBy(myhandCards)
			// 坎牌不能出
			for (var card:int in countedCards) {
				if (countedCards[card] == 3) {
					myGroupCards.push({name: 'kan', cards: [card, card, card]})
					deleteCard(myhandCards, card)
					deleteCard(myhandCards, card)
					deleteCard(myhandCards, card)
				}
			}
			
			for (var i:int = 0; i < myhandCards.length; i++) {
				var newHandCards:Array = myhandCards.concat([])
				var outCard:int = newHandCards[i]
				newHandCards.splice(i, 1)
				var tingCards:Array = canTing(myGroupCards, newHandCards, huXi)
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
				var canHuDatas:Array = canHu(handCards, groupCards, i)
				if (canHuDatas) {
					var maxhx:int = 0
					for each(var canHuData:Array in canHuDatas) {
						maxhx = Math.max(getHuXi(canHuData), maxhx)
					}
					if (maxhx >= huXi) {
						tingCards.push(i)
					}
				}
			}
			if (tingCards.length > 0) {
				return tingCards
			} else {
				return null
			}
		}
		
		public function canHu(cardsOnHand:Array, cardsOnGroup:Array, currentCard:int):Array {
			var allGroups:Array = []
			if (currentCard != 0) {
				// 看组合牌中能不能跑起
				var aHandCards:Array = JSON.parse(JSON.stringify(cardsOnHand)) as Array
				var aGroupCards:Array = JSON.parse(JSON.stringify(cardsOnGroup)) as Array
				var paoGroup:Object = canTi2(aGroupCards, currentCard)
				if (paoGroup) {
					if (paoGroup.name == Actions.Wei) {
						paoGroup.name = Actions.Ti
					} else {
						paoGroup.name = Actions.Pao
					}
					paoGroup.cards.push(currentCard)
					var shun:Array = shouShun(aHandCards, currentCard)
					if (shun) {
						allGroups.push(aGroupCards.concat(shun))
					}
				}
				// 看手里牌能不能跑
				var aHandCards1:Array = JSON.parse(JSON.stringify(cardsOnHand)) as Array
				var aGroupCards1:Array = JSON.parse(JSON.stringify(cardsOnGroup)) as Array
				var canPaoCards:Array = canTi(aHandCards1, currentCard)
				if (canPaoCards) {
					for each(var card:int in canPaoCards) {
						deleteCard(aHandCards1, card)
					}
					aGroupCards1.push({ name: Actions.Ti, cards: [currentCard, currentCard, currentCard, currentCard] })
					var shun1:Array = shouShun(aHandCards1, currentCard)
					if (shun1) {
						allGroups.push(aGroupCards1.concat(shun1))
					}
				}
				
				// 看手里牌能不能碰
				var aHandCards2:Array = JSON.parse(JSON.stringify(cardsOnHand)) as Array
				var aGroupCards2:Array = JSON.parse(JSON.stringify(cardsOnGroup)) as Array 
				var canPengCards:Array = canPeng(aHandCards2, currentCard)
				if (canPengCards) {
					for each(var card2:int in canPengCards) {
						deleteCard(aHandCards2, card2)
					}
					aGroupCards2.push({ name: Actions.Wei, cards: [currentCard, currentCard, currentCard] })
					var shun2:Array = shouShun(aHandCards2, currentCard)
					if (shun2) {
						allGroups.push(aGroupCards2.concat(shun2))
					}
				}
				
				// 看手里牌能不能吃
				var canChiGroups:Array = canChi(cardsOnHand, currentCard)
				if (canChiGroups) {
					for each(var chiGroup:Object in canChiGroups) {
						var aHandCards3:Array = JSON.parse(JSON.stringify(cardsOnHand)) as Array
						var aGroupCards3:Array = JSON.parse(JSON.stringify(cardsOnGroup)) as Array
						for each(var card3:int in chiGroup.cards) {
							deleteCard(aHandCards3, card3)
						}
						chiGroup.cards.push(currentCard)
						aGroupCards3.push({ name: Actions.Chi, cards: chiGroup.cards })
						var shun3:Array = shouShun(aHandCards3, currentCard)
						if (shun3) {
							allGroups.push(aGroupCards3.concat(shun3))
						}
					}
				}
				
				var aHandCards4:Array = JSON.parse(JSON.stringify(cardsOnHand)) as Array
				var aGroupCards4:Array = JSON.parse(JSON.stringify(cardsOnGroup)) as Array
				aHandCards4.push(currentCard)
				var shun4:Array = shouShun(aHandCards4, currentCard)
				if (shun4) {
					allGroups.push(aGroupCards4.concat(shun4))
				}
			} else {
				// currentCard === 0
				var aHandCards5:Array = JSON.parse(JSON.stringify(cardsOnHand)) as Array
				var aGroupCards5:Array = JSON.parse(JSON.stringify(cardsOnGroup)) as Array
				var shun5:Array = shouShun(aHandCards5, currentCard)
				if (shun5) {
					allGroups.push(aGroupCards5.concat(shun5))
				}
			}
			
			if (allGroups.length >= 1) {
				return allGroups
			} else {
				return null
			}
		}
		
		/**
		 * 玩家的牌是否无单牌。
		 * @param cards: 手中的牌，或者手中的牌加新翻开的底牌。
		 */
		public function shouShun(cards:Array, currentCard:int):Array {
			if (cards.length == 0) return []
			var kanShuns:Array = []
			var countedCards:Dictionary = countBy(cards)
			for (var card:int in countedCards) {
				if (countedCards[card] == 3 && card != currentCard) {
					kanShuns.push({ name: Actions.Kan, cards: [card, card, card] })
					deleteCard(cards, card)
					deleteCard(cards, card)
					deleteCard(cards, card)
				}
			}
			var allShuns:Array = canShun(cards, [])
			if (allShuns) {
				if (allShuns.length > 0) {
					var maxHuXi:int = 0
					var maxHuGroup:Array = null
					for each(var shuns:Array in allShuns) {
						var lastedShuns:Array = kanShuns.concat(shuns)
						var huxi:int =getHuXi(lastedShuns)
						if (huxi >= maxHuXi) {
							maxHuXi = huxi
							maxHuGroup = lastedShuns
						}
					}
					return maxHuGroup
				} else {
					return kanShuns
				}
			} else {
				return null
			}
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
		
		public function deleteCard(cards:Array, card:int):void {
			for (var i:int = 0; i < cards.length; i++) {
				if (cards[i] == card) {
					cards.splice(i, 1)
					break
				}
			}
		}
		
		public function canTi(cardsOnHand, currentCard):Array {
			var countedCards:Dictionary = countBy(cardsOnHand)
			var canTiCards:Array = null
			if (countedCards[currentCard] === 3) {
				canTiCards = [currentCard, currentCard, currentCard]
			}
			return canTiCards
		}
		
		/**
		 * 看组合牌中能不能 跑 / 提
		 *
		 * @param {*} cardsOnGroup
		 * @param {*} currentCard
		 * @returns
		 */
		public function canTi2(cardsOnGroup:Array, currentCard:int):Object {
			var group:Object
			var can:Boolean = false
			for (var i:int = 0; i < cardsOnGroup.length; i++) {
				group = cardsOnGroup[i]
				if (group.cards.length == 3) {
					can = true
					for (var j:int = 0; j < group.cards.length; j++) {
						if (group.cards[j] != currentCard) {
							can = false
							break
						}
					}
				} else {
					can = false
				}
				
				if (can) {
					return group
				}
			}
			
			return null
		}
		
		
		public function canPeng(cardsOnHand, currentCard):Array {
			var canPeng:Array = null;
			var countedCards:Dictionary = countBy(cardsOnHand);
			if (countedCards[currentCard] == 2) {
				canPeng = [currentCard, currentCard];
			}
			return canPeng;
		}
		
		
		public function canChi(cards, currentCard):Array {
			var canChiDatas:Array = []
			var countedCards:Dictionary = countBy(cards);
			var card:int
			for (card in countedCards) {
				if (countedCards[card] == 3) {
					delete countedCards[card]
				}
			}
			
			// 比方 currentCard = 8
			if (countedCards[currentCard - 1]) {
				if (countedCards[currentCard - 2] && currentCard !== 11 && currentCard !== 12) {
					canChiDatas.push({ name: Actions.Chi, cards: [currentCard - 1, currentCard - 2] }) // 判断8在尾部 查询 6 7 '8'  尾牌不能等于 11 12
				}
				if (countedCards[currentCard + 1] && currentCard !== 10 && currentCard !== 11) {
					canChiDatas.push({ name: Actions.Chi, cards: [currentCard - 1, currentCard + 1] }) // 判断8在中部 查询 7 '8' 9  中牌不能等于 10 11
				}
			}
			
			if (countedCards[currentCard + 1]) {
				if (countedCards[currentCard + 2] && currentCard !== 9 && currentCard !== 10) {
					canChiDatas.push({ name: Actions.Chi, cards: [currentCard + 1, currentCard + 2] }) // 判断8在首部 查询 '8' 9 10 首牌不能等于 9 10
				}
			}
			
			if (currentCard < 11) {
				// 8
				if (countedCards[currentCard] && countedCards[currentCard + 10]) {
					canChiDatas.push({ name: Actions.Chi, cards: [currentCard, currentCard + 10] }) // 判断 8 8 18
				}
				if (countedCards[currentCard + 10] >= 2) {
					canChiDatas.push({ name: Actions.Chi, cards: [currentCard + 10, currentCard + 10] }) // 判断 8 18 18
				}
				
				if (currentCard == 2) {
					if (countedCards[7] && countedCards[10]) {
						canChiDatas.push({ name: Actions.Chi, cards: [7, 10] })
					}
				} else if (currentCard == 7) {
					if (countedCards[2] && countedCards[10]) {
						canChiDatas.push({ name: Actions.Chi, cards: [2, 10] })
					}
				} else if (currentCard == 10) {
					if (countedCards[2] && countedCards[7]) {
						canChiDatas.push({ name: Actions.Chi, cards: [2, 7] })
					}
				}
			} else {
				// 18
				if (countedCards[currentCard] && countedCards[currentCard - 10]) {
					canChiDatas.push({ name: Actions.Chi, cards: [currentCard, currentCard - 10] }) // 判断 18 18 8
				}
				if (countedCards[currentCard - 10] >= 2) {
					canChiDatas.push({ name: Actions.Chi, cards: [currentCard - 10, currentCard - 10] }) // 判断 18 8 8
				}
				
				if (currentCard == 12) {
					if (countedCards[17] && countedCards[20]) {
						canChiDatas.push({ name: Actions.Chi, cards: [ 17, 20] }) // 判断 18 8 8
					}
				} else if (currentCard == 17) {
					if (countedCards[12] && countedCards[20]) {
						canChiDatas.push({ name: Actions.Chi, cards: [ 12, 20] }) // 判断 18 8 8
					}
				} else  if (currentCard == 20) {
					if (countedCards[12] && countedCards[17]) {
						canChiDatas.push({ name: Actions.Chi, cards: [ 12, 17] }) // 判断 18 8 8
					}
				}
			}
			
			var validChiDatas:Array = [] // 有效的吃数据
			for each (var chiData:Object in canChiDatas) {
				var subBi:Array = canBi(JSON.parse(JSON.stringify(cards)), chiData.cards, currentCard)
				if (subBi) {
					if (subBi.length > 0) {
						chiData.bi = subBi
						validChiDatas.push(chiData) // 有效吃
					}
				} else {
					validChiDatas.push(chiData) // 有效吃
				}
			}
			
			if (validChiDatas.length > 0) {
				return validChiDatas
			} else {
				return null
			}
		}
		
		
		public function canBi(cards, needDeleteCards, currentCard):Array {
			// 删除要删除的卡牌
			for each(var card:int in needDeleteCards) {
				deleteCard(cards, card)
			}
			
			var countedCards:Dictionary = countBy(cards)
			var card2:int
			for (card2 in countedCards) {
				if (countedCards[card2] == 3) {
					delete countedCards[card2]
				}
			}
			
			// 如果没有2 返回null
			if (!countedCards[currentCard]) {
				return null
			}
			
			var biDatas:Array = []
			
			// 比方 currentCard = 8
			if (countedCards[currentCard - 1]) {
				if (countedCards[currentCard - 2] && currentCard !== 11 && currentCard !== 12) {
					biDatas.push({ name: Actions.Chi, cards: [currentCard, currentCard - 1, currentCard - 2] }) // 判断8在尾部 查询 6 7 '8'  尾牌不能等于 11 12
				}
				if (countedCards[currentCard + 1] && currentCard !== 10 && currentCard !== 11) {
					biDatas.push({ name: Actions.Chi, cards: [currentCard - 1, currentCard, currentCard + 1] }) // 判断8在中部 查询 7 '8' 9  中牌不能等于 10 11
				}
			}
			
			if (countedCards[currentCard + 1]) {
				if (countedCards[currentCard + 2] && currentCard !== 9 && currentCard !== 10) {
					biDatas.push({ name: Actions.Chi, cards: [currentCard, currentCard + 1, currentCard + 2] }) // 判断8在首部 查询 '8' 9 10 首牌不能等于 9 10
				}
			}
			
			if (currentCard < 11) {
				// 8
				if (countedCards[currentCard] >= 2 && countedCards[currentCard + 10]) {
					biDatas.push({ name: Actions.Chi, cards: [currentCard, currentCard, currentCard + 10] }) // 判断 8 8 18
				}
				if (countedCards[currentCard + 10] >= 2) {
					biDatas.push({ name: Actions.Chi, cards: [currentCard, currentCard + 10, currentCard + 10] }) // 判断 8 18 18
				}
				
				if (currentCard == 2) {
					if (countedCards[7] && countedCards[10]) {
						biDatas.push({ name: Actions.Chi, cards: [2, 7, 10] })
					}
				} else if (currentCard == 7) {
					if (countedCards[2] && countedCards[10]) {
						biDatas.push({ name: Actions.Chi, cards: [2, 7, 10] })
					}
				} else if (currentCard == 10) {
					if (countedCards[2] && countedCards[7]) {
						biDatas.push({ name: Actions.Chi, cards: [2, 7, 10] })
					}
				}
			} else {
				// 18
				if (countedCards[currentCard] >= 2 && countedCards[currentCard - 10]) {
					biDatas.push({ name: Actions.Chi, cards: [currentCard, currentCard, currentCard - 10] })
				}
				if (countedCards[currentCard - 10] >= 2) {
					biDatas.push({ name: Actions.Chi, cards: [currentCard, currentCard - 10, currentCard - 10] })
				}
				
				if (currentCard == 12) {
					if (countedCards[17] && countedCards[20]) {
						biDatas.push({ name: Actions.Chi, cards: [12, 17, 20] }) 
					}
				} else if (currentCard == 17) {
					if (countedCards[12] && countedCards[20]) {
						biDatas.push({ name: Actions.Chi, cards: [12, 17, 20] })
					}
				} else  if (currentCard == 20) {
					if (countedCards[12] && countedCards[17]) {
						biDatas.push({ name: Actions.Chi, cards: [12, 17, 20] })
					}
				}
			}
			
			var validBiDatas:Array = []
			for each(var biData:Object in biDatas) {
				var subBi:Array = canBi(JSON.parse(JSON.stringify(cards)), biData.cards, currentCard)
				if (subBi) {
					if (subBi.length > 0) {
						biData.bi = subBi
						validBiDatas.push(biData) // 返回的长度大于0 为有效比
					}
				} else {
					validBiDatas.push(biData) // 返回false 为有效比 没有子比了
				}
			}
			return validBiDatas
		}
		
		
		private function canShun(cards:Array, needDeleteCards:Array):Array {
			
			for each(var card:int in needDeleteCards) {
				deleteCard(cards, card)
			}
			
			var allShuns:Array = []
			var canShuns:Array = []
			
			if (cards.length > 0) {
				var countedCards:Object = countBy(cards);
				var currentCard:int = cards[0]
				countedCards[currentCard]--
				
				// 列出吃
				if (countedCards[currentCard - 1]) {
					if (countedCards[currentCard - 2] && currentCard !== 11 && currentCard !== 12) {
						canShuns.push({ name: Actions.Chi, cards: [currentCard - 2, currentCard - 1, currentCard] }) // 判断8在尾部 查询 6 7 '8'  尾牌不能等于 11 12
					}
					if (countedCards[currentCard + 1] && currentCard !== 10 && currentCard !== 11) {
						canShuns.push({ name: Actions.Chi, cards: [currentCard - 1, currentCard, currentCard + 1] }) // 判断8在中部 查询 7 '8' 9  中牌不能等于 10 11
					}
				}
				if (countedCards[currentCard + 1]) {
					if (countedCards[currentCard + 2] && currentCard !== 9 && currentCard !== 10) {
						canShuns.push({ name: Actions.Chi, cards: [currentCard, currentCard + 1, currentCard + 2] }) // 判断8在首部 查询 '8' 9 10 首牌不能等于 9 10
					}
				}
				if (currentCard < 11) {
					// 8
					if (countedCards[currentCard] && countedCards[currentCard + 10]) {
						canShuns.push({ name: Actions.Chi, cards: [currentCard, currentCard, currentCard + 10] }) // 判断 8 8 18
					}
					if (countedCards[currentCard + 10] >= 2) {
						canShuns.push({ name: Actions.Chi, cards: [currentCard, currentCard + 10, currentCard + 10] }) // 判断 8 18 18
					}
					// 2 7 10
					if (currentCard == 2) {
						if (countedCards[7] && countedCards[10]) {
							canShuns.push({ name: Actions.Chi, cards: [2, 7, 10] })
						}
					} else if (currentCard == 7) {
						if (countedCards[2] && countedCards[10]) {
							canShuns.push({ name: Actions.Chi, cards: [2, 7, 10] })
						}
					} else if (currentCard == 10) {
						if (countedCards[2] && countedCards[7]) {
							canShuns.push({ name: Actions.Chi, cards: [2, 7, 10] })
						}
					}
				} else {
					// 18
					if (countedCards[currentCard] && countedCards[currentCard - 10]) {
						canShuns.push({ name: Actions.Chi, cards: [currentCard, currentCard, currentCard - 10] }) // 判断 18 18 8
					}
					if (countedCards[currentCard - 10] >= 2) {
						canShuns.push({ name: Actions.Chi, cards: [currentCard, currentCard - 10, currentCard - 10] }) // 判断 18 8 8
					}
					if (currentCard == 12) {
						if (countedCards[17] && countedCards[20]) {
							canShuns.push({ name: Actions.Chi, cards: [12, 17, 20] }) 
						}
					} else if (currentCard == 17) {
						if (countedCards[12] && countedCards[20]) {
							canShuns.push({ name: Actions.Chi, cards: [12, 17, 20] })
						}
					} else  if (currentCard == 20) {
						if (countedCards[12] && countedCards[17]) {
							canShuns.push({ name: Actions.Chi, cards: [12, 17, 20] })
						}
					}
				}
				
				// 12 12
				// 列出 将
				if (countedCards[currentCard] >= 1) {
					canShuns.push({ name: Actions.Jiang, cards: [currentCard, currentCard] })
				}
				
				if (canShuns.length > 0) {
					for each(var shun:Object in canShuns) {
						var subShuns:Array = canShun(JSON.parse(JSON.stringify(cards)) as Array, shun.cards)
						if (subShuns) {
							if (subShuns.length > 0) {
								for each(var subShun:Array in subShuns) {
									allShuns.push([shun].concat(subShun))
								}
							} else {
								allShuns.push([shun])
							}
						}
					}
					
					var validAllShuns:Array = []
					
					for each(var shuns:Array in allShuns) {
						var jc:int = 0
						
						for each(var shun2:Object in shuns) {
							if (shun2.name === Actions.Jiang)
								jc++
						}
						
						if (jc <= 1) {
							validAllShuns.push(shuns)
						}
					}
					
					if (validAllShuns.length > 0) {
						return validAllShuns
					} else {
						return null
					}
				} else {
					return null
				}
			} else {
				return []
			}
		}
		
	}
}