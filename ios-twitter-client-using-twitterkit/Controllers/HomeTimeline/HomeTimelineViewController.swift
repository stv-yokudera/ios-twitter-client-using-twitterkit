//
//  HomeTimelineViewController.swift
//  ios-twitter-client-using-twitterkit
//
//  Created by OkuderaYuki on 2018/03/10.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import ObjectMapper
import SVProgressHUD
import TwitterKit
import UIKit

final class HomeTimelineViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private let provider = HomeTimelineProvider()
    private let refreshControl = UIRefreshControl()
    
    private var homeTimelineAPI = HomeTimelineAPI()
    private var userID: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {

        homeTimelineAPI.result = self
        twitterLogin()
        setupTableView()
    }

    /// セッションがあれば、ホームタイムライン取得処理を実行
    ///
    /// セッションが無ければ、ログインしてからホームタイムライン取得処理を実行
    private func twitterLogin() {
        if let session = TwitterSessionStore.loggedInUserAuthSession() {
            homeTimelineAPI.load(userID: session.userID)
            return
        }
        TwitterSessionStore.login { loggedInUser, logInError in

            if let logInError = logInError {
                self.showAlert(message: logInError.message)
                return
            }

            if let loggedInUser = loggedInUser {
                self.homeTimelineAPI.load(userID: loggedInUser.id)
            }
        }
    }

    /// TableViewの初期処理
    private func setupTableView() {
        tableView.estimatedRowHeight = TweetCell.estimatedRowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.prefetchDataSource = provider
        tableView.dataSource = provider
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: .pullToRefresh, for: .valueChanged)
    }

    /// アラートを表示する
    private func showAlert(message: String) {
        let alert = AlertHelper.buildAlert(message: message)
        present(alert, animated: true, completion: nil)
    }

    private func endRefreshing() {
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }

    // MARK: - Selector
    @objc func pullToRefresh(sender: UIRefreshControl) {
        refreshControl.beginRefreshing()
        twitterLogin()
    }
}

extension HomeTimelineViewController: HomeTimelineResult {
    func set(status: HomeTimelineAPIStatus) {

        switch status {
        case .loading:
            if !refreshControl.isRefreshing {
                SVProgressHUD.show()
            }
            break

        case .loaded(let response):
            SVProgressHUD.dismiss()
            endRefreshing()

            response.forEach {
                print($0.description)
            }
            provider.set(tweets: response)
            tableView.reloadData()
            break

        case .timeout:
            SVProgressHUD.dismiss()
            endRefreshing()
            showAlert(message: "TIMEOUT".localized())
            break

        case .offline:
            SVProgressHUD.dismiss()
            endRefreshing()
            showAlert(message: "OFFLINE".localized())
            break

        case .error(message: let message):
            SVProgressHUD.dismiss()
            endRefreshing()
            showAlert(message: message)
            break
        }
    }
}

// MARK: - Custom Selectors
private extension Selector {
    static let pullToRefresh = #selector(HomeTimelineViewController.pullToRefresh(sender:))
}
