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
    
    var number = 1
    
    var category = ""
    
//    var categoryNums: [Int] = []   // delete
    
    var categoryNum: Int = 0
    
    // カードの一覧を持つ配列
    var createdCards: [Card] = [] {
        // cardsが書き換えられた時に実行
        didSet {
            collectionView.reloadData()
        }
    }
    
    // 全カテゴリの配列                 // delete
    var categories: [String] = [] {
        // cardsが書き換えられた時に実行
        didSet {
            collectionView.reloadData()
        }
    }
    
    // CategoryVCから受け取る
    var categoryNums: Dictionary<String, Int> = [:]
    
    // 飛んできたカテゴリのカードのための箱
       var categorizedCards: [Card] = [] {
           // categorizedCardsが書き換えられた時に実行
           didSet {
               collectionView.reloadData()
           }
       }
    
    
    @IBOutlet weak var collectionView: UICollectionView!


    override func viewDidLoad() {
        super.viewDidLoad()

        
        // 最初に表示される画面を作成画面にする
        self.tabBarController?.selectedIndex = 1
        

        // navbarの文字色
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        // navbarのタイトル
        navigationItem.title = "カテゴリ"
        
        // navbarの色設定
        navigationController?.navigationBar.barTintColor = UIColor(red: 109/255, green: 185/255, blue: 208/255, alpha: 100)
        
        // おまじない
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setUpCollectionViewLayout()
        
    }
    
    // 画面を表示した時に毎回実行される
    override func viewWillAppear(_ animated: Bool) {
        
        // Realmに接続
        let realm = try! Realm()
        
        // realmからcardの一覧を取得
        // realm.objects(クラス名.self) : Realmから同じクラスの全データを取得
        createdCards = realm.objects(Card.self).reversed()
        
        var categoryResults: [String] = []
        var categoryNumsResults: Dictionary<String, Int> = [:]
        for createdCard in createdCards {

            category = createdCard.category
            
            // カテゴリがまだない時
            if (categoryNumsResults.index(forKey: category) == nil) {
                categoryNumsResults[category] = 1
                categoryResults.append(category)
            } else {  // カテゴリがすでにある時
                categoryNumsResults[category]! += 1
            }
            
            self.categories = categoryResults
            self.categoryNums = categoryNumsResults
            print("sasasa\(categoryNums)")
        }
        
        
    }

}

extension CategoryVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // collectionViewに表示するセルの数
//        cards.count
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        // セルの取得
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        // セルの丸角
        cell.layer.cornerRadius = 20
        
        // セルの中のlabelをタグ番号で取得し、文字の設定をする。
        let categoryLabel = cell.viewWithTag(1) as! UILabel
        
        let selectedCategory = categories[indexPath.row]
        
        // カードが0枚になったらのそのカテゴリを消す。
        if categoryNums[selectedCategory] == 0 {
            categories.remove(at: categoryNum)
        }
        
        categoryLabel.text = selectedCategory
        
        categoryLabel.textColor = UIColor(red: 57/255, green: 88/255, blue: 124/255, alpha: 100)
        
        // categoryLabel位置設定
        categoryLabel.frame = CGRect(x: 0, y: 8, width: 100, height: 100);
        
        let numberLabel = cell.viewWithTag(2) as! UILabel
        
        numberLabel.text = "全\(categoryNums[selectedCategory]!)件"
        
        numberLabel.textColor = .darkGray
        
        // numberLabel位置設定
        numberLabel.frame = CGRect(x: 240, y: 8, width: 100, height: 100);
        
        // cellの影
        cell.contentView.layer.cornerRadius = 2.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 0.16
        cell.layer.masksToBounds = false

        
        
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

           // 画像の幅を取得
           let screenWidth = self.view.bounds.width
           let screenHeight = self.view.bounds.height

           // 画面の幅の半分を計算
           let width = screenWidth - 80
           let height = screenHeight / 8

           return CGSize(width: width, height: height)

    }
    
    func setUpCollectionViewLayout() {
        // collectionViewのcellサイズと余白の設定
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 40
        layout.sectionInset = UIEdgeInsets(top: 50, left: 40, bottom: 0, right: 40)
        collectionView.collectionViewLayout = layout
    }

}




   


//extension CategoryVC {
//    func setUpCollectionViewLayout() {
//        // collectionViewのcellサイズと余白の設定
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 40
//        layout.sectionInset = UIEdgeInsets(top: 50, left: 40, bottom: 0, right: 40)
//        collectionView.collectionViewLayout = layout
//    }
//}


