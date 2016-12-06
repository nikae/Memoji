//
//  Game.swift
//  Emoji Your Memory
//
//  Created by Nika on 12/1/16.
//  Copyright © 2016 Nika. All rights reserved.
//

import Foundation
import AVFoundation

struct Slot {
    var card : Card?
    var visible = false
}



class Game {
    fileprivate let rows : Int!
    fileprivate let cols : Int!
    fileprivate var deck = Deck()
    fileprivate var slots = [Slot]()
    fileprivate var slot1 = -1
    fileprivate var slot2 = -1
    fileprivate var numMatches = 0
     
    var score = 0
  
    
    init(rows: Int, cols:Int) {
        self.rows = rows
        self.cols = cols
        
        let totalSlots = rows * cols
        for _ in 0..<totalSlots {
            slots.append(Slot())
        }
    }
    
    //generate the Game
    func ganGame() {
        deck.shuffle()
        numMatches = 0
        slot1 = -1
        slot2 = -1
        score = 0
        
         let totalSlots = rows * cols
        var freeSlots = [Int]()
        for i in 0..<totalSlots {
            freeSlots.append(i)
        }
        
        for _ in 0..<totalSlots/2 {
            let card = deck.getCard()
            let card2 = card
            let idx1 = freeSlots.remove(at: 0)
            let rnd = Int(arc4random_uniform(UInt32(freeSlots.count)))
            let idx2 = freeSlots.remove(at: rnd)
            slots[idx1].card = card
            slots[idx1].visible = false
            slots[idx2].card = card2
            slots[idx2].visible = false
        }
    }
        //Flip a card
        func flipCars(index: Int) -> (String?, Bool){
          
            if index < 0 || index >= slots.count {
                
                return (nil, false)
            }
            
            let slot = slots[index]
            if slot.visible{
                return (nil,false)
            }
            
            if let card = slot.card {
                slots[index].visible = true
                if slot1 == -1 {
                    slot1 = index
                } else {
                    slot2 = index
                    score += 1
                  
                }
                
                return (card.descriprion,(slot2 == index))
            }
            
        return (nil, false)
        }
    
    
    fileprivate func getSlotIndex(index: Int) -> Slot? {
            if index < 0 || index >= slots.count {
                return nil
            }
            return slots[index]
        }
        
    func match() -> (Bool, Bool) {
        if let slot1 = getSlotIndex(index: slot1),
            let slot2 = getSlotIndex(index: slot2) {
            if slot1.card?.firstFace == slot2.card?.firstFace {
                numMatches += 1
                return (true,(numMatches == slots.count/2))
            }
            return (false, false)
        }
        return (false, false)
    }
    
        // Return the picked Slots - Controller will need this
    func getSlot() -> (Int,Int) {
        return (slot1,slot2)
    }
    
    func reset() {
        slots[slot1].visible = false
        slots[slot2].visible = false
        slot1 = -1
        slot2 = -2
    }
    
 
    
}





































