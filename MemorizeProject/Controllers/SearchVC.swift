//
//  SearchVC.swift
//  MemorizeProject
//
//  Created by 家田真帆 on 2019/12/11.
//  Copyright © 2019 家田真帆. All rights reserved.
//

import UIKit
import Firebase

class SearchVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    
    // データが入っている配列
    var cards: [Card2] = [] {
        didSet {
            // 値が書き換わったら、tableViewを更新する
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navbarの色設定
        navigationController?.navigationBar.barTintColor = UIColor(red: 109/255, green: 185/255, blue: 208/255, alpha: 100)
        
        // おまじない
        tableView.delegate = self
        tableView.dataSource = self
      
        print("-------------------------")
        print(cards)
        
        let db = Firestore.firestore()
        
        db.collection("cards").order(by: "createdAt", descending: true).addSnapshotListener {
            (querySnapshot, error) in
            
                // 最新のcardコレクションの中身（ドキュメント）を取得
                guard let documents = querySnapshot?.documents else {
                    // cardsコレクションの中身がnilの場合、処理を中断
                    return
                    }
                
                // 結果を入れる配列
                var results: [Card2] = []
                
                // ドキュメントをfor文を使ってループする
                for document in documents {
                    let Q = document.get("Q") as! String
                    let A = document.get("A") as! String
                    let category = document.get("category") as! String
                    let card = Card2(Q: Q, A: A, category: category, documentId: document.documentID)
                    
                    // 配列cardsにcardを追加
                    results.append(card)
                }
                
                // テーブルに表示する変数cardsを全結果の入ったresultsで上書き
                self.cards = results
            
            }
        
    }

}



extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // セルを取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let card = cards[indexPath.row]
        
        cell.textLabel?.text = card.Q
        
        
        return cell
    }
    
    
    
    
    
}
