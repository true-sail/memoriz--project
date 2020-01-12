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

        self.view.backgroundColor = UIColor(red: 109/255, green: 185/255, blue: 208/255, alpha: 100)
                    
        // labelの色設定
        self.label.textColor = .white
        
        // 遅延処理
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            self.performSegue(withIdentifier: "toStart", sender: nil)
        }
        
    }
    
}
