//
//  InsightsViewController.swift
//  YeolpumtaClone
//
//  Created by 김진태 on 2021/06/13.
//

import UIKit
import SnapKit

class InsightsViewController: UIViewController {
    // MARK: - Properties
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(CalendarCell.self, forCellReuseIdentifier: CalendarCell.identifier)
        table.register(MenuBarCell.self, forCellReuseIdentifier: MenuBarCell.identifier)
        table.register(StatisticsCell.self, forCellReuseIdentifier: StatisticsCell.identifier)
        table.separatorStyle = .none
        return table
    }()
    
    // MARK: - Lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .yellow
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension InsightsViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CalendarCell.identifier, for: indexPath) as! CalendarCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: MenuBarCell.identifier, for: indexPath) as! MenuBarCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: StatisticsCell.identifier, for: indexPath) as! StatisticsCell
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 260 + 40 + 16
        case 1:
            return 10 + 40 + 2
        default:
            return 500
        }
    }
}
