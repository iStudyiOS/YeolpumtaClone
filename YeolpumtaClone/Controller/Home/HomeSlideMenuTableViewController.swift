//
//  HomeSlideMenuTableViewController.swift
//  YeolpumtaClone
//
//  Created by minii on 2021/07/03.
//

import UIKit

// MARK:- HeaderView
class TableHeader: UITableViewHeaderFooterView {
    
    static let identifier = "TableHeader"
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "테스트임니당"
        return label
    }()
    
    let loginType: UILabel = {
        let label = UILabel()
        label.text = "naver 테스트"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        return label
    }()
    
    lazy var settingButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: Constants.ImageName.plus)
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let statusMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "  상태메시지를 입력해 주세요."
        label.textColor = .lightGray
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.lightGray.cgColor
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubview(nameLabel)
        contentView.addSubview(loginType)
        contentView.addSubview(settingButton)
        contentView.addSubview(statusMessageLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.sizeToFit()
        loginType.sizeToFit()
        let height: CGFloat = 50
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.left.equalToSuperview().offset(20)
        }
        
        loginType.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(10)
            $0.left.equalTo(nameLabel.snp.left)
        }
        
        settingButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.width.height.equalTo(40)
        }
        
        statusMessageLabel.snp.makeConstraints {
            $0.top.equalTo(loginType.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().offset(-40)
            $0.height.equalTo(height)
        }
        statusMessageLabel.layer.cornerRadius = height/3
    }
}

// MARK:- SettingButton 누를시 HomeViewController에서 실행되게끔 delegate로 넘겨줌
protocol HomeSlideMenuDelegate {
    func didTapSettingButton()
}

// MARK:- UITableViewController
class HomeSlideMenuTableViewController: UITableViewController {
    
    var nickName: String?
    var loginType: LoginType?
    
    let menuData = ["열품타 스토어", "공지사항", "허용앱 설정", "도움말", "친구초대"]
    
    var delegate: HomeSlideMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(TableHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.tableFooterView = UIView()
        
        tableView.dataSource = self
        tableView.delegate = self

    }
    
    @objc func didTapSettingButton() {
        delegate?.didTapSettingButton()
    }
    
// MARK: Cell datasource, delegate
    // 셀 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuData.count
    }
    
    // 각 셀마다 데이터
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = menuData[indexPath.row]
        
        return cell
    }
    
    // 셀 선택시
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cellText = tableView.cellForRow(at: indexPath)?.textLabel?.text {
            print(cellText)
        }
    }
    
// MARK: Header
    // 헤더 부분
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! TableHeader
        
        header.settingButton.addTarget(self, action: #selector(didTapSettingButton), for: .touchUpInside)
        
        if let nickName = self.nickName,
           let loginType = self.loginType?.rawValue {
            header.nameLabel.text = nickName
            header.loginType.text = loginType
        }
        
        return header
    }
    
    // 헤더 높이
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
}

