//
//  Card.swift
//  MemorizeProject
//
//  Created by 家田真帆 on 2019/12/11.
//  Copyright © 2019 家田真帆. All rights reserved.
//

import Foundation
import RealmSwift

class Card: Object {
    // データを管理するテーブルの作成

    // 各カードのID
    @objc dynamic var id: Int = 0

    // カードの問題
    @objc dynamic var Q: String = ""

    // カードの解答
    @objc dynamic var A: String = ""
    
    // カードのカテゴリ
    @objc dynamic var category: String = ""

    // カードの作成日
    @objc dynamic var date: Date = Date()

}

struct Card2 {
    
    let Q : String
    
    let A : String
    
    let category : String
    
    let documentId : String
}
