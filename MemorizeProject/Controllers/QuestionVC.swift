//
//  QuestionVC.swift
//  MemorizeProject
//
//  Created by 家田真帆 on 2020/01/14.
//  Copyright © 2020 家田真帆. All rights reserved.
//

import UIKit

class QuestionVC: UIViewController {
    
        // CardVCから受け取る
        var categorizedCards: [Card] = []
    
        // CardVCとAnswerVCから受け取る
        var studyCards: [Card] = []
    
//        // AnswerVCから受け取る
//        var studyCards: [Card] = []
        // AnswerVCとResultVCから受け取る
        var retryCards: [Card] = []
    
        
        @IBOutlet weak var label: UILabel!
        
        @IBOutlet weak var button: UIButton!
        
//        // 問題数
//        var QNums:Int = 0
        // 問題番号 - 1
        var QNum:Int = 0
        
        override func viewDidLoad() {
            super.viewDidLoad()
        
            // navbarの色設定
            navigationController?.navigationBar.barTintColor = UIColor(red: 109/255, green: 185/255, blue: 208/255, alpha: 100)
            
            // nuvbaritemを消す
            self.navigationItem.setHidesBackButton(true, animated:true);
            
            // navbarのタイトル
            navigationItem.title = "問題\(QNum + 1)"
            
          
            let question = studyCards[QNum].Q
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
                
                AnswerVC.QNum = self.QNum
                AnswerVC.studyCards = sender as! [Card]
                AnswerVC.retryCards = retryCards
                AnswerVC.categorizedCards = categorizedCards
            }
        }
    }
