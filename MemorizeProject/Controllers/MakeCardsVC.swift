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
import Firebase
import UserNotifications

class MakeCardsVC: UIViewController {

    // 編集する時に飛んでくる値を受け取る
    var editCard: Card? = nil
    
    // 追加する時に飛んでくる値を受け取る
    var selectedCategory: String = ""
    
    // 通知に使う
    var cardID = 0
    
    // alertに表示するmessage
    var alertMessage = ""
    var alertTitle = ""
    
    
    @IBOutlet weak var textViewQ: UITextView!
    
    @IBOutlet weak var textViewA: UITextView!
   
    @IBOutlet weak var textField: UITextField!

    @IBOutlet weak var notificationSwitch: UISwitch!
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // navbarの色設定
        navigationController?.navigationBar.barTintColor = UIColor(red: 109/255, green: 185/255, blue: 208/255, alpha: 100)
        
        // navbarの文字色
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        // tabbarの色設定
        tabBarController?.tabBar.barTintColor = UIColor(red: 109/255, green: 185/255, blue: 208/255, alpha: 100)
        
        // おまじない
        textViewQ.delegate = self
        textViewA.delegate = self
        textField.delegate = self

    
        // textViewQの枠線
        textViewQ.layer.borderWidth = 1
        textViewQ.layer.borderColor = UIColor.lightGray.cgColor
        
        // textViewAの枠線
        textViewA.layer.borderWidth = 1
        textViewA.layer.borderColor = UIColor.lightGray.cgColor
        
        // 大文字で始まらないようにする
        textViewQ.autocapitalizationType = UITextAutocapitalizationType.none
        textViewA.autocapitalizationType = UITextAutocapitalizationType.none
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        
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
        
        // 変数editCardがnilでなければ、textViewQ, textViewA, textFieldに文字を表示
        if let e = editCard {
            // nilでない場合（編集の場合）
            
            // navbarのタイトル
            navigationItem.title = "編集画面"
                
            // アラートのtitle設定
            alertTitle = "編集"
            
            // 編集内容を表示
            textViewQ.text = e.Q
            textViewA.text = e.A
            textField.text = e.category
            didCheckSwitch = e.notification
            if didCheckSwitch == true {
                notificationSwitch.isOn = true
            } else {
                notificationSwitch.isOn = false
            }
            
            
            button.setTitle("変更", for: .normal)
            
        } else {
            // nilの場合（作成の場合）
            
            // navbarのタイトル
            navigationItem.title = "作成画面"

            // アラートのtitle設定
            alertTitle = "作成"

            // textViewQ,textViewAにplaceholderを表示
            textViewQ.text = "問題"
            textViewQ.textColor = UIColor.lightGray
            textViewA.text = "解答"
            textViewA.textColor = UIColor.lightGray
            
            if selectedCategory != "" {
                textField.text = selectedCategory
            }
            
//            didCheckSwitch =
            
            // buttonの文字を「作成」にする
            button.setTitle("作成", for: .normal)
        }
        

    }
    
    
    func setTabBarItem(index: Int, titile: String, image: UIImage, selectedImage: UIImage,  offColor: UIColor, onColor: UIColor) -> Void {
        
        let tabBarItem = self.tabBarController?.tabBar.items![index]
        tabBarItem!.title = titile
        tabBarItem!.image = image.withRenderingMode(.alwaysOriginal)
        tabBarItem!.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
        tabBarItem!.setTitleTextAttributes([ .foregroundColor : offColor], for: .normal)
        tabBarItem!.setTitleTextAttributes([ .foregroundColor : onColor], for: .selected)
    }
        
    // カードを編集するためのメソッド
    fileprivate func updateCard(newQ: String, newA: String, newCategory: String, newNotification: Bool, createdCard: Card) {
        
        let realm = try! Realm()
        
        try! realm.write {
            createdCard.Q = newQ
            createdCard.A = newA
            createdCard.category = newCategory
            createdCard.notification = newNotification
        }
        
    }

    // 作成ボタンを押した時にカードをRealmに追加するメソッド
    fileprivate func makeNewCards(_ inputQ: String, _ inputA: String, _ inputCategory: String, inputNotification: Bool) -> Int {
        
        // Realmに接続
        let realm = try! Realm()
        
        // Realmデータベースファイルまでのパスを表示
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        print("-------------------------------------------------")
        
        // QとAをRealmに登録
        let createdCard = Card()
        
        // インスタンス化(Cardクラスをもとに作成)
        createdCard.Q = inputQ
        createdCard.A = inputA
        createdCard.category = inputCategory
        createdCard.notification = inputNotification
//        createdCard.notification = didCheckSwitch
        createdCard.date = Date() // Date() : 現在の日付を入れる
        
        // 現在あるidの最大値+1の値を取得(AutoIncrement)
        let id = (realm.objects(Card.self).max(ofProperty: "id") as Int? ?? 0) + 1
        createdCard.id = id
        
        //
        
        //Realmに新規カードを書き込む(追加)
        try! realm.write {
            realm.add(createdCard)
        }
        
        return createdCard.id
    }
    

