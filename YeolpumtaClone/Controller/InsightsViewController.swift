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
        view.backgroundColor = .systemGray5
    
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension InsightsViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CalendarCell.identifier, for: indexPath) as! CalendarCell
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: StatisticsCell.identifier, for: indexPath) as! StatisticsCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return CGFloat(300)
        } else {
            return CGFloat(500)
//                CGFloat(StatisticsCell.AutoresizingMask.flexibleHeight.rawValue)
        }
    }
}

