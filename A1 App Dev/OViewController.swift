//
//  OViewController.swift
//  A1 App Dev
//
//  Created by Dursun Satiroglu on 12/3/20.
//Student ID: 201458316
//

import UIKit

//home screen for the game.
//Has 4 segues that, 2 of which go to the same screen. However the segues carry different values such as "switcher" and others that suit the type of score the user wishes to see
class OViewController: UIViewController{
    
    //set up vars and outlets
    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var play2: UIButton!
    @IBOutlet weak var lastWinnerLabel: UILabel!
    
    //some arbitrary big number will be used for "highscore" to set new ones. Usually when this value is detected, a ridculous number will be generated or a 0.
    var highScore: Float?
    var hSMessage: String?
    var lWMessage: String?
    
    var score = [Float]()
    
    var scoreArray:Array = [Float]()
    
    var twoScoreArray:Array = [String]()
    
    var lastWinner: Int?
    
    var losingScore: Int?
    

    
    //function that passes data to all different view controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //used to save the high score and display it on the view controller high score title
        if segue.identifier == "segue1"{
            let ViewController = segue.destination as! ViewController
            
            ViewController.switcher = false
            
            ViewController.highScore = highScore ?? 10_000
            
        }
        //used to display the last winner on the view controller in an instance of a 2 player game
        if segue.identifier == "segue2"{
            let ViewController = segue.destination as! ViewController
            
            ViewController.switcher = true
            
            ViewController.lastWinner = lastWinner ?? nil
        }
        
        //used to show scores for 1 player based on times
        if segue.identifier == "segueSinglePlayerTable"{
            let ScoreBoard = segue.destination as! ScoreBoardController
            
            ScoreBoard.switcher = false
            
            ScoreBoard.scoresArray = scoreArray
            
            
        }
        
        //scores for 2 players based on score
        if segue.identifier == "segueTwoPlayerTable"{
            let ScoreBoard = segue.destination as! ScoreBoardController
            
            ScoreBoard.switcher = true
            
            ScoreBoard.twoScoreArray = twoScoreArray
            
            ScoreBoard.winner = lastWinner
            
            
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHighScore()
        
    }
    
    //unwind segue function to get data passed back to original
    @IBAction func unwindToOriginal(_ unwindSegue: UIStoryboardSegue) {
        
        //set view controller as source
        if let ViewController = unwindSegue.source as? ViewController{
            
            //if false, so if player is 1 set high score on screen
            if ViewController.switcher == false{
                highScore = ViewController.highScore
        
                scoreArray.insert(ViewController.seconds ?? 10_000 , at: 0)
                
                setHighScore()
            }
            
            //if true, set last winner on screen
            if ViewController.switcher == true{
                var lastLoss = 1
                
                lastWinner = ViewController.lastWinner
                losingScore = ViewController.losingScore
                
                if lastWinner == 1{
                    lastLoss = 2

                    
                } else{
                    lastLoss = 1
                    
                }
                twoScoreArray.insert("W:  Player\(lastWinner ?? 0): 8 || L: Player\(lastLoss): \( losingScore ?? 0)", at: 0)
                
                setLastWinner()
                
            }

        }
        
         
        
        // Use data from the view controller which initiated the unwind segue
    }
    
    //simple functions to set the high score or last winner on the main screen.
    func setHighScore(){
        //use some arbitrary big number.
        if ((highScore) == 10_000) {
            hSMessage = "BEST TIME: 59856235s"
        } else{
            hSMessage = String(format: "BEST TIME: %.2fs",(highScore ?? 00))
        }
        
        highScoreLabel.text = hSMessage!
    }
    
    func setLastWinner(){
        
        if lastWinner == nil {
            lWMessage = "LAST WINNER: --"
        }
        else{
            lWMessage = "LAST WINNER: PLAYER \(lastWinner ?? 0)"
        }
        
        lastWinnerLabel.text = lWMessage!
    }

}
