//
//  Card.swift
//  Emoji Your Memory
//
//  Created by Nika on 12/1/16.
//  Copyright © 2016 Nika. All rights reserved.
//

import Foundation


//Enums Emojies

enum FirstFace: Int {
    case one,two,three,four,five,six,seven,eight,nine,ten
    
    static let faces = ["😘","🤗","😋","🤓","😆","😂","😜","😎","🙃","😙"]
    
    var value : String {return FirstFace.faces[rawValue - 1]}
}



// Struct for faces

// Implement Printable Protocol
// : CustomStringConvertible 
struct Card {
    
    let firstFace : FirstFace
    
    var descriprion: String {
        return"\(firstFace.value)"
    }
}


struct Deck {

    fileprivate var cards = [Card]()
    fileprivate var cardIndex : Int = 0
    
//Create a deck of cards
    init() {
           for r in 1...10 {
                if let a = FirstFace(rawValue: r){
                let card = Card(firstFace: a)
                cards.append(card)
          
            }
        }
    }
    

    
    // How many Cards are left in Deck
    func remainingCards() -> Int {
       return cards.count - cardIndex
    }

    mutating func getCard() -> Card {
        let card = cards[cardIndex]
        cardIndex += 1
        if cardIndex >= cards.count {
           shuffle()
        }
        return card
    }
    
    
    mutating func shuffle() {
        for _ in 0..<cards.count {
            let ifx = Int(arc4random_uniform(UInt32(cards.count)))
            let card = cards.remove(at: ifx)
            cards.insert(card, at: 0)
        }
        cardIndex = 0
    }
}


















































































































