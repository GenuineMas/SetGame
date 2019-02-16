//
//  Card.swift
//  SetGame
//
//  Created by Genuine on 1/5/19.
//  Copyright © 2019 Genuine. All rights reserved.
//

import Foundation

struct Card : Hashable {
    var isMatched : Bool
    var cardSelected : Bool
    var hashValue: Int {return identifier}
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var identifier : Int
    static var identifierFactory = 0
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
        
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
        self.cardSelected = false
        self.isMatched = false
    }
}
