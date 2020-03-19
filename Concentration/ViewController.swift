//
//  ViewController.swift
//  Concentration
//
//  Created by 严愉程 on 2019/4/5.
//  Copyright © 2019 严愉程. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game: Concentration = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    // lazy means meachine will initialize it until someone try to use it
    
    var flipcount: Int = 0 {
        didSet{//every time this value change this function will be excuted
            flipcountLabel.text = "Flips: \(flipcount)"
        }
    }
    
    @IBOutlet weak var flipcountLabel: UILabel!

    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton){
        flipcount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else {
            print("choosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["👻","🎃","😺","👽","🤡","😈","🤖","🤒"]
    var emoji = [Int: String]() //字典
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count - 1)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
}
