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
    
    // CategoryVCから受け取る
    var selectedCategory = ""

    // categoryVCから受け取る
    var categorizedCards: [Card] = [] {
        // categorizedCardsが書き換えられた時に実行
        didSet {
            if (tableView != nil) {
                tableView.reloadData()
            }
        }
    }
    
    // CategoryVCから受け取る
    var studyCards: [Card] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // navbarの色設定
        navigationController?.navigationBar.barTintColor = UIColor(red: 109/255, green: 185/255, blue: 208/255, alpha: 100)
        
        // navbarのタイトル
        navigationItem.title = selectedCategory
        
        // naigationBarの色設定
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        // おまじない
        tableView.delegate = self
        tableView.dataSource = self
        
        // buttonの文字の色
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

    // 追加ボタンを押した時の処理
    @IBAction func didClickAddButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toMain", sender: selectedCategory)
        
    }
    // 学習ボタンを押した時の処理
    @IBAction func didClickStartButton(_ sender: UIButton) {
        
        // 勉強するカードをランダムに選択
        if 10 <= categorizedCards.count {
            
            for _ in 0...9 {
                
                let i = Int(arc4random_uniform(UInt32(categorizedCards.count)))
                studyCards.append(categorizedCards[i])
                categorizedCards.remove(at: i)  // 重複をなくすために消す
            }
            
        } else {
            studyCards = categorizedCards
        }
                

//        let studyCards = categorizedCards
        
        performSegue(withIdentifier: "toStudy", sender: studyCards)
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
            
            MakeCardsVC.editCard = sender as? Card
            
        }
        
        if segue.identifier == "toMain" {
            
            let MakeCardsVC = segue.destination as! MakeCardsVC
            
            MakeCardsVC.selectedCategory = sender as! String
            
        }
        
        
        if segue.identifier == "toStudy" {
            let QuestionVC = segue.destination as! QuestionVC
            QuestionVC.studyCards = sender as! [Card]
            QuestionVC.categorizedCards = categorizedCards
        }
    }
}
