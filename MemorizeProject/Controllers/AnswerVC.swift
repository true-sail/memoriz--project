//
//  AnswerVC.swift
//  MemorizeProject
//
//  Created by 家田真帆 on 2020/01/13.
//  Copyright © 2020 家田真帆. All rights reserved.
//

import UIKit

class AnswerVC: UIViewController {

    // QuestionVCから受け取る
    var studyCards: [Card] = []
    var QNum: Int = 0  // 問題番号 - 1
    var retryCards: [Card] = []
    var categorizedCards: [Card] = []
    
        
    @IBOutlet weak var label: UILabel!
    
    
    @IBOutlet weak var buttonR: UIButton!
    @IBOutlet weak var buttonL: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // nuvbaritemを消す
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        // navbarのタイトル
        navigationItem.title = "解答\(QNum + 1)"
        
        let answer = studyCards[QNum].A
        label.text = "\(answer)"
        label.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 100)
        
        // ボタンの文字の色
        buttonR.tintColor = .white
        buttonL.tintColor = .white
        
        // 角丸設定
        buttonR.layer.cornerRadius = 10.0
        buttonL.layer.cornerRadius = 10.0
        // 背景色
        buttonR.backgroundColor = UIColor(red: 77/255, green: 147/255, blue: 182/255, alpha: 100)
        buttonL.backgroundColor = UIColor(red: 145/255, green: 145/255, blue: 145/255, alpha: 100)
      
        // 影の設定
        buttonR.layer.shadowOpacity = 0.16
        buttonL.layer.shadowOpacity = 0.16
        buttonR.layer.shadowRadius = 2.0
        buttonL.layer.shadowRadius = 2.0
        buttonR.layer.shadowColor = UIColor.black.cgColor
        buttonL.layer.shadowColor = UIColor.black.cgColor
        buttonR.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        buttonL.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        buttonR.layer.borderWidth = 2.0
        buttonL.layer.borderWidth = 2.0
        buttonR.layer.borderColor = UIColor.clear.cgColor
        buttonL.layer.borderColor = UIColor.clear.cgColor
        
                
                
    }
    
//    @IBAction func didClickButton(_ sender: UIButton) {
//
//        let QNumbers = studyCards.count
//
//        if i! < QNumbers - 1 {
//            i! += 1
//            performSegue(withIdentifier: "backToQuestion", sender: i)
//             } else {
//                 performSegue(withIdentifier: "toResult", sender: studyCards)
//             }
//    }
    

    // 余裕ボタンを押した時の処理
    @IBAction func didClickButtonR(_ sender: UIButton) {
        
        let QNums = studyCards.count
       
        if QNum < QNums - 1 {
                QNum += 1
                performSegue(withIdentifier: "backToQuestion", sender: QNum)
            } else {
               performSegue(withIdentifier: "toResult", sender: studyCards)
            }
    }
    
    // 難しいボタンを押した時の処理
    @IBAction func didClickButtonL(_ sender: UIButton) {
    
//        let QNums = studyCards.count

        retryCards.append(studyCards[QNum])
       
        if QNum < studyCards.count - 1 {
            QNum += 1
            performSegue(withIdentifier: "backToQuestion", sender: QNum)
           } else {
            performSegue(withIdentifier: "toResult", sender: studyCards)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToQuestion" {
            let QuestionVC = segue.destination as! QuestionVC
            QuestionVC.QNum = sender as! Int
            QuestionVC.studyCards = studyCards
            QuestionVC.retryCards = retryCards
        }
        
        if segue.identifier == "toResult" {
            let ResultVC = segue.destination as! ResultVC
            ResultVC.studyCards = studyCards
            ResultVC.retryCards = retryCards
            ResultVC.categorizedCards = categorizedCards
        }
    }
    

}




