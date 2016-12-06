//
//  CardView.swift
//  Emoji Your Memory
//
//  Created by Nika on 12/1/16.
//  Copyright © 2016 Nika. All rights reserved.
//

import UIKit
import AVFoundation

protocol CardViewDelegate {
    func getCardString(index: Int) -> (String, ()->())
}

//Display a Card
class CardView: UILabel {
    
    fileprivate var avSoundPlayer : AVAudioPlayer?
    fileprivate let dingSound = Bundle.main.url(forResource: "Click2-Sebastian-759472264", withExtension: "wav")!
       
    
    
    func playClick() {
        avSoundPlayer = try? AVAudioPlayer(contentsOf: dingSound)
        avSoundPlayer?.prepareToPlay()
        avSoundPlayer?.currentTime = 0
        avSoundPlayer?.play()
        
    }
        
    var delegate : CardViewDelegate?
    
//Generate Color
    func randomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    //Set up the view properies
    //set up tab gesture recognizer
    fileprivate func setUp() {
        self.text = "🎠"
        self.backgroundColor = UIColor.purple
        self.font = UIFont.systemFont(ofSize: 60)
        self.textAlignment = .center
        self.isUserInteractionEnabled = true
        
        //Call the cardHit Function when view is tapped
        let tap = UITapGestureRecognizer(target: self, action: #selector(CardView.cardHit(_:)))
   self.addGestureRecognizer(tap)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    
    //Calld when card tapped
    func cardHit(_ recognizer: UITapGestureRecognizer ) {
        
        playClick()
        if let index = recognizer.view?.tag, let (value,callback) = delegate?.getCardString(index: index - 1){
            show(true,animated:true){
                self.text = value
                callback()
            }
        }
        
    }
    
    // Show/Hide the View 
    func show(_ show: Bool, animated: Bool, calback:(()->())?){
        UIView.animate(withDuration: animated ? 0.5 : 0.0,
                       animations: {
            if show {
            self.layer.transform = CATransform3DIdentity
            } else {
                let transform = CATransform3DMakeRotation(CGFloat(M_PI), 0, 1, 0)
                self.layer.transform = transform
               // print("Transform")
                    }
        }, completion: {finished in
            self.text = "🎠"
            calback?()
            
        })
    }
    
    //Dismiss card view
    func dismiss(_ callback:@escaping ()->()) {
        UIView.animate(withDuration: 0.5,
                       animations: {
            self.alpha = 0
            
        }, completion: { finished in
            
            callback()
        })
    }
    
}