// ----ダウンロード機能 ここから----
//    // スイッチを押した時
//    @IBAction func didSwitchButton(_ sender: UISwitch) {
//
//        if sender.isOn {
//        // オンの場合
//            didCheckSwitch = true
//            print("オンです")
//        } else {
//        // オフの場合
//            didCheckSwitch = false
//            print("オフです")
//        }
//
//    }
// ----ダウンロード機能　ここまで----
    
    // スイッチを切り替えた時
    @IBAction func didSwitchButton(_ sender: UISwitch) {
        // オンの場合
        if sender.isOn {
            didCheckSwitch = true
            print("オンです")
//            createdCard
        } else {  // オフの場合
            // アラートの画面作成
            let alert = UIAlertController(title: "覚える機会が減るよ！", message: "それでも通知オフにしますか？", preferredStyle: .alert)
            let noAction = UIAlertAction(title: "いいえ", style: .destructive , handler:{
            (action: UIAlertAction!) -> Void in
               
                if #available(iOS 10.0, *) {
                    // スイッチをオンに戻す
                    sender.isOn = true
                    didCheckSwitch = true
                    
                } else {
                    // スイッチをオンに戻す
                    sender.isOn = true
                    didCheckSwitch = true
                }
            })
            // yesボタンの作成
            let yesAction = UIAlertAction(title: "はい", style: .default, handler:{
            (action: UIAlertAction!) -> Void in
                
                didCheckSwitch = false
                print("通知オフです")
            })
            
            // alertにnoボタンを追加
            alert.addAction(noAction)
            // alertにyesボタンを追加
            alert.addAction(yesAction)
            // アラートを表示
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    // ボタンを押した時
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
        
        // textViewQ, textViewA, textFieldに何も入力されていない場合
        if textViewQ.textColor != .black || textViewA.textColor != .black || inputCategory.isEmpty {
        
            // 入力を促すアラート
            let alert = UIAlertController(title:  "空欄を入力して下さい", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            }
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            return
            }
        
        if let c = editCard {
            // 変数editCardがnilでない場合
            // 更新する場合
            updateCard(newQ: inputQ, newA: inputA, newCategory: inputCategory, newNotification: didCheckSwitch, createdCard: c)
            
            let selectedCategory = editCard?.category
            
            // CardVCに戻る
            performSegue(withIdentifier: "backToCard", sender: selectedCategory)
            
        } else {
            // 変数cardがnilの場合
            // 新規作成の場合
            cardID = makeNewCards(inputQ, inputA, inputCategory, inputNotification: didCheckSwitch)
        }
        // スイッチがオンの時、通知を設定
        if didCheckSwitch {
            
            print("created")
                // 通知の作成
                let notificationContent = UNMutableNotificationContent()

                // 通知のタイトルに問題を設定
                notificationContent.title = inputQ
                // 通知の本文に答えを設定
                notificationContent.body = inputA

                // 通知音にデフォルト音声を設定
                notificationContent.sound = .default
              
                let trigger: UNNotificationTrigger
     
                // 時間の設定
                trigger = UNTimeIntervalNotificationTrigger(timeInterval: 43200, repeats: true)

//                let uuid = NSUUID().uuidString
                let request = UNNotificationRequest(identifier: "\(cardID)", content: notificationContent, trigger: trigger)
            
                // 通知を登録
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
                UNUserNotificationCenter.current().getPendingNotificationRequests{requests in
                print(requests)
                }
            
            
                // アラートのメッセージ
                alertMessage = "12時間ごとに通知されます。"
                
        } else {
            
                // スイッチがオフの時、通知設定を削除
                // 通知をnotification.requestのIDで消す
                let center = UNUserNotificationCenter.current()
                center.getPendingNotificationRequests { requests in
                let identifiers = requests
                        .filter { $0.identifier == "\(self.cardID)"}
                        .map { $0.identifier }
                center.removePendingNotificationRequests(withIdentifiers: identifiers)
                }
            
                // アラートのメッセージ
                alertMessage = ""
                
        }
        
// ----ダウンロード機能　ここから----
//        // スイッチがオンの状態の時、databaseに接続
//        if didCheckSwitch == true {
//
//            // firebaseに接続
//            let db = Firestore.firestore()
//
//            db.collection("cards").addDocument(data: ["Q": textViewQ.text!, "A": textViewA.text!, "category": textField.text!, "createdAt": FieldValue.serverTimestamp()
//            ]) { error in
//                if let err = error {
//                    // エラーが発生した場合、エラー情報を表示
//                    print("エラーーーーーーーーー")
//                    print(err.localizedDescription)
//                } else {
//                    // エラーがない場合
//                    print("シェアしました")
//                }
//            }
//
//        }
//
//        // スイッチがオンかどうか
//        if didCheckSwitch == true {
//            self.alertMessage = "カードをシェアしました"
//        } else {
//            self.alertMessage = ""
//        }
// ----ダウンロード機能 ここまで----

        // アラートの画面作成
        let alert = UIAlertController(title: "カード\(alertTitle)完了！", message: "\(alertMessage)", preferredStyle: .alert)

        // okボタンの作成
        let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
        }

        // alertにokボタンを追加
        alert.addAction(okAction)

        // アラートを表示
        present(alert, animated: true, completion: nil)
        
        
        // textViewを最初の状態に戻す
        textViewQ.text = "問題"
        textViewQ.textColor = UIColor.lightGray
        textViewA.text = "解答"
        textViewA.textColor = UIColor.lightGray
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "backToCard" {
            
            
            let CardVC = segue.destination as! CardVC
            
            CardVC.selectedCategory = sender as! String
        }
    }
    
}

// placeholderを使えるように拡張
extension MakeCardsVC: UITextViewDelegate, UITextFieldDelegate {
    
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
        
    // textView文字制限
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    
        let currentText = textView.text ?? ""

        guard let stringRange = Range(range, in: currentText) else { return false }

        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)

        return updatedText.count <= 96
    }
    
    // textField文字制限
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
            let currentText = textField.text ?? ""

            guard let stringRange = Range(range, in: currentText) else { return false }

            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

            return updatedText.count <= 8
    }
    
}





