//
//  OtherVC.swift
//  MemorizeProject
//
//  Created by 家田真帆 on 2020/01/20.
//  Copyright © 2020 家田真帆. All rights reserved.
//

import UIKit
import StoreKit
import Accounts
import MessageUI


var sections = [String]()
var othersArray = [[String]]()
var header = ""
var selectedCell = ""

class OtherVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // navbarの色設定
             navigationController?.navigationBar.barTintColor = UIColor(red: 109/255, green: 185/255, blue: 208/255, alpha: 100)
        
        // おまじない
        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        
        // navbarの文字色
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        // navbarのタイトル
        navigationItem.title = "その他"

        // tableViewのグループ化
//        sections = ["設定", "その他"]
//        for _ in 0 ... 1 {
//            othersArray.append([])
//        }
                
        sections = ["その他"]
//        othersArray[0] = ["通知間隔を設定する"]
//        othersArray[1] = ["アプリを評価する", "アプリを教える", "ご意見はこちら"]
        othersArray.append(["アプリを評価する", "アプリを教える", "ご意見はこちら"])

        
       
    }

        
}

extension OtherVC: UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return othersArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = othersArray[indexPath.section][indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        header = sections[indexPath.section]
        selectedCell = othersArray[indexPath.section][indexPath.row]
        
        if selectedCell == "通知間隔を設定する" {
            
            
        
        } else if selectedCell == "アプリを評価する" {
            // レビューページへ遷移
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
            } else {
                
                if let url = URL(string: "itms-apps://itunes.apple.com/app/id1495997508?action=write-review") {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:])
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }
        } else if selectedCell == "アプリを教える" {
            
            // 共有する項目
            let shareText = "memorizé(メモリゼ)で効率よく覚えよう！"
            let shareWebsite = NSURL(string: "https://apps.apple.com/jp/app/memoriz%C3%A9-%E3%83%8A%E3%83%9E%E3%82%B1%E3%83%A2%E3%83%8E%E3%81%AB%E3%82%82%E6%9A%97%E8%A8%98%E3%82%A2%E3%83%97%E3%83%AA/id1495997508")!
            
            let activityItems = [shareText, shareWebsite] as [Any]
            
            // 初期化処理
            let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)

            // 使用しないアクティビティタイプ
            let excludedActivityTypes = [
                UIActivity.ActivityType.saveToCameraRoll,
                UIActivity.ActivityType.print
            ]

            activityVC.excludedActivityTypes = excludedActivityTypes

            // UIActivityViewControllerを表示
            self.present(activityVC, animated: true, completion: nil)
        } else if selectedCell == "ご意見はこちら" {
            let mailComposeViewController = configureMailController()
            if MFMailComposeViewController.canSendMail() {
                self.present(mailComposeViewController, animated: true, completion: nil)
            } else {
                showMailError()
            }
        }
        

        tableView.deselectRow(at: indexPath, animated: true)
        
        }

        
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return sections[section]
        }
    
        func configureMailController() -> MFMailComposeViewController {
            let mailComposerVC = MFMailComposeViewController()
            mailComposerVC.mailComposeDelegate = self
            mailComposerVC.setToRecipients(["idts4869@gmail.com"])
            mailComposerVC.setSubject("memorizéに関するご意見・ご要望")
            mailComposerVC.setMessageBody("ここにご意見・ご要望を入力し、メールを送信して下さい。", isHTML: false)
            
            return mailComposerVC
        }
    
        func showMailError() {
            let sendMailErrorAlert = UIAlertController(title: "メールを送信できません", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            sendMailErrorAlert.addAction(okAction)
            self.present(sendMailErrorAlert, animated: true, completion: nil)
        }
    
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true, completion: nil)
        }
    

    
}
