//
//  Functions.swift
//  Memoji
//
//  Created by Nika on 12/6/16.
//  Copyright © 2016 Nika. All rights reserved.
//

import Foundation

var scores: [Int] = []
var bestScore = 0
var savedScores = SavedScores()



struct SavedScores {
    
func returnBestScore() -> Int {
    let defaults = UserDefaults.standard
    if(defaults.value(forKey: "bestScore") != nil) {
       bestScore = defaults.value(forKey: "bestScore") as! Int
    }
    return bestScore
}


func returnScoresArray() -> [Int] {
        let defaults = UserDefaults.standard
    if(defaults.object(forKey: "score") != nil) {
         scores = defaults.value(forKey: "score") as? [Int] ?? [Int]()
    }
    return scores
}
    
}
