//
//  SplashVC.swift
//  MemorizeProject
//
//  Created by 家田真帆 on 2020/01/10.
//  Copyright © 2020 家田真帆. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        UILabel.animate(
            withDuration: 2.5, // splashの時間
//            delay: 0.0, // 画面表示から何秒後に実行するか
        animations: { // アニメーションの設定
        
                        // 背景の色設定
            self.view.backgroundColor = UIColor(red: 109/255, green: 185/255, blue: 208/255, alpha: 100)
                        
                        // labelの色設定
            self.label.textColor = .white
            
        }) {(Bool) in
            // アニメーション完了後の処理
            self.performSegue(withIdentifier: "toStart", sender: nil)
        }


    }
}
