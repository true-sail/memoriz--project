//
//  CardVC.swift
//  MemorizeProject
//
//  Created by 家田真帆 on 2019/12/22.
//  Copyright © 2019 家田真帆. All rights reserved.
//

import UIKit
import RealmSwift

class CardVC: UIViewController {
    
    // 飛んできたカテゴリを受け取る
    var selectedCategory = ""

    // 飛んできたカテゴリのカードのための箱
    var categorizedCards: [Card] = [] {
        // categorizedCardsが書き換えられた時に実行
        didSet {
            tableView.reloadData()
        }
    }
    
   
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // navbarの色設定
        navigationController?.navigationBar.barTintColor = UIColor(red: 109/255, green: 185/255, blue: 208/255, alpha: 100)
        
        // 画面の上の方にカテゴリを表示
        self.title = selectedCategory
        
        // おまじない
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    // 画面を表示した時に毎回実行される
    override func viewWillAppear(_ animated: Bool) {
          print(selectedCategory)
        
        // Realmに接続
        let realm = try! Realm()
        
        // realmから選択されたカテゴリのカードを取得
        let cards = realm.objects(Card.self).filter("category == '\(selectedCategory)'")
        
        // 配列results
        var results: [Card] = []
        
        // 配列resultsにcardを追加
        for card in cards {
            results.append(card)
        }
        
        // categorizedCardsにresultsを代入
        categorizedCards = results
    }

    // 左にスワイプしたらdeleteが出てくる
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         // 選択されたボタンがdeleteの場合
        if editingStyle == .delete {
           // Realmに接続する
            let realm = try! Realm()
            
            // 該当のタスクをRealmから削除
            // indexPath.row： 今回スワイプしたやつの情報
           let categorizedCard = categorizedCards[indexPath.row]
            
            try! realm.write {
                realm.delete(categorizedCard)
            }
            // todos配列から削除
            // indexPathのrow番目を削除
            categorizedCards.remove(at: indexPath.row)
        }
    }
}

extension CardVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorizedCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // セルの取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let categorizedCard = categorizedCards[indexPath.row]
        cell.textLabel?.text = categorizedCard.Q
        
        // セルに矢印をつける
        cell.accessoryType = .disclosureIndicator
        
        return cell
        
    }
    
    // セルを選択したときの処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let editCard = categorizedCards[indexPath.row]
        
        performSegue(withIdentifier: "toEdit", sender: editCard)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toEdit" {
            
            let MakeCardsVC = segue.destination as! MakeCardsVC
            
            MakeCardsVC.editCard = sender as? Card        }
    }
}
