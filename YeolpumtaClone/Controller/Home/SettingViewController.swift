//
//  SettingViewController.swift
//  YeolpumtaClone
//
//  Created by minii on 2021/07/04.
//

import UIKit
import NaverThirdPartyLogin

class SettingViewController: UIViewController {

    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.frame = view.bounds
        self.view.addSubview(tableView)
    }
}

// MARK:- TableView Data, Delegate
extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    
    // 셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // 각 셀마다 데이터
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "로그아웃"
        
        return cell
    }
    
    // 셀 선택시
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        didSelectRowAt(index: indexPath.row)
    }
}

// MARK:- 각 셀마다 터치시 기능들 ..
extension SettingViewController {
    
    enum Settings: Int {
        case Logout = 0
    }
    
    func didSelectRowAt(index: Int){
        let settings = Settings.init(rawValue: index)
        
        switch settings {
        case .Logout:
            didTapLogout()
        case .none:
            print("no index error...")
        }
    }
    
    // 로그아웃 버튼 누를시..
    func didTapLogout() {
        loginInstance?.requestDeleteToken()

        UserInfoHelper.resetLogin()
        
        self.dismiss(animated: false, completion: nil)
        
        let vc = FirstViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
}
