//
//  SetGame.swift
//  SetGame
//
//  Created by Genuine on 1/8/19.
//  Copyright © 2019 Genuine. All rights reserved.
//

import Foundation
struct SetGame {

    var selectedCards = [Card] ()
    var cardsInGame =  [Card] ()
    var deckOfCards =   [Card] ()
    var matchedCards = [Card] ()
    
    
    
    init (numberOfCardsinDeck:Int = 81) {
        for _ in 1...(numberOfCardsinDeck) {
        let  card = Card()
        deckOfCards += [card]
        }
        
        for _ in 1...12 {
            let randomise = (deckOfCards.count-1).arc4random
            let removedCard = deckOfCards.remove(at: randomise)
            cardsInGame.append(removedCard)
           // print(randomise)
        }
    }
    func tryToMatch (selectedTitles : [[String]])-> Bool {
        var comp = [Bool]()
        for n in 0...(selectedTitles.count){
            var chars = selectedTitles.map{$0[n]}
            if (chars[0]==chars[1] && chars[0] == chars[2] && chars[1] == chars[2]) || (chars[0] != chars[1] && chars[0] != chars[2] && chars[1] != chars[2]) {
                comp.append(true)
            } else {
                comp.append(false)
            }
        }
        var temp : Bool
        if comp.contains(false) {
            temp = false
        }
        else {
            temp = true
        }
        return temp
    }

    

    
    
    
}


extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        }
        else {
            return 0
        }
}
}
