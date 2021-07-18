//
//  RankingViewController.swift
//  YeolpumtaClone
//
//  Created by 김진태 on 2021/06/13.
//

import UIKit
import NaverThirdPartyLogin

class RankingViewController: UIViewController {

    // MARK: - Properties
    
    private let tableView: UITableView = {
        let table = UITableView()
        
        table.register(RankingMenuBarCell.self, forCellReuseIdentifier: RankingMenuBarCell.identifier)
        table.register(DatePickerCell.self, forCellReuseIdentifier: DatePickerCell.identifier)
        
        table.separatorStyle = .none
        table.backgroundColor = .white
        
        return table
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.isNavigationBarHidden = false
//        self.navigationController?.navigationBar.tintColor = .systemOrange
//    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    // MARK: - Helper
    
    

}

extension RankingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: RankingMenuBarCell.identifier, for: indexPath) as! RankingMenuBarCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: DatePickerCell.identifier, for: indexPath) as! DatePickerCell
            return cell
        case 2:
            let cell = UITableViewCell()
            cell.textLabel?.text = "일간 Top3"
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: RankingMenuBarCell.identifier, for: indexPath) as! RankingMenuBarCell
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: RankingMenuBarCell.identifier, for: indexPath) as! RankingMenuBarCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: RankingMenuBarCell.identifier, for: indexPath) as! RankingMenuBarCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 45 + 10
        case 1:
            return 48 + 2
        case 2:
            return 40
        case 3:
            return 200 + 2
        case 4:
            return 65
        default:
            return 65 * 1
        }
    }
}
