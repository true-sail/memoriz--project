//
//  ResultVC.swift
//  MemorizeProject
//
//  Created by 家田真帆 on 2020/01/14.
//  Copyright © 2020 家田真帆. All rights reserved.
//

import UIKit

class ResultVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sheetLabel: UILabel!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet weak var result1Label: UILabel!
    @IBOutlet weak var result2Label: UILabel!
    @IBOutlet weak var result3Label: UILabel!
    
    var studyCards: [Card] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("================")
        print(studyCards)
        print("================")
        titleLabel.backgroundColor = UIColor(red: 57/255, green: 101/255, blue: 152/255, alpha: 100)
        
        sheetLabel.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 100)
        
        label1.textColor = UIColor(red: 48/255, green: 79/255, blue: 121/255, alpha: 100)
        label2.textColor = UIColor(red: 48/255, green: 79/255, blue: 121/255, alpha: 100)
        label3.textColor = UIColor(red: 48/255, green: 79/255, blue: 121/255, alpha: 100)
        label3.font = UIFont.boldSystemFont(ofSize: 20)
        
        result1Label.textColor = UIColor(red: 48/255, green: 79/255, blue: 121/255, alpha: 100)
        result2Label.textColor = UIColor(red: 48/255, green: 79/255, blue: 121/255, alpha: 100)
        result3Label.textColor = UIColor(red: 48/255, green: 79/255, blue: 121/255, alpha: 100)
        result3Label.font = UIFont.boldSystemFont(ofSize: 20)
        
//        result1Label.text = ""
//        result1Labe2.text = ""
//        result1Labe3.text = ""
        
    }
    

    
    @IBAction func didClickRetryButton(_ sender: UIButton) {
        performSegue(withIdentifier: "returnToQuestion", sender: studyCards)
//        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didClickReturnButton(_ sender: UIButton) {
               
//        performSegue(withIdentifier: "returnToCard", sender: studyCards)
        let cardVC = self.storyboard?.instantiateViewController(withIdentifier: "CardVC") as! CardVC
        cardVC.categorizedCards = studyCards
        cardVC.selectedCategory = studyCards[0].category
        self.present(cardVC, animated: true, completion: nil)

   

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "returnToQuestion" {
            let QuestionVC = segue.destination as! QuestionVC

            QuestionVC.studyCards = sender as! [Card]
        }
        if segue.identifier == "returnToCard" {

                    let CardVC = segue.destination as! CardVC

                    CardVC.categorizedCards = sender as! [Card]
                    CardVC.selectedCategory = studyCards[0].category
        }
    }
}
