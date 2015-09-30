//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Eunice Park on 9/9/15.
//  Copyright (c) 2015 Eunice Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var activePlayer = 1
    var gameActive = true
    var cellOccupied = 0
    var gameState = [0,0,0,0,0,0,0,0,0]
    var winningCombinations = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[2,4,6],[0,4,8]]
    
    var image = UIImage()
    
    @IBOutlet weak var gameOverLabel: UILabel!
    
    @IBOutlet weak var playAgainButton: UIButton!
    
    // PlayAgain Button pressed - reset board, remove images on buttons & remove gameOverLabel & playAgainButton
    @IBAction func playAgain(sender: AnyObject) {
        activePlayer = 1
        gameActive = true
        gameState = [0,0,0,0,0,0,0,0,0]
        cellOccupied = 0
        
        // Remove images on 9 buttons - ensure tags on each button are from 0-8.  anything other than
        // that are not cell buttons and will cause 'could not cast value of UIView to UIButton' error
        var button: UIButton
        // check the type of obj using as? UIButton before changing image
        for var i = 1; i <= 9; i++ {
            //println(view.viewWithTag(i)!.tag)
            if let button = view.viewWithTag(i) as? UIButton {
                //println(button.tag)
                button.setImage(nil, forState: .Normal)
            }
        }
        
        // Remove gameOverLabel & playAgainButton
        gameOverLabel.hidden = true
        playAgainButton.hidden = true
        
        gameOverLabel.text = ""
        
        gameOverLabel.center = CGPointMake(gameOverLabel.center.x - 400, gameOverLabel.center.y)
        playAgainButton.center = CGPointMake(playAgainButton.center.x - 400, playAgainButton.center.y)
    }
    
    @IBOutlet weak var button: UIButton!
    
    @IBAction func buttonPressed(sender: AnyObject) {
        var gameOverMessage = ""
        var idx = sender.tag - 1
        
        if gameActive == true && gameState[idx] == 0 {
            //println(idx)
            
            gameState[idx] = activePlayer
            
            if activePlayer == 1 {
                image = UIImage(named: "Cross.png")!
                activePlayer = 2
                cellOccupied++
            } else {
                image = UIImage(named: "nought.png")!
                activePlayer = 1
                cellOccupied++
            }
            
            sender.setImage(image, forState: .Normal)

            // Determine if game won
            for combination in winningCombinations {
                
                if  gameState[combination[0]] != 0 &&
                    gameState[combination[0]] == gameState[combination[1]] &&
                    gameState[combination[1]] == gameState[combination[2]] {
                        
                     gameActive = false
                        
                    if gameState[combination[0]] == 1 {
                        gameOverMessage = "Cross has won!"
                    } else {
                        gameOverMessage = "Nought has won!"
                    }
                } else {
                    if cellOccupied == 9 {
                        gameActive = false
                        gameOverMessage = "It's a tie!"
                    }
                }
            }
            // If either game won or all tied
            if !gameActive {
                gameOverLabel.text = gameOverMessage
                
                // Animate: Move gameOverLabel & button back to original place
                gameOverLabel.hidden = false
                playAgainButton.hidden = false
                
                self.gameOverLabel.center = CGPointMake(self.gameOverLabel.center.x + 400, self.gameOverLabel.center.y)
                self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x + 400, self.playAgainButton.center.y)
            }
            
        }
    }
    
    // Initially hide the gameOverLabel & Play Again button.  Move these out to the left for animation when game over
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameOverLabel.hidden = true
        playAgainButton.hidden = true
        
        gameOverLabel.text = ""
        
        gameOverLabel.center = CGPointMake(gameOverLabel.center.x - 400, gameOverLabel.center.y)
        playAgainButton.center = CGPointMake(playAgainButton.center.x - 400, playAgainButton.center.y)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

