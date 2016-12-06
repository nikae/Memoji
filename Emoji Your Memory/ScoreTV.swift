//
//  scoreTV.swift
//  Emoji Your Memory
//
//  Created by Nika on 12/3/16.
//  Copyright © 2016 Nika. All rights reserved.
//

import UIKit


var gameArray: [Int] = []
var scores: [Int] = []
var bestScore = 0




class ScoreTV: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
  
    @IBOutlet weak var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
    }
    
    
    var scoresArray = scores
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoresArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        

        
        let name = scoresArray[indexPath.row]
        let game = gameArray[indexPath.row]
        
        let sum = scores.reduce(0, +)
        let count =  scores.count
        let avarageScore = sum / count
        
        
        cell.textLabel?.text = "Game: \(game) | Score: \(name)"
        cell.detailTextLabel?.text = "Best Score: \(bestScore) | Avarage score: \(avarageScore)"
  
        return cell
    }

    
  
}
