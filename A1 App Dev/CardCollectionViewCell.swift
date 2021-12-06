//
//  CardCollectionViewCell.swift
//  A1 App Dev
//
//  Created by Dursun Satiroglu on 11/26/20.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    //set up outlets and vars
    @IBOutlet weak var front: UIImageView!
    
    @IBOutlet weak var back: UIImageView!
    
    var card: Card?
    

    //function to set a card's properties, image, alpha, flipped or not...
    func setCard(_ card:Card){
        
        self.card = card;
        
        front.image = UIImage(named: card.image)
        
        if card.matched == true {
            front.alpha = 0
            back.alpha = 0
            
            return
        } else{
            
            front.alpha = 1
            back.alpha = 1
        }
        //if flipped is true flip back in a styled way
        if card.flipped == true {
            
            UIView.transition(from: back, to: front, duration: 0.2, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
            
        }
        //if flipped is true flip it in a styled way
        else{
            
            UIView.transition(from: front, to: back, duration: 0.2, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
            
        }
    }
    //function to control the flip when called this will flip from card back to front.
    func flip(){
        
        UIView.transition(from: back, to: front, duration: 0.2, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        
    }
    
    //reverse of flip
    func flipback(){
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            UIView.transition(from: self.front, to: self.back, duration: 0.2, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
    }
    
    //this will remove the card image but not the selectable cell
    func remove(){
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut) {
            self.front.alpha = 0
        }

    }
    
    
    
}
