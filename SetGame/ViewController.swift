//
//  ViewController.swift
//  SetGame
//
//  Created by Genuine on 1/5/19.
//  Copyright © 2019 Genuine. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    var game = SetGame()
    
    let shapes = ["▲","■","●"]
    let colors = [#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1),#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)]
    let quantities = [1,2,3]
    
    var titles = [NSAttributedString]()
    var titleForModel = [[String]]()
    var titlesDictionary = [(key: [String], value: NSAttributedString)]()
    var selectedTitles = [[String]]()
    var titlesInGame = [(key: [String], value: NSAttributedString)]()
    var selectedButtons = [UIButton]()
    func randomCharsForTitle () {
        for char1 in shapes {
            for char2 in colors {
                for char3 in quantities {
                    var string = ""
                    for _ in 1...char3 {
                        string.append(char1)
                        // string.append("\n")//new line
                    }
                    let fillingsAtributes : [String : [NSAttributedString.Key : Any]] = [
                        "filled" : [.strokeWidth : -2.0 ,
                                    .foregroundColor : char2.withAlphaComponent(1)],
                        "striped" : [.foregroundColor : char2.withAlphaComponent(0.15)],
                        "outline" : [.strokeWidth : 2.0 ,
                                     .foregroundColor : char2.withAlphaComponent(1)]]
                    
                    for attribute in fillingsAtributes.keys {
                        var title = [String]()
                        title.append(attribute)
                        title.append(char1)
                        title.append(String(char3))
                        title.append(char2.description)
                        titleForModel.append(title)
                    }
                    
                    for attribute in fillingsAtributes.values {
                        let title = (NSAttributedString(string: string, attributes: attribute))
                        titles.append(title)
                        
                    }
                }
            }
        }
        let titlesSum = zip(titleForModel.map{$0},titles.map{$0})
        titlesDictionary = Dictionary(uniqueKeysWithValues: titlesSum).shuffled()
    }
    
    
    @IBOutlet var cardButtons: [UIButton]!
    
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        let selectedCardIndex = cardButtons.index(of: sender)
        let titleFinish = titlesInGame[selectedCardIndex!]
        selectedTitles.append(titleFinish.key)
        selectedButtons.append(cardButtons[selectedCardIndex!])
        print(titleFinish)
       
        if !game.cardsInGame[selectedCardIndex!].cardSelected && game.selectedCards.count < 3{
            sender.layer.borderWidth = 3.0
            sender.layer.borderColor = UIColor.blue.cgColor
            game.cardsInGame[selectedCardIndex!].cardSelected = true
            game.selectedCards.append(game.cardsInGame[selectedCardIndex!])
            
        } else if game.cardsInGame[selectedCardIndex!].cardSelected {
            sender.layer.borderWidth = 0.0
            sender.layer.borderColor = UIColor.white.cgColor
            game.cardsInGame[selectedCardIndex!].cardSelected = false
            game.selectedCards.remove(at: game.selectedCards.index(of: game.cardsInGame[selectedCardIndex!])!)
        }
        if game.selectedCards.count == 3 && game.tryToMatch(selectedTitles: selectedTitles) {
            
                for button in selectedButtons {
                button.layer.borderWidth = 3.0
                button.layer.borderColor = UIColor.red.cgColor
                }
            
         
        }
    }

    
    @IBAction func deal3MoreCards(_ sender: UIButton) {
        for i in 0...2 {
            titlesInGame.append(titlesDictionary[i])
            
        }
        for i in 0...2 {
            titlesDictionary.remove(at: i)
        }
      //  game.dealing3MoreCards(deck: &game.deckOfCards, cardsIn: &game.cardsInGame)
       print(titlesInGame.count)
        
        print(titlesDictionary.count)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomCharsForTitle()
        for button in cardButtons {
            button.layer.cornerRadius = 8.0
            if cardButtons.index(of: button)! >= 12 {
            button.isHidden = true
            }
        if cardButtons.index(of: button)! < 12 {
            let titleFinish = titlesDictionary.remove(at: cardButtons.index(of:button)! )
            titlesInGame.append(titleFinish)
            button.setAttributedTitle(titleFinish.value , for: UIControl.State.normal)
            }
        }
        
        
        // print(titles)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

