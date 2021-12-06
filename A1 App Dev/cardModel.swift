//
//  Card.swift
//  A1 App Dev
//
//  Created by Dursun Satiroglu on 11/26/20.
//

import Foundation

//class to form a deck of cards
class cardModel{
    
    //function to create a deck of cards. Returns a deck
    func getCards() -> [Card]{
        
        //declare a array of cards (deck)
        var deck = [Card]()
        
        var ran : UInt32
        var oldran : UInt32?
        
        //create 30 cards, each is a pair of another
        for _ in 1...15{
            
            ran = arc4random_uniform(52)+1
            
            //used to prevent the same card being generated twice in a row
            while ran == oldran {ran = arc4random_uniform(52)+1}
            
            print(ran)
            
            //copy function
            let pair1 = Card()
            pair1.image = "card\(ran)"
    
            let pair2 = Card()
            pair2.image = "card\(ran)"
            
            deck.append(pair1)
            deck.append(pair2)
            
            oldran = ran
            
        }
        //shuffle up deck to make it harder
        deck.shuffle()
    
        return deck
    }
}
