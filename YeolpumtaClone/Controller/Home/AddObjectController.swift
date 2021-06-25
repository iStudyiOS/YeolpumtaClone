//
//  AddObjectController.swift
//  YeolpumtaClone
//
//  Created by 김태균 on 2021/06/25.
//

import UIKit
import SnapKit

class AddObjectController: UIViewController {
    // MARK: - Properties
    
    // 화면 적용 필요
    
    private lazy var backButton: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        bt.tintColor = .blue
        bt.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        return bt
    }()
    
    private let objectLabel: UILabel = {
        let label = UILabel()
        label.text = "측정할 과목 이름"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .tintColor
        return label
    }()
    
    private let textField: UITextField = {
        let field = UITextField(frame: CGRect(x: 0, y: 0, width: 150, height: 32))
        field.attributedPlaceholder = NSAttributedString(string: "e.g. 수학,영어,과학,역사..", attributes: [.foregroundColor : UIColor.systemGray])
        field.font = UIFont.systemFont(ofSize: 16)
        
        return field
    }()
    
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.text = "색상선택"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .tintColor
        return label
    }()
    
    private let colorField: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .red
        view.snp.makeConstraints {
            $0.width.height.equalTo(32)
        }
        view.layer.cornerRadius = 32 / 2
        return view
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "과목 추가하기"
        navigationItem.hidesBackButton = true
        
        configureUI()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        
        view.addSubview(objectLabel)
        objectLabel.snp.makeConstraints {
            $0.top.equalTo(view).offset(28)
            $0.leading.equalTo(view).offset(16)
        }
        
        view.addSubview(textField)
        textField.snp.makeConstraints {
            $0.top.equalTo(objectLabel).offset(28)
            $0.leading.equalTo(view).offset(20)
            $0.trailing.equalTo(view).offset(-32)
        }
        
        view.addSubview(colorLabel)
        colorLabel.snp.makeConstraints {
            $0.top.equalTo(textField).offset(40)
            $0.leading.equalTo(view).offset(16)
        }
        
        view.addSubview(colorField)
        colorField.snp.makeConstraints {
            $0.top.equalTo(colorLabel).offset(28)
            $0.leading.equalTo(view).offset(20)
        }
    }
    
    // MARK: - Actions
    
    @objc func handleDismissal() {
        navigationController?.popViewController(animated: true)
    }
}
