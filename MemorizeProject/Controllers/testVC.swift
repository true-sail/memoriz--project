//
//  testVC.swift
//  MemorizeProject
//
//  Created by 家田真帆 on 2020/01/22.
//  Copyright © 2020 家田真帆. All rights reserved.
//

import UIKit

//class testVC: UIViewController {
//
//     @IBOutlet weak var tableView: UITableView!
//
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            // navbarの色設定
//                 navigationController?.navigationBar.barTintColor = UIColor(red: 109/255, green: 185/255, blue: 208/255, alpha: 100)
//
//            // おまじない
//            tableView.delegate = self
//            tableView.dataSource = self
//
//            // navbarの文字色
//            self.navigationController?.navigationBar.titleTextAttributes = [
//                .foregroundColor: UIColor.white
//            ]
//
//            // navbarのタイトル
//            navigationItem.title = "その他"
//
//
//            let headerView = UIView()
//            headerView.backgroundColor = UIColor.blue
//            headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
//
//
//            let footerView = UIView()
//            footerView.backgroundColor = UIColor.red
//            footerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
//
//            tableView.tableHeaderView = headerView
//            tableView.tableFooterView = footerView
//
//
//        }
//
//
//    }
//    extension OtherVC: UITableViewDataSource, UITableViewDelegate {
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            others.count
//        }
//
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//
//            cell.textLabel?.text = others[indexPath.row]
//
//            cell.accessoryType = .disclosureIndicator
//
//            return cell
//        }
//
//        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            let other = others[indexPath.row]
//
//            tableView.deselectRow(at: indexPath, animated: true)
//
//            if other == "レビュー" {
//                // レビューページへ遷移
//                if #available(iOS 10.3, *) {
//                    SKStoreReviewController.requestReview()
//                }
//                    // iOS 10.3未満の処理
//                else {
//                    if let url = URL(string: "itms-apps://itunes.apple.com/app/id1274048262?action=write-review") {
//                        if #available(iOS 10.0, *) {
//                            UIApplication.shared.open(url, options: [:])
//                        } else {
//                            UIApplication.shared.openURL(url)
//                        }
//                    }
//                }
//            } else if other == "アプリを教える" {
//
//                // 共有する項目
//                        let shareText = "memorizé(メモリゼ)で効率よく覚えよう！"
//                        let shareWebsite = NSURL(string: "https://www.apple.com/jp/watch/")!
//                //        let shareImage = UIImage(named: "shareSample.png")!
//
//                //        let activityItems = [shareText, shareWebsite, shareImage] as [Any]
//
//                         let activityItems = [shareText, shareWebsite] as [Any]
//
//                        // 初期化処理
//                        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
//
//                        // 使用しないアクティビティタイプ
//                        let excludedActivityTypes = [
//                //            UIActivity.ActivityType.postToFacebook,
//                //            UIActivity.ActivityType.postToTwitter,
//                //            UIActivity.ActivityType.message,
//                            UIActivity.ActivityType.saveToCameraRoll,
//                            UIActivity.ActivityType.print
//                        ]
//
//                        activityVC.excludedActivityTypes = excludedActivityTypes
//
//                        // UIActivityViewControllerを表示
//                        self.present(activityVC, animated: true, completion: nil)
//
//            }
//
//
//            }
//
//            func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//                return "その他"
//            }
//
//
//    }
