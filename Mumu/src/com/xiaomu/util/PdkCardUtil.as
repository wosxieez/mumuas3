package com.xiaomu.util
{
	import flash.utils.Dictionary;
	
	public class PdkCardUtil
	{
		public function PdkCardUtil()
		{
		}
		
		private static var instance:PdkCardUtil
		
		public static function getInstane(): PdkCardUtil {
			if (!instance) {
				instance = new PdkCardUtil()
			}
			return instance
		}
		
		/**
		 * 整理牌 
		 * @param cards
		 */		
		public function riffle(cards:Array):Array {
			var dic:Dictionary = new Dictionary()
			cards.forEach(function (e:int, index:int, arr:Array):void {
				var key:int = e%100
				if (dic[key]) {
					dic[key].push(e)
				} else {
					dic[key] = [e]
				}
			})
			var result:Array = []
			for each(var es:Array in dic) {
				for each(var e:int in es) {
					result.unshift(e)
				}
			}
			return result
		}
		
		public function isValidCards(cards:Array):Object {
			var result:Object = isOne(cards)
			if (result) return result
			result = isTwo(cards)
			if (result) return result
			result = isBomb(cards)
			if (result) return result
			result = isThree(cards)
			if (result) return result
			result = isShun(cards)
			if (result) return result
			result = isFeiJi(cards)
			if (result) return result
			return null
		}
		
		public function findValidCards(cards:Array):Array{
			findThree(cards)
			findTwo(cards)
			return findShun(cards)
		}
		
		//------------------------------------------------------------------------------------------------
		//
		//	Card Function
		//
		//------------------------------------------------------------------------------------------------
		
		private function isOne(cards:Array):Object {
			if (cards.length == 1) return {type: PdkCardType.ONE, card: cards[0]%100}
			else return null
		}
		
		private function findTwo(cards:Array):Array {
			var groupedCards:Dictionary = groupBy(cards.map(function(card:int, index:int, arr:Array):int { return card }))
			var result:Array = []
			for (var groupkey:int in groupedCards) {
				if (groupedCards[groupkey].length == 2) {
					result.push({card: groupkey, type: PdkCardType.TWO_ONE})
				}
			}
			
			var twoKeys:Array = []
			for (var key:int in groupedCards) {
				if (groupedCards[key] == 2) twoKeys.push(key)
			}
			
			var item:Object
			while (twoKeys.length >= 2) {
				if (shouShun(twoKeys)) {
					item = {card: twoKeys[0]}
					switch(twoKeys.length) {
						case 2: {
							item.type = PdkCardType.TWO_TWO
							break;
						}
						case 3: {
							item.type = PdkCardType.TWO_THREE
							break;
						}
						case 4: {
							item.type = PdkCardType.TWO_FOUR
							break;
						}
						case 5: {
							item.type = PdkCardType.TWO_FIVE
							break;
						}
						case 6: {
							item.type = PdkCardType.TWO_SIX
							break;
						}
						case 7: {
							item.type = PdkCardType.TWO_SEVEN
							break;
						}
						case 7: {
							item.type = PdkCardType.TWO_EIGHT
							break;
						}
						default:
						{
							break;
						}
					}
					result.push(item)
				}
				twoKeys.pop()
			} 
			
			return result
		}
		
		/**
		 * 一对 
		 */		
		private function isTwo(cards:Array):Object {
			if (cards.length < 2) return null
			var countedCards:Dictionary = countBy(cards.map(function(card:int, index:int, arr:Array):int { return card%100 }))
			var newCards:Array = []
			for (var key:int in countedCards) {
				if (countedCards[key] != 2) return null
				newCards.push(key)
			}
			if (shouShun(newCards)) {
				switch(newCards.length) {
					case 1: {
						return {type: PdkCardType.TWO_ONE, card: newCards[0]}	
						break;
					}
					case 2: {
						return {type: PdkCardType.TWO_TWO, card: newCards[0]}	
						break;
					}
					case 3: {
						return {type: PdkCardType.TWO_THREE, card: newCards[0]}	
						break;
					}
					case 4: {
						return {type: PdkCardType.TWO_FOUR, card: newCards[0]}	
						break;
					}
					case 5: {
						return {type: PdkCardType.TWO_FIVE, card: newCards[0]}	
						break;
					}
					case 6: {
						return {type: PdkCardType.TWO_SIX, card: newCards[0]}	
						break;
					}
					case 7: {
						return {type: PdkCardType.TWO_SEVEN, card: newCards[0]}	
						break;
					}
					case 8: {
						return {type: PdkCardType.TWO_EIGHT, card: newCards[0]}	
						break;
					}
					default:
					{
						break;
					}
				}
			}
			return null
		}
		
		private function findThree(cards:Array):Array {
			var groupedCards:Dictionary = groupBy(cards.map(function(card:int, index:int, arr:Array):int { return card }))
			
			var all3groupkeys:Array = []
			for (var groupkey:int in groupedCards) {
				if (groupedCards[groupkey].length == 3) {
					all3groupkeys.push(groupkey)
				}
			}
			
			var result:Array = []
			var gk:int
			var lcs:Array
			var cards3:Array
			for each (gk in all3groupkeys) {
				lcs = []
				for (var ik:int in groupedCards) {
					if (ik != gk) {
						lcs.push(groupedCards[ik])
					}
				}
				
				// 对lcs进行排序
				lcs.sort(function (a:Array, b:Array):Number {
					if (a.length > b.length) return -1
					else if (a.length == b.length) return 0
					else return 1
				})
				
				var tarr:Array = []
				for each(var arr:Array in lcs) {
					tarr = tarr.concat(arr)
				}
				
				if (tarr.length >= 2) {
					cards3 = groupedCards[gk].concat([tarr.pop(), tarr.pop()])
					result.push({type: PdkCardType.THREE_TWO, card: gk, cards: cards3})
				} else {
					cards3 = groupedCards[gk]
					result.push({type: PdkCardType.THREE_ZERO, card: gk, cards: cards3})
				}
			}
			
			return result
		}
		
		private function isThree(cards:Array):Object {
			if (cards.length < 3 || cards.length > 5) return null
			var countedCards:Dictionary = countBy(cards.map(function(card:int, index:int, arr:Array):int { return card%100 }))
			var has3Card:int = -1
			var has2Card:int = -1
			var countCard:int = 0
			for (var card:int in countedCards) {
				countCard++
				if (countedCards[card] == 3) {
					has3Card = card
				} else if (countedCards[card] == 2) {
					has2Card = card
				}
			}
			if (has3Card >= 0) {
				if (has2Card >= 0) {
					return {type: PdkCardType.THREE_TWO, card: has3Card}	 
				} 
				else if (countCard == 1) {
					return {type: PdkCardType.THREE_ZERO, card: has3Card}	 
				} else if (countCard == 2) {
					//					return {type: PdkCardType.THREE_ONE, card: has3Card}	 
				} else if (countCard == 3) {
					return {type: PdkCardType.THREE_TWO, card: has3Card}	 
				}
			}
			return null
		}
		
		private function getCards(newCards:Array, cards:Array):Array {
			var oldCards:Array = []
			for each(var newCard:int in newCards) {
				if (cards.indexOf(newCard + 100) >= 0) {
					oldCards.push(newCard + 100)
				} else if (cards.indexOf(newCard + 200) >= 0) {
					oldCards.push(newCard + 200)
				} else if (cards.indexOf(newCard + 300) >= 0) {
					oldCards.push(newCard + 300)
				} else if (cards.indexOf(newCard + 400) >= 0) {
					oldCards.push(newCard + 400)
				} else {
					return []
				}				
			}
			return oldCards
		}
		
		private function findShun(cards:Array):Array {
			var result:Array = []
			if (cards.length < 5) return result
			var countedCards:Dictionary = countBy(cards.map(function(card:int, index:int, arr:Array):int { return card%100 }))
			var newCards:Array = []
			for (var card:int in countedCards) {
				newCards.push(card)
			}
			
			var item:Object
			while (newCards.length >= 5) {
				if (shouShun(newCards)) {
					item = {card: newCards[0], cards: getCards(newCards, cards)}
					switch(newCards.length) {
						case 5: {
							item.type = PdkCardType.SHUN_FIVE
							break;
						}
						case 6: {
							item.type = PdkCardType.SHUN_SIX
							break;
						}
						case 7: {
							item.type = PdkCardType.SHUN_SEVEN
							break;
						}
						case 8: {
							item.type = PdkCardType.SHUN_EIGHT
							break;
						}
						case 9: {
							item.type = PdkCardType.SHUN_NINE
							break;
						}
						case 10: {
							item.type = PdkCardType.SHUN_TEN
							break;
						}
						case 11: {
							item.type = PdkCardType.SHUN_ELEVEN
							break;
						}
						case 12: {
							item.type = PdkCardType.SHUN_TWELVE
							break;
						}
						default:
						{
							break;
						}
					}
					result.push(item)
				}
				newCards.pop()
			} 
			return result
		}
		
		private function isShun(cards:Array):Object {
			if (cards.length < 5) return null
			var newCards:Array = cards.map(function(card:int, index:int, arr:Array):int { return card%100 })
			if (shouShun(newCards)) {
				switch(newCards.length) {
					case 5: {
						return {type: PdkCardType.SHUN_FIVE, card: newCards[0]}	 
						break;
					}
					case 6: {
						return {type: PdkCardType.SHUN_SIX, card: newCards[0]}	 
						break;
					}
					case 7: {
						return {type: PdkCardType.SHUN_SEVEN, card: newCards[0]}	 
						break;
					}
					case 8: {
						return {type: PdkCardType.SHUN_EIGHT, card: newCards[0]}	 
						break;
					}
					case 9: {
						return {type: PdkCardType.SHUN_NINE, card: newCards[0]}	 
						break;
					}
					case 10: {
						return {type: PdkCardType.SHUN_TEN, card: newCards[0]}	 
						break;
					}
					case 11: {
						return {type: PdkCardType.SHUN_ELEVEN, card: newCards[0]}	 
						break;
					}
					case 12: {
						return {type: PdkCardType.SHUN_TWELVE, card: newCards[0]}	 
						break;
					}
					default:
					{
						break;
					}
				}
			}
			return null
		}
		
		private function isFeiJi(cards:Array):Object {
			if (cards.length < 6) return null
			var countedCards:Dictionary = countBy(cards.map(function(card:int, index:int, arr:Array):int { return card%100 }))
			var newCards:Array = []
			for (var key:int in countedCards) {
				if (countedCards[key] != 3) return null
				newCards.push(key)
			}
			if (shouShun(newCards)) {
				newCards.sort()
				switch(newCards.length) {
					case 2: {
						return {type: PdkCardType.FEIJI_TWO, card: newCards[0]}	
						break;
					}
					case 3: {
						return {type: PdkCardType.FEIJI_THREE, card: newCards[0]}	
						break;
					}
					case 4: {
						return {type: PdkCardType.FEIJI_FOUR, card: newCards[0]}	
						break;
					}
					case 5: {
						return {type: PdkCardType.FEIJI_FIVE, card: newCards[0]}	
						break;
					}
					default:
					{
						break;
					}
				}
			}
			return null
		}
		
		private function isBomb(cards:Array):Object {
			var newCards:Array = cards.map(function(card:int, index:int, arr:Array):int { return card%100 })
			if (newCards.length ==4 &&
				newCards[0] == newCards[1] &&
				newCards[1] == newCards[2] &&
				newCards[2] == newCards[3]) {
				return {type: PdkCardType.BOMB, card: newCards[0]}
			} else if (newCards.length ==3 &&   // 3 个 A A A
				newCards[0] == 14 &&
				newCards[1] == 14 &&
				newCards[2] == 14) {
				return {type: PdkCardType.BOMB, card: newCards[0]}
			} else {
				return null
			}
		}
		
		//------------------------------------------------------------------------------------------------
		//
		//	Util Function
		//
		//------------------------------------------------------------------------------------------------
		
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
		private function groupBy(cards:Array):Dictionary {
			var groupCards:Dictionary = new Dictionary()
			var groupKey:int
			for each(var card:int in cards) {
				groupKey = card%100
				if (groupCards.hasOwnProperty(groupKey)) {
					groupCards[groupKey].push(card)
				} else {
					groupCards[groupKey] = [card]
				}
			}
			return groupCards
		}
		private function shouShun(cards:Array):Boolean {
			if (cards.length == 0) return false
			cards.sort(function (a:int, b:int):Number {
				if (a < b) return -1
				else return 1
			})
			for (var i:int = 0; i < cards.length; i++) {
				if (i > 0 && cards[i] != (cards[i-1] + 1)) {
					return false
				}
			}
			return true
		}
		
	}
}