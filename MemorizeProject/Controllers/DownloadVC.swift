//
//  ShareVC.swift
//  MemorizeProject
//
//  Created by 家田真帆 on 2019/12/31.
//  Copyright © 2019 家田真帆. All rights reserved.
//

import UIKit
import RealmSwift

class DownloadVC: UIViewController {
    
    var selectedCard: Card2? = nil

    @IBOutlet weak var textViewQ: UITextView!
    
    @IBOutlet weak var textViewA: UITextView!
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navbarの色設定
        navigationController?.navigationBar.barTintColor = UIColor(red: 109/255, green: 185/255, blue: 208/255, alpha: 100)

        // textViewQの枠線
        textViewQ.layer.borderWidth = 1
        textViewQ.layer.borderColor = UIColor.lightGray.cgColor
        
        // textViewAの枠線
        textViewA.layer.borderWidth = 1
        textViewA.layer.borderColor = UIColor.lightGray.cgColor
        
        // firebaseの選択したデータを反映
        textViewQ.text = selectedCard?.Q
        textViewA.text = selectedCard?.A
        label.text = selectedCard?.category
        
    }
    

    @IBAction func didClickButton(_ sender: UIButton) {
        
        // Realmに接続
        let realm = try! Realm()
        
        // Realmデータベースファイルまでのパスを表示
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        print("-------------------------------------------------")
        
        // QとAをRealmに登録
        let downloadCard = Card()
        
        // インスタンス化(Cardクラスをもとに作成)
        downloadCard.Q = selectedCard!.Q
        downloadCard.A = selectedCard!.A
        downloadCard.category = selectedCard!.category
        downloadCard.date = Date() // Date() : 現在の日付を入れる
        
        // 現在あるidの最大値+1の値を取得(AutoIncrement)
        let id = (realm.objects(Card.self).max(ofProperty: "id") as Int? ?? 0) + 1
        downloadCard.id = id
        
        //Realmに新規カードを書き込む(追加)
        try! realm.write {
            realm.add(downloadCard)
        }
        
        // アラート画面を作成
        let alert = UIAlertController(title: "ダウンロード完了！", message: "カテゴリ「\(downloadCard.category)」に追加されました", preferredStyle: .alert)
        
        // okボタンを作成
        let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            print("okが押されました")
        }
        
        // アラートにokボタンを追加
        alert.addAction(okAction)
        
        // アラートを表示
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
}

    

