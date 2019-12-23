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
    var categorizedCards: [String] = [] {
        // categorizedCardsが書き換えられた時に実行
        didSet {
            tableView.reloadData()
        }
    }

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        for card in cards {
            categorizedCards.append(card.Q)
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
        cell.textLabel?.text = categorizedCard
        
        return cell
        
    }
    
    
}
