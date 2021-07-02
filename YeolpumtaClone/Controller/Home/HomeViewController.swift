//
//  HomeViewController.swift
//  YeolpumtaClone
//
//  Created by 김진태 on 2021/06/13.
//

import SnapKit
import UIKit

@available(iOS 14.0, *)
class HomeViewController: UIViewController {
    // MARK: - Property

    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: Constants.ImageName.plus), for: .normal)
        button.backgroundColor = .tintColor
        button.tintColor = .white
        button.addTarget(self, action: #selector(addObject), for: .touchUpInside)
        return button
    }()
    
    private let totalTimerView: UIView = {
        let view = UIView()
        view.backgroundColor = .tintColor
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        
        // 금일 날짜 표시
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy . M . d"
        
        label.text = dateFormatter.string(from: now)
        
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

    let menuView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var slideInMenuPadding: CGFloat = self.view.frame.width * 0.30
    var isSlideMenuBarPresented = false
    
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
        setupSlideMenuBarButton()
    }
    
    fileprivate func setupSlideMenuBarButton() {
        let slideMenuBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .done, target: self, action: #selector(slideMenuBarButtonTapped))
        slideMenuBarButtonItem.tintColor = .white
        self.navigationItem.setLeftBarButton(slideMenuBarButtonItem, animated: false)
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
    
    // MARK: - Actions
    
    @available(iOS 14.0, *)
    @objc func addObject() {
        let controller = AddObjectController()
        navigationController?.pushViewController(controller, animated: true)
        controller.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // 메뉴 열기
    @objc func slideMenuBarButtonTapped() {
        
        let screenSize = UIScreen.main.bounds.size
        let menuViewWidth: CGFloat = screenSize.width * 0.85
        
        let window = UIApplication.shared.windows.first
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        containerView.frame = self.view.frame
        window?.addSubview(containerView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(slideUpMenuViewTapped))
        containerView.addGestureRecognizer(tapGesture)
        
        menuView.frame = CGRect(x: -menuViewWidth, y: 0, width: menuViewWidth, height: screenSize.height)
        window?.addSubview(menuView)
        
        containerView.alpha = 0
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseInOut,
                       animations: {
                        self.containerView.alpha = 0.8
                        self.menuView.frame = CGRect(x: 0, y: 0, width: menuViewWidth, height: screenSize.height)
                       },
                       completion: nil)
    }
    
    // 메뉴 닫기
    @objc func slideUpMenuViewTapped() {
        let screenSize = UIScreen.main.bounds.size
        let menuViewWidth: CGFloat = screenSize.width * 0.85
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseInOut,
                       animations: {
                        self.containerView.alpha = 0
                        self.menuView.frame = CGRect(x: -menuViewWidth, y: 0, width: menuViewWidth, height: screenSize.height)
                       },
                       completion: nil)
    }
}

@available(iOS 14.0, *)
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + 4
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
