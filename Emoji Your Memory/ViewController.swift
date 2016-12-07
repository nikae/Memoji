//
//  ViewController.swift
//  Emoji Your Memory
//
//  Created by Nika on 11/30/16.
//  Copyright © 2016 Nika. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation


class ViewController: UIViewController, CardViewDelegate {
    
   
    private let rows = 4
    private let cols = 4
    private let game = Game(rows: 4, cols: 4)
    
   private let bestScoreForAlert = savedScores.returnBestScore()
    
    fileprivate var avSoundPlayer1 : AVAudioPlayer?
    fileprivate let cheering = Bundle.main.url(forResource: "1_person_cheering-Jett_Rifkin-1851518140", withExtension: "wav")!
    fileprivate var avSoundPlayer2 : AVAudioPlayer?
    fileprivate let fake = Bundle.main.url(forResource: "Fake Applause-SoundBible.com-1541144825", withExtension: "wav")!
    fileprivate var avSoundPlayer3 : AVAudioPlayer?
    fileprivate let mystic = Bundle.main.url(forResource: "Mystic_Chanting_3-Marianne_Gagnon-1163676956", withExtension: "wav")!
    
    func playMystic() {
        avSoundPlayer3 = try? AVAudioPlayer(contentsOf: mystic)
        avSoundPlayer3?.prepareToPlay()
        avSoundPlayer3?.currentTime = 0
        avSoundPlayer3?.play()
    }

    
    func playCheering() {
        avSoundPlayer1 = try? AVAudioPlayer(contentsOf: cheering)
        avSoundPlayer1?.prepareToPlay()
        avSoundPlayer1?.currentTime = 0
        avSoundPlayer1?.play()
    }

    func playFake(){
        avSoundPlayer2 = try? AVAudioPlayer(contentsOf: fake)
        avSoundPlayer2?.prepareToPlay()
        avSoundPlayer2?.currentTime = 0
        avSoundPlayer2?.play()
    }

    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var bestScoreLAbel: UILabel!
    
    @IBAction func newGAmeHit(_ sender: UIBarButtonItem) {
        newGame()

        
            }
    
    private func newGame(){
        playMystic()
        
        scoreLabel.text = "Score: 0"
        game.ganGame()
        
        for view in self.view.subviews{
            if let cardView = view as? CardView {
                cardView.text = ""
                cardView.alpha = 1.0
                cardView.show(false, animated: true, calback: nil)
            }
        }
        
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playMystic()
     
        self.view.backgroundColor = UIColor.blue
        
       // let bestScorForLabel = savedScores.returnBestScore()
        bestScoreLAbel.text = "Best Score: \(bestScoreForAlert)"
        scoreLabel.text = "Score: 0"
      
        game.ganGame()
        for r in 0..<rows {
            for c in 0..<cols {
                let cardView = CardView(frame: CGRect(x: r*90
                    + 14, y: c*134 + 80, width: 80, height: 120))
                
                cardView.tag = c * rows + r + 1
                cardView.delegate = self
                cardView.show(false, animated: false, calback: nil)
                
                view.addSubview(cardView)
            }
        }
    }
    
    
    //Mark: - CardViewDelegate
    func getCardString(index: Int) -> (String, () -> ()) {
        view.isUserInteractionEnabled = false
        let (value,second) = game.flipCars(index: index)
        return (value ?? "", {
            if second {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                   self.checkResult()
                }
            } else {
                self.view.isUserInteractionEnabled = true
            }
        })
    }

    
    //CheckResult of Pick
    func checkResult(){
        let (slor1,slot2) = self.game.getSlot()
        
        if let v1 = self.view.viewWithTag(slor1 + 1) as? CardView,
            let v2 = self.view.viewWithTag(slot2 + 1) as? CardView {
            let (mutch,gameOver) = self.game.match()
            if mutch {
                playCheering()
                print("Mutch")
                v1.dismiss() {}
                v2.dismiss() {
                    self.view.isUserInteractionEnabled = true
                    if gameOver {
                        self.playFake()
                        scores.append(self.game.score)
                        
                        bestScore = scores.reduce(scores[0]) {
                            if $0 < $1 {
                                return $0
                            } else {
                                return $1
                            }
                        }
                        
                        //save array and besgt score in memory
                        let defoults = UserDefaults.standard
                        defoults.set(scores, forKey: "score")
                        defoults.set(bestScore, forKey: "bestScore")
                        defoults.synchronize()

                        
                        
                        self.bestScoreLAbel.text = "Best Score: \(self.bestScoreForAlert)"

                        let alert = UIAlertController(title: "Game Over", message: "GameScore: \(self.game.score)n/ Best Score: \(self.bestScoreForAlert)", preferredStyle: .alert)
                        
                        let okHit = UIAlertAction(title: "OK", style: .default){(result : UIAlertAction) -> Void in
                            
                          
                            self.newGame()
                           
                    }
                        alert.addAction(okHit)
                        self.present(alert, animated: true, completion: nil)
                       
                    }
                }
                self.game.reset()
        } else {
                v1.text = ""
                v2.text = ""
                v1.show(false, animated: true, calback: nil)
                v2.show(false, animated: true, calback: {
                    self.view.isUserInteractionEnabled = true
                })
                self.game.reset()
            }
        } else {
            view.isUserInteractionEnabled = true
        }
        scoreLabel.text = "Score: \(self.game.score)"
    }
  
}





















































