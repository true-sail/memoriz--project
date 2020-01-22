//
//  ResultVC.swift
//  MemorizeProject
//
//  Created by 家田真帆 on 2020/01/14.
//  Copyright © 2020 家田真帆. All rights reserved.
//

import UIKit

class ResultVC: UIViewController {
    
    // AnswerVCから受け取る
    var categorizedCards: [Card] = []

    // AnswerVCから受け取る
    var studyCards: [Card] = []
    
    // AnswerVCとResultVCから受け取る
    var retryCards: [Card] = []

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sheetLabel: UILabel!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet weak var result1Label: UILabel!
    @IBOutlet weak var result2Label: UILabel!
    @IBOutlet weak var result3Label: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // nuvbaritemを消す
         self.navigationItem.setHidesBackButton(true, animated:true);
        
       
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
        
        result1Label.text = "\(studyCards.count)"
        result2Label.text = "\(studyCards.count - retryCards.count)"
        result3Label.text = "\(retryCards.count)"
        
        // 「復習」か「もう一度」か
        if retryCards.count == 0 {
            button1.setTitle("もう一度", for: .normal)
        } else {
            button1.setTitle("復習", for: .normal)
        }
        
        // ボタンの文字の色
        button1.tintColor = .white
        button2.tintColor = .white
       
        // 角丸設定
        button1.layer.cornerRadius = 10.0
        button2.layer.cornerRadius = 10.0
     
        // 背景色
        button1.backgroundColor = UIColor(red: 77/255, green: 147/255, blue: 182/255, alpha: 100)
        button2.backgroundColor = UIColor(red: 77/255, green: 147/255, blue: 182/255, alpha: 100)
     
        // 影の設定
        button1.layer.shadowOpacity = 0.16
        button2.layer.shadowOpacity = 0.16
        button1.layer.shadowRadius = 2.0
        button2.layer.shadowRadius = 2.0
        button1.layer.shadowColor = UIColor.black.cgColor
        button2.layer.shadowColor = UIColor.black.cgColor
        button1.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        button2.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        button1.layer.borderWidth = 2.0
        button2.layer.borderWidth = 2.0
        button1.layer.borderColor = UIColor.clear.cgColor
        button2.layer.borderColor = UIColor.clear.cgColor
        
    }
    

    
    @IBAction func didClickRetryButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "returnToQuestion", sender: retryCards)
    }
    

    @IBAction func didClickReturnButton(_ sender: UIButton) {
    
        performSegue(withIdentifier: "returnToCard", sender: categorizedCards)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // retryするとき
        if segue.identifier == "returnToQuestion" {
            let QuestionVC = segue.destination as! QuestionVC
            
            QuestionVC.retryCards = sender as! [Card]
            QuestionVC.studyCards = studyCards
       
        }
        
        // 最初の画面(CardVC)に戻る時
        if segue.identifier == "returnToCard" {

                    let CardVC = segue.destination as! CardVC

                    CardVC.categorizedCards = sender as! [Card]
                    CardVC.selectedCategory = studyCards[0].category
        }
    }
}
