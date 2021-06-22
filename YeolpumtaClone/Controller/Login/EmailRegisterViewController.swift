//
//  EmailRegisterViewController.swift
//  YeolpumtaClone
//
//  Created by minii on 2021/06/22.
//

import UIKit

class EmailRegisterViewController: UIViewController {

    let emailStackView = EmailStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        updateUI()
    }
    
    func updateUI() {
        view.addSubview(emailStackView)
        
        emailStackView.snp.makeConstraints { (m) in
            m.centerX.centerY.width.equalToSuperview()
            
        }
        
        emailStackView.setStackView()
    }

}

// MARK:- 이메일로 시작하기 버튼 눌렀을때 나오는 stackview
class EmailStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
        self.spacing = 0
        self.alignment = .center
        self.distribution = .fill
        self.isHidden = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // "계정" 라벨
    let accountLabel: UILabel = {
        let label = UILabel()
        label.text = "계정"
        label.textColor = UIColor.systemOrange
        label.font = label.font.withSize(15)
        return label
    }()
    
    // 이메일 텍스트필드
    let emailField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.placeholder = "이메일 입력"
        field.backgroundColor = .white
        // left 패딩 효과
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        return field
    }()
    // emailField 가로줄
    let emailFieldLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.lightGray
        return line
    }()
    
    // 패스워드 텍스트필드
    let passwordField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.placeholder = "비밀번호 입력"
        field.backgroundColor = .white
        // left 패딩 효과
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        return field
    }()
    // passwordField 가로줄
    let passwordFieldLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.lightGray
        return line
    }()
    
    // 패스워드 확인 텍스트필드
    let passwordFieldCheck: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.placeholder = "비밀번호 확인"
        field.backgroundColor = .white
        // left 패딩 효과
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        return field
    }()
    // passwordFieldCheck 가로줄
    let passwordFieldCheckLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.lightGray
        return line
    }()
    
    // 회원가입 버튼
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = UIColor.systemOrange
        return button
    }()
    
    func setStackView() {
        self.addArrangedSubview(accountLabel)
        self.addArrangedSubview(emailField)
        self.addArrangedSubview(emailFieldLine)
        self.addArrangedSubview(passwordField)
        self.addArrangedSubview(passwordFieldLine)
        self.addArrangedSubview(passwordFieldCheck)
        self.addArrangedSubview(passwordFieldCheckLine)
        self.addArrangedSubview(registerButton)
        
        let buttonheight = 50
        
        accountLabel.snp.makeConstraints { (m) in
            m.left.equalToSuperview().offset(25)
        }
        
        emailField.snp.makeConstraints { (m) in
            m.width.equalToSuperview().offset(-40)
            m.height.equalTo(buttonheight)
        }
        emailFieldLine.snp.makeConstraints { (m) in
            m.height.equalTo(1)
            m.width.equalTo(emailField.snp.width)
        }
        
        passwordField.snp.makeConstraints { (m) in
            m.width.equalToSuperview().offset(-40)
            m.height.equalTo(buttonheight)
        }
        passwordFieldLine.snp.makeConstraints { (m) in
            m.height.equalTo(1)
            m.width.equalTo(emailField.snp.width)
        }
        
        passwordFieldCheck.snp.makeConstraints { (m) in
            m.width.equalToSuperview().offset(-40)
            m.height.equalTo(buttonheight)
        }
        passwordFieldCheckLine.snp.makeConstraints { (m) in
            m.height.equalTo(1)
            m.width.equalTo(emailField.snp.width)
        }
        
        registerButton.snp.makeConstraints { (m) in
            m.width.equalTo(emailField.snp.width)
            m.height.equalTo(buttonheight-10)
        }
        // 회원가입 버튼만 간격 띄우기
        self.setCustomSpacing(20, after: passwordFieldCheckLine)
        // 모서리 둥글게
        registerButton.layer.cornerRadius = CGFloat((buttonheight-10)/2)
        
    }
}
