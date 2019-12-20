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
    var cards: [Card] = []
//    var cards: String = ""
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        //デリゲート先を自分に設定する。
        //searchBar.delegate = self
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
