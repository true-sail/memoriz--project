//
//  AnswerVC.swift
//  MemorizeProject
//
//  Created by 家田真帆 on 2020/01/13.
//  Copyright © 2020 家田真帆. All rights reserved.
//

import UIKit

class AnswerVC: UIViewController {

    var studyCards: [Card] = []
    var i: Int? = nil
        
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "答え"
        
        let answer = studyCards[i!].A
        label.text = "\(answer)"
        label.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 100)
        
        // ボタンの文字の色
        button.tintColor = .white
        
        // 角丸設定
        button.layer.cornerRadius = 10.0
      
        // 背景色
        button.backgroundColor = UIColor(red: 77/255, green: 147/255, blue: 182/255, alpha: 100)
      
        // 影の設定
        button.layer.shadowOpacity = 0.16
        button.layer.shadowRadius = 2.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.clear.cgColor
        
                
                
    }
    
    @IBAction func didClickButton(_ sender: UIButton) {
        
        let QNumbers = studyCards.count
        
        if i! < QNumbers - 1 {
            i! += 1
            performSegue(withIdentifier: "backToQuestion", sender: i)
             } else {
                 performSegue(withIdentifier: "toResult", sender: studyCards)
             }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToQuestion" {
            let QuestionVC = segue.destination as! QuestionVC
            QuestionVC.i = sender as! Int
            QuestionVC.studyCards = studyCards
        }
        
        if segue.identifier == "toResult" {
            let ResultVC = segue.destination as! ResultVC
            ResultVC.studyCards = studyCards
        }
    }
    

}




