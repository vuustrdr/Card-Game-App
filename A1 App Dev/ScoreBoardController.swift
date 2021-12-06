//
//  ScoreBoardController.swift
//  A1 App Dev
//
//  Created by Dursun Satiroglu on 12/4/20.
//

import UIKit

//class that holds a table of scores. Can be single or multiplayer scores.
//depending on segue used, switcher will be false or true
class ScoreBoardController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    //used to detect which scores to use
    var switcher:Bool?
    
    //connect outlets and delcare vars
    @IBOutlet weak var table: UITableView!
    
    //this value is achieved from the Origional view controller segue
    var scoresArray = [Float]()
    var twoScoreArray = [String]()
    var winner:Int?
    
    //function to set num of rows of table.
    //this rows depends on number of items in array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if switcher == false{
            
            if scoresArray.count > 18{
                return 18
                
            }else{
                
                return scoresArray.count
                
            }
        }
        
        if switcher == true{
            
            if twoScoreArray.count > 18{
                return 18
                
            }else{
                
                return twoScoreArray.count
                
            }
            
        }
        
        return 0
    }
    
    //function to set table contents depending on which segue was used
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "tableCell")
        
        if switcher == false{
            cell.textLabel!.text = String(format:"(\(indexPath.row)) G.A - Score:  %.2fs",  (scoresArray[indexPath.row]))
        }
        
        if switcher == true{
            
            
            cell.textLabel!.text = "(\(indexPath.row))Games Ago - \(twoScoreArray[indexPath.row])"
        
        }
        
        return cell
    }
    
    
}
