//
//  HomeViewController.swift
//  YeolpumtaClone
//
//  Created by 김진태 on 2021/06/13.
//

import SnapKit
import UIKit

class HomeViewController: UIViewController {
    // MARK: - Property

    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: Constants.ImageName.plus), for: .normal)
        button.backgroundColor = .tintColor
        button.tintColor = .white
        return button
    }()
    
    private let totalTimerView: UIView = {
        let view = UIView()
        view.backgroundColor = .tintColor
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        label.text = "2021. 6. 17"
        
        return label
    }()
    
    private let totalTimerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textColor = .white
        label.text = "00:00:00"
        
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Helper

    fileprivate func setupUI() {
        setupTotalTimerView()
        setupTableView()
        setupAddButton()
    }

    fileprivate func setupAddButton() {
        view.addSubview(addButton)
        addButton.snp.makeConstraints {
            $0.width.height.equalTo(48)
            $0.right.equalToSuperview().offset(-32)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-24)
        }
        addButton.layer.cornerRadius = 48 / 2
    }
    
    fileprivate func setupTotalTimerView() {
        view.addSubview(totalTimerView)
        totalTimerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(160)
        }
        
        let stack = UIStackView(arrangedSubviews: [dateLabel, totalTimerLabel])
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        
        totalTimerView.addSubview(stack)
        stack.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    fileprivate func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(totalTimerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.register(HomeSectionCell.self, forCellReuseIdentifier: HomeSectionCell.cellIdentifier)
        tableView.register(HomeTimerCell.self, forCellReuseIdentifier: HomeTimerCell.cellIdentifier)
        
        tableView.dataSource = self
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeSectionCell.cellIdentifier, for: indexPath) as? HomeSectionCell else {
                fatalError("tableView에서 HomeSectionCell을 dequeue하던 과정에서 에러가 발생하였습니다")
            }
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTimerCell.cellIdentifier, for: indexPath) as? HomeTimerCell else {
                fatalError("tableView에서 HomeTimerCell을 dequeue하던 과정에서 에러가 발생하였습니다")
            }
            return cell
        }
    }
    
    
}
