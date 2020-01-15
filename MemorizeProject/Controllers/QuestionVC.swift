//
//  QuestionVC.swift
//  MemorizeProject
//
//  Created by 家田真帆 on 2020/01/14.
//  Copyright © 2020 家田真帆. All rights reserved.
//

import UIKit

class QuestionVC: UIViewController {
        var studyCards: [Card] = []
        
        @IBOutlet weak var label: UILabel!
        
        @IBOutlet weak var button: UIButton!
        
        var QNumber:Int = 0
        var i:Int = 0
        
        override func viewDidLoad() {
            super.viewDidLoad()
        
            // navbarの色設定
            navigationController?.navigationBar.barTintColor = UIColor(red: 109/255, green: 185/255, blue: 208/255, alpha: 100)
            
            self.title = "問題"
            print(studyCards)
            print(i)
            let question = studyCards[i].Q
            label.text = "\(question)"
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
            
            performSegue(withIdentifier: "toAnswer", sender: studyCards)
        
        }
        
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toAnswer" {
            
            let AnswerVC = segue.destination as! AnswerVC
                
                AnswerVC.i = self.i
                AnswerVC.studyCards = sender as! [Card]
            }
        }
    }
