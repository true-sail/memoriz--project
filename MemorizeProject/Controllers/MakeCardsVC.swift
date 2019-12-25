//
//  MakeCardsVC.swift
//  MemorizeProject
//
//  Created by 家田真帆 on 2019/12/10.
//  Copyright © 2019 家田真帆. All rights reserved.
//

import UIKit
// 読み込み
import RealmSwift

class MakeCardsVC: UIViewController {
    
    // 編集する時に飛んでくる値を受け取る
    var editCard: Card? = nil
 
    @IBOutlet weak var textViewQ: UITextView!
    
    @IBOutlet weak var textViewA: UITextView!
   
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // navbarの色設定
        navigationController?.navigationBar.barTintColor = UIColor(red: 109/255, green: 185/255, blue: 208/255, alpha: 100)
        
        // おまじない
        textViewQ.delegate = self
        textViewA.delegate = self
    
        // textViewQの枠線
        textViewQ.layer.borderWidth = 1
        textViewQ.layer.borderColor = UIColor.lightGray.cgColor
        
        // textViewAの枠線
        textViewA.layer.borderWidth = 1
        textViewA.layer.borderColor = UIColor.lightGray.cgColor
        
        // 変数editCardがnilでなければ、textViewQ, textViewA, textFieldに文字を表示
        if let e = editCard {
            // nilの場合（編集の場合）
            // 編集内容を表示
            textViewQ.text = e.Q
            textViewA.text = e.A
            textField.text = e.category
            button.setTitle("変更", for: .normal)
            
        } else {
            // nilでない場合（作成の場合）
            // textViewQ,textViewAにplaceholderを表示
            textViewQ.text = "問題"
            textViewQ.textColor = UIColor.lightGray
            textViewA.text = "解答"
            textViewA.textColor = UIColor.lightGray
            
            // buttonの文字を「作成」にする
            button.setTitle("作成", for: .normal)
        }
        
    }
    
    // カードを編集するためのメソッド
    fileprivate func updateCard(newQ: String, newA: String, newCategory: String, createdCard: Card) {
        let realm = try! Realm()
        try! realm.write {
            createdCard.Q = newQ
            createdCard.A = newA
            createdCard.category = newCategory
        }
    }

    // 作成ボタンを押した時にカードをRealmに追加するメソッド
    fileprivate func makeNewCards(_ inputQ: String, _ inputA: String, _ inputCategory: String) {
        
        // Realmに接続
        let realm = try! Realm()
        
        // Realmデータベースファイルまでのパスを表示
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        print("-------------------------------------------------")
        
        // QとAをRealmに登録
        var createdCard = Card()
        
        // インスタンス化(Cardクラスをもとに作成)
        createdCard.Q = inputQ
        createdCard.A = inputA
        createdCard.category = inputCategory
        createdCard.date = Date() // Date() : 現在の日付を入れる
        
        // 現在あるidの最大値+1の値を取得(AutoIncrement)
        let id = (realm.objects(Card.self).max(ofProperty: "id") as Int? ?? 0) + 1
        createdCard.id = id
        
        //Realmに新規カードを書き込む(追加)
        try! realm.write {
            realm.add(createdCard)
        }
    }
    
    
    @IBAction func didClickButton(_ sender: UIButton) {
        
        // textViewQがnilの場合
        guard let inputQ = textViewQ.text else {
            // return:このメソッド(didClickButton)を中断する
            return
        }
        
        // textViewQが空の場合
        if inputQ.isEmpty {
            return
        }
        
        // textViewAがnilの場合
        guard let inputA = textViewA.text else {
            return
        }
        
        // textViewAが空の場合
        if inputA.isEmpty {
            return
        }
        
        // textFieldがnilの場合
        guard let inputCategory = textField.text else {
            return
        }
        
        // inputCategoryが空の場合
        if inputCategory.isEmpty {
            return
        }
        
        if let c = editCard {
            // 変数cardがnilでない場合
            // 更新する場合
            updateCard(newQ: inputQ, newA: inputA, newCategory: inputCategory, createdCard: c)
        } else {
            // 変数cardがnilの場合
            // 新規作成の場合
            makeNewCards(inputQ, inputA, inputCategory)
        }
        
        textViewQ.text = "問題"
        textViewQ.textColor = UIColor.lightGray
        textViewA.text = "解答"
        textViewA.textColor = UIColor.lightGray
    }
    
    
    // スイッチを押した時
    @IBAction func didSwitchButton(_ sender: UISwitch) {
    
        if sender.isOn {
        // オンの場合
            didCheckSwitch = true
            print("オンです")
        } else {
        // オフの場合
            didCheckSwitch = false
            print("オフです")

        }
    }
    
  
    
}

// placeholderを使えるように拡張
extension MakeCardsVC: UITextViewDelegate {
    
    // textViewを編集し始めた時のメソッド
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView == textViewQ {
            // textViewの文字がlightGrayの時
             if textViewQ.textColor == UIColor.lightGray {
                // textViewの文字をnilにする
                 textViewQ.text = nil
                // 文字を黒にする
                 textViewQ.textColor = UIColor.black
             }
        }
        
        if textView == textViewA {
            // textViewAの文字がlightGrayの時
            if textViewA.textColor == UIColor.lightGray {
                // textViewの文字をnilにする
                textViewA.text = nil
                // 文字を黒にする
                textViewA.textColor = UIColor.black
            }
        }
     }
    
    // textViewを編集し終えた時のメソッド
     func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView == textViewQ {
            // textViewQの文字が空の場合
            if textViewQ.text.isEmpty {
            // textViewの文字を設定
             textViewQ.text = "問題"
            // 文字をlightGrayに変更
             textViewQ.textColor = UIColor.lightGray
            }
        }
        
        if textView == textViewA {
            // textViewAの文字が空の場合
            if textViewA.text.isEmpty {
            // textViewの文字を設定
            textViewA.text = "解答"
            // 文字をlightGrayに変更
            textViewA.textColor = UIColor.lightGray
            }
        }
    }
    

    
}
