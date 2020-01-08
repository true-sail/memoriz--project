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
    var sharedCards: [Card2] = [] {
        didSet {
            // 値が書き換わったら、tableViewを更新する
            tableView.reloadData()
        }
    }
    
    var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navbarの色設定
        navigationController?.navigationBar.barTintColor = UIColor(red: 109/255, green: 185/255, blue: 208/255, alpha: 100)
        
        // おまじない
        tableView.delegate = self
        tableView.dataSource = self
        
        // searchBarを表示
        setupSearchBar()
        
        searchBar.delegate = self
    }
    
        func setupSearchBar() {
             
             // navigationBarFrameがnilでない場合
            if let navigationBarFrame = navigationController?.navigationBar.bounds {
                 
                let searchBar: UISearchBar = UISearchBar(frame: navigationBarFrame)
                 
    //             searchBar.delegate = self as? UISearchBarDelegate
                 
                // searchBarにplaceholderを設定
                searchBar.placeholder = "検索"
    
                
                // 入力された文字の一文字目が大文字にならないようにする
                searchBar.autocapitalizationType = UITextAutocapitalizationType.none
                
                searchBar.keyboardType = UIKeyboardType.default
                
                // navigationItemのtitleViewにsearchBarを設置
                navigationItem.titleView = searchBar
                
    //            navigationItem.titleView?.frame = searchBar.frame
                 
                self.searchBar = searchBar
                
                // 画面が表示された時にすでにsearchBarにカーソルが置かれた状態にする
                searchBar.becomeFirstResponder()
                
            }
            
        }
    
}


extension SearchVC: UISearchBarDelegate {
    
    // searchBarの編集が始まった時の処理
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    // searchBarのcancelボタンが押された時の処理
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    
    // searchBarの検索ボタンが押された時の処理
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        print(searchBar.text!)
        
        // firebaseに接続
        let db = Firestore.firestore()

        
        print(searchBar.text!)
        // 前方一致でデータを取得する
        db.collection("cards")
            .order(by: "Q")
            .start(at: [searchBar.text!])
            .end(at: [searchBar.text! + "{f8ff}"])
            .getDocuments { ( querySnapshot, error) in

            // docsがnilの場合
            guard let docs = querySnapshot?.documents else {
                //処理を中止
                return
            }

            // 空の箱
            var searchResults: [Card2] = []

            for doc in docs {
                let id = doc.documentID
                let Q = doc.get("Q") as! String
                let A = doc.get("A") as! String
                let category = doc.get("category") as! String

                let sharedCard = Card2(Q: Q, A: A, category: category, documentId: id)

                searchResults.append(sharedCard)
                
            }

            self.sharedCards = searchResults

        }
        
    }

}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sharedCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // セルを取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let card = sharedCards[indexPath.row]
        
        cell.textLabel?.text = card.Q
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // クリックされたセルの情報を取得
        let card = sharedCards[indexPath.row]
        
        // セルの選択状態(グレーになるやつを解除)
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 画面遷移
        performSegue(withIdentifier: "toDownload", sender: card)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "toDownload" {
            let DownloadVC = segue.destination as! DownloadVC
            
            DownloadVC.selectedCard = sender as? Card2
        }
    }
    
    
}


