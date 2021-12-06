//
//  ViewController.swift
//  A1 App Dev
//
//  Created by Dursun Satiroglu on 11/26/20.
//

import UIKit

//main game viewcontroller class
//handles the game screen
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //connect and set all outlets in view controller
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var highScoreTitle: UILabel!
    @IBOutlet weak var intHighScore: UILabel!
    
    
    @IBOutlet weak var player1Title: UILabel!
    @IBOutlet weak var turnsTitle: UILabel!
    @IBOutlet weak var scoreTitle: UILabel!
    
    @IBOutlet weak var intTurns: UILabel!
    @IBOutlet weak var intScore: UILabel!
    
    
    @IBOutlet weak var player2Title: UILabel!
    @IBOutlet weak var turnsTitle2: UILabel!
    @IBOutlet weak var scoreTitle2: UILabel!
    
    @IBOutlet weak var intTurns2: UILabel!
    @IBOutlet weak var intScore2: UILabel!
    
    
    
    //declare vars and constants
    
    //Switcher is the switch for the code to go into 2 modes. False =  player 1 and True = player 2
    var switcher: Bool?
    
    //deckar card array and model
    var arrayDeck = [Card]()
    var model = cardModel()
    
    //use first flippedIndex to check for the first flip
    var firstFlippedIndex: IndexPath?
    var seconds: Float?
    var timing: Timer?
    
    //turn and score counters
    var turns = 0
    var score = 0
    var turns2 = 0
    var score2 = 0
    
    //turn notifier
    var player1or2 = 1
    
    var highScore: Float?
    
    var lastWinner: Int?
    var losingScore: Int?

    var timeStarted = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //fill array with cards
        arrayDeck = model.getCards()
        
        //let collectionview be the delegate and source to the viewcontroller
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //If the user has picked play under "1 Player"
        //Set label texts, make texts needed for the case of 2 players invisible
        if switcher! == false {
            
            player1Title.text = "PLAYER 1"
            turnsTitle.text = "TURNS"
            scoreTitle.text = "SCORE"
            highScoreTitle.text = "BEST TIME"
            timerLabel.text = "TIME PLAYED: 0.00s"
            
            player2Title.text = ""
            turnsTitle2.text = ""
            scoreTitle2.text = ""
            intTurns2.text = ""
            intScore2.text = ""
        
            //if highscore is its default value dont record a high score
            if highScore == 10000.00{
                intHighScore.text = "00"}
            else{
                intHighScore.text = String(format: "%.2fs",highScore!)
            }
            
        }
        
        //If the user has picked play under "2 Player"
        //Set texts for labels
        if switcher == true {
            
        
            player1Title.text = "PLAYER 1"
            turnsTitle.text = "TURNS"
            scoreTitle.text = "SCORE"
            
            highScoreTitle.text = "LAST WINNER"
            timerLabel.text = "TIME PLAYED: 0.00s"
            
            player2Title.text = "PLAYER 2"
            turnsTitle2.text = "TURNS"
            scoreTitle2.text = "SCORE"
            
            //If there is no last winner (default value of optional is nil) do not display a last winner
            if lastWinner == nil{
                intHighScore.text =  "--"
            } else{
                intHighScore.text = "PLAYER \(lastWinner!)"
            }
    
        
            
        }
        //update score and turns to 0
        updateScoreTurns()
                
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    
    //Timers
    //set seconds to 0
    //call elapse() every 0.01 seconds and display this on timerLabel.text every 0.01 seconds
    //repeats set to true so this will keep happening
    func timer(){
        
        seconds = 0.00
        timing = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(elapse), userInfo: nil, repeats: true)
    
    }
    
    @objc func elapse(){
        
        seconds! += 0.01
        
        let sec = String(format: "%.2f", seconds!)
        
        timerLabel.text = "TIME PLAYED: \(sec)s"
        
    }

    //function to update scores and turns. scores/turns updated before every time this is called
    func updateScoreTurns(){
        
        if switcher == false{
            
            intTurns.text = String("\(turns)")
            intScore.text = String("\(score)")
            
        } else if switcher == true{
            
            intTurns.text = String("\(turns)")
            intScore.text = String("\(score)")
            
            intTurns2.text = String("\(turns2)")
            intScore2.text = String("\(score2)")
            
        }
       
     
        
    }

    
    //Return the number of cards in the deck as the no of cells in collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrayDeck.count
    }
    
    //fill the collection view cells with cards
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardCollectionViewCell
        
        //at each particular cell fill its corresponding card in the array
        let card = arrayDeck[indexPath.row]
        
        cell.setCard(card)
        
        return cell
        }
    
    //function that handles the bulk of the game
    //More explaination in method
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //This is done so the timer does not repeatedly get called
        if timeStarted == false{
            timer()
            timeStarted = true
        }
        //let "card" become the card the user has selected
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        let card = arrayDeck[indexPath.row]
        
        //When card is not flipped and not matched and selected, flip it and change its boolean value.
        if card.flipped == false && card.matched == false {
            
            cell.flip()
            card.flipped = true
            
            //firstFlippedIndex will be nil when is the first card selected per turn
            if firstFlippedIndex == nil{
                
                //Check which player's turn it is. And increment turn depending on this.
                //if statement used to decide which player's turn it is.
                if switcher == true{
                    
                    if turns > turns2{
                    
                        turns2 += 1
                        
                    } else{
                        
                        turns += 1
                    }
                
                    //if single player game just increment turn
                } else if switcher == false{
                    
                    turns += 1
                }
                    
                //update turns
                updateScoreTurns()
                
                //first flipped is the indexpath of the card
                firstFlippedIndex = indexPath
                
            }else{
                //second flip takes the index of the second card selected's index
                checkMatch(indexPath)
                
            }
        }
        
    }
            
    //method that checks matches with selected cards
    func checkMatch(_ secondFlippedIndex: IndexPath){
        
        
        let firstFlippedCell = collectionView.cellForItem(at: firstFlippedIndex!) as? CardCollectionViewCell
        let secondFlippedCell = collectionView.cellForItem(at: secondFlippedIndex) as? CardCollectionViewCell
            
        let cardOne = arrayDeck[firstFlippedIndex!.row]
        let cardTwo = arrayDeck[secondFlippedIndex.row]
            
        //if images name equal this is the checker for the right card
        if cardOne.image == cardTwo.image{
                
            //set to match and remove card indexes in the collection view
            cardOne.matched = true
            cardTwo.matched = true
            firstFlippedCell?.remove()
            secondFlippedCell?.remove()
            
            //add scores to corresponding turn holder
            if switcher == true{
            
                
                if player1or2 == 1{
                    score += 1
                }
                if player1or2 == 2{
                    score2 += 1
                    
                }

                
            } else if switcher == false{
                
                score += 1
            }
            
            //update
            updateScoreTurns()
            //after every flip check for victory
            victoryCheck()
            
        }//else used here if cards are not correctly matched
        else {
                
            cardOne.flipped = false
            cardTwo.flipped = false
                
            firstFlippedCell?.flipback()
            secondFlippedCell?.flipback()
            
        }
        if firstFlippedCell == nil{
            collectionView.reloadItems(at: [firstFlippedIndex!])
        }
       
        //use this for resetting to get ready for the first flip again
        firstFlippedIndex = nil
        
         //switch up player turns
        if player1or2 == 2{ player1or2 = 1
            
        }else{
            player1or2 = 2
        }

    }
    //fucntion that checks for victory by comparing scores, or whether all cards have been flipped.
    func victoryCheck(){
        
        var fin: Bool = true
        var title = "You've Won!"
        var message = ""
        
        //if there is a card with a matched property that is false break and continue
        for card in arrayDeck{
            
            if card.matched == false{
                fin = false;
                break
            }
        }
        
        //2 player vicotry is first to 8, calculate this
        if switcher == true && score2 == 8{
            fin = true
        }
        if switcher == true && score == 8{
            fin = true
        }
        
        
        //if single player, set highscore and create a alert notifying the user of their best
        if fin == true && switcher == false {
            
            if seconds! < highScore ?? 10_000{
                highScore = seconds!
                
                intHighScore.text = String(format: "%.2fs",highScore!)
            }
            
            if highScore == nil{
                highScore = 0
            }
            
            message = String(format: "Best Time: %.2fs",(highScore ?? 10_000))
            
            let messageFloat = (message as NSString).floatValue
            
            if messageFloat == 10_000{
                message = ""
            }
            
            timing?.invalidate()
            
            showAlert(title, message)
        
        }
        //if 2 player, record who wins last, and show this in an alert
        if fin == true && switcher == true{
            
            timing?.invalidate()
            
            if score >= 8 {
                lastWinner = 1
                losingScore = score2
                title = "PLAYER 1 WINS"
                message = "Player 1 reached 8 cards first"
            }
            if score2 >= 8 {
                lastWinner = 2
                losingScore = score
                title = "PLAYER 2 WINS"
                message = "Player 2 reached 8 cards first"
            }
            
            intHighScore.text = "PLAYER \(lastWinner ?? 00)"
            
            
            //alert method called with title and messsage set up
            showAlert(title, message)
        }
        
    }
    
    //Method to create an alert that shows the winner a message
    func showAlert(_ title : String, _ message : String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    


    
}
 
    



