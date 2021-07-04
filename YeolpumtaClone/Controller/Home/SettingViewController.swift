//
//  SettingViewController.swift
//  YeolpumtaClone
//
//  Created by minii on 2021/07/04.
//

import UIKit

class SettingViewController: UIViewController {

    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

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
        if let cellText = tableView.cellForRow(at: indexPath)?.textLabel?.text {
            print(cellText)
        }
    }
    
}
