//
//  scoreTV.swift
//  Emoji Your Memory
//
//  Created by Nika on 12/3/16.
//  Copyright © 2016 Nika. All rights reserved.
//

import UIKit



class ScoreTV: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
  
    @IBOutlet weak var TV: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        TV.reloadData()
    }
 
    var savedArray = savedScores.returnScoresArray()
    var scoreArray = scores
    var scoresArray1: [Int] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        scoresArray1 = scoreArray
        return scoresArray1.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
    
        
        let bestScoreForCell = savedScores.returnBestScore()
        let name = scoresArray1[indexPath.row]
      
        
        let sum = scoresArray1.reduce(0, +)
        let count = scoresArray1.count
        let avarageScore = sum / count
        
        
        cell.textLabel?.text = "Score: \(name)"
        cell.detailTextLabel?.text = "Best Score: \( bestScoreForCell) | Avarage score: \(avarageScore)"
  
        return cell
    }

    
  
}
