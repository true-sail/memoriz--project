//
//  CategoryVC.swift
//  MemorizeProject
//
//  Created by 家田真帆 on 2019/12/11.
//  Copyright © 2019 家田真帆. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryVC: UIViewController {
    
    // カードの一覧を持つ配列
    var createdCards: [Card] = [] {
        // cardsが書き換えられた時に実行
        didSet {
            collectionView.reloadData()
        }
    }
    
    // 全カテゴリの配列
    var categories: [String] = [] {
        // cardsが書き換えられた時に実行
        didSet {
            collectionView.reloadData()
        }
    }
    
    // そのカテゴリのカードが何枚あるか数えるための変数
//    var cardCount = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navbarの色設定
        navigationController?.navigationBar.barTintColor = UIColor(red: 109/255, green: 185/255, blue: 208/255, alpha: 100)
        
        // おまじない
        collectionView.dataSource = self
        collectionView.delegate = self
    
    }
    
    // 画面を表示した時に毎回実行される
    override func viewWillAppear(_ animated: Bool) {
        
        // Realmに接続
        let realm = try! Realm()
        
        // realmからcardの一覧を取得
        // realm.objects(クラス名.self) : Realmから同じクラスの全データを取得
        createdCards = realm.objects(Card.self).reversed()
        
        for createdCard in createdCards {
            
            
            let category = createdCard.category
            
            if !categories.contains(category) {
                self.categories.append(category)
            }
        }
    }


}

extension CategoryVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // collectionViewに表示するセルの数
//        cards.count
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        // セルの取得
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        // セルの中のlabelをタグ番号で取得し、文字の設定をする。
        let label = cell.viewWithTag(1) as! UILabel
        
//        let numberLabel = cell.viewWithTag(2) as! UILabel
        
        let selectedCategory = categories[indexPath.row]
        
        label.text = selectedCategory
        
//        numberLabel.text = "全\(cardCount)枚"
        
        return cell
        
    }
    
    // collectionViewのcellがクリックされたときの処理
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedCategory = categories[indexPath.row]
        
        performSegue(withIdentifier: "toCard", sender: selectedCategory)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toCard" {
            
            let CardVC = segue.destination as! CardVC
            
            CardVC.selectedCategory = sender as! String
        }
    }
    
}


// コレクションビューのデザインを調整するための拡張
extension CategoryVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 画像の幅を取得
        let screenSize = self.view.bounds.width
        
        // 画面の幅の半分を計算
        let cellSize = screenSize / 2 - 5
        
        
        return CGSize(width: cellSize, height: cellSize)
    }
}
