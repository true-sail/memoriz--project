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

var others = ["ご意見はこちら"]

class OtherVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // navbarの色設定
             navigationController?.navigationBar.barTintColor = UIColor(red: 109/255, green: 185/255, blue: 208/255, alpha: 100)
        
        // おまじない
        tableView.delegate = self
        tableView.dataSource = self
       
        
        // navbarの文字色
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        // navbarのタイトル
        navigationItem.title = "その他"


    }

        
}
extension OtherVC: UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        others.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = others[indexPath.row]
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let other = others[indexPath.row]
        
        if other == "ご意見はこちら" {
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
            
            return "その他"
        }
    
        func configureMailController() -> MFMailComposeViewController {
            let mailComposerVC = MFMailComposeViewController()
            mailComposerVC.mailComposeDelegate = self
            mailComposerVC.setToRecipients(["idts4869@gmail.com"])
            mailComposerVC.setSubject("memorizéに関するご意見")
            mailComposerVC.setMessageBody("ここにご意見を入力し、メールを送信して下さい。", isHTML: false)
            
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
