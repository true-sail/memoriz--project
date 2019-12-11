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
 
    @IBOutlet weak var textViewQ: UITextView!
    
    @IBOutlet weak var textViewA: UITextView!
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        textViewQ.text = "問題"
        textViewQ.textColor = UIColor.lightGray
        textViewA.text = "解答"
        textViewA.textColor = UIColor.lightGray
        
        textViewQ.delegate = self
        textViewA.delegate = self
    
        // textViewQの枠線
        textViewQ.layer.borderWidth = 1
        textViewQ.layer.borderColor = UIColor.lightGray.cgColor
        textViewA.layer.borderWidth = 1
        textViewA.layer.borderColor = UIColor.lightGray.cgColor
       
    }

    // 作成ボタンを押した時にカードをRealmに追加するメソッド
    fileprivate func makeNewCards() {
        // Realmに接続
        let realm = try! Realm()
        
        // Realmデータベースファイルまでのパスを表示
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        // QとAをRealmに登録
        let card = Card() // インスタンス化(Cardクラスをもとに作成)
        card.Q = textViewQ.text
        card.A = textViewA.text
        //        card.date = Date() // Date() : 現在の日付を入れる
        
        // 現在あるidの最大値+1の値を取得(AutoIncrement)
        let id = (realm.objects(Card.self).max(ofProperty: "id") as Int? ?? 0) + 1
        card.id = id
        
        //Realmに新規カードを書き込む(追加)
        try! realm.write {
            realm.add(card)
        }
    }
    
    @IBAction func didClickButton(_ sender: UIButton) {
        
        // カードをRealmに追加
        makeNewCards()
                
        // 「登録しました」と表示してtextViewを空にする
        textViewQ.text = ""
        textViewA.text = ""
        
    }
  
    
//    // スイッチを押した時
//    @IBAction func didSwitchButton(_ sender: UISwitch) {
//        // オンの場合
//        if sender.isOn {
//            print("オンです")
//        } else {
//        // オフの場合
//            print("オフです")
//
//        }
//    }
    
  
    
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
