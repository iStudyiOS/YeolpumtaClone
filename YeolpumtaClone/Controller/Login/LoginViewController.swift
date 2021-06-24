//
//  LoginViewController.swift
//  YeolpumtaClone
//
//  Created by minii on 2021/06/17.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
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
        field.returnKeyType = .continue
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
    
    // 로그인 버튼
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = UIColor.systemOrange
        return button
    }()
    
    // 계정 찾기 버튼
    let findEmailButton: UIButton = {
        let button = UIButton()
        button.setTitle("계정 찾기", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        return button
    }()
    
    // 비밀번호 찾기 버튼
    let findPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호 찾기", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        return button
    }()
    
    // 또는
    let lineOrLine: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 5
        stackview.alignment = .center
        stackview.distribution = .fill
        return stackview
    }()
    func setStackView() {
        let leftline: UIView = {
            let line = UIView()
            line.backgroundColor = UIColor.lightGray
            return line
        }()

        let rightline: UIView = {
            let line = UIView()
            line.backgroundColor = UIColor.lightGray
            return line
        }()

        let orlabel: UILabel = {
            let label = UILabel()
            label.text = "또는"
            return label
        }()
        
        lineOrLine.addArrangedSubview(leftline)
        lineOrLine.addArrangedSubview(orlabel)
        lineOrLine.addArrangedSubview(rightline)
        
        leftline.snp.makeConstraints { (m) in
            m.height.equalTo(1)
        }
        rightline.snp.makeConstraints { (m) in
            m.height.equalTo(1)
        }
        orlabel.snp.makeConstraints { (m) in
            m.centerX.equalTo(lineOrLine.snp.centerX)
        }
    }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        updateUI()
        
        
    }
    
    // MARK: - Helper
    func updateUI() {
        view.addSubview(accountLabel)
        view.addSubview(emailField)
        view.addSubview(emailFieldLine)
        view.addSubview(passwordField)
        view.addSubview(passwordFieldLine)
        view.addSubview(loginButton)
        view.addSubview(findEmailButton)
        view.addSubview(findPasswordButton)
        view.addSubview(lineOrLine)
        
        let buttonheight = 40
        
        // 계정 라벨
        accountLabel.snp.makeConstraints { (m) in
            m.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            m.left.equalTo(self.view.safeAreaLayoutGuide).offset(20)
        }
        
        // 이메일 필드
        emailField.snp.makeConstraints { (m) in
            m.centerX.equalToSuperview()
            m.top.equalTo(accountLabel.snp.bottom).offset(10)
            m.height.equalTo(buttonheight)
            m.left.equalToSuperview().offset(20)
            m.right.equalToSuperview().offset(-20)
        }
        emailFieldLine.snp.makeConstraints { (m) in
            m.centerX.equalToSuperview()
            m.top.equalTo(emailField.snp.bottom)
            m.height.equalTo(1)
            m.left.equalToSuperview().offset(20)
            m.right.equalToSuperview().offset(-20)
        }
        
        // 패스워드 필드
        passwordField.snp.makeConstraints { (m) in
            m.centerX.equalToSuperview()
            m.top.equalTo(emailField.snp.bottom).offset(10)
            m.height.equalTo(buttonheight)
            m.left.equalToSuperview().offset(20)
            m.right.equalToSuperview().offset(-20)
        }
        passwordFieldLine.snp.makeConstraints { (m) in
            m.centerX.equalToSuperview()
            m.top.equalTo(passwordField.snp.bottom)
            m.height.equalTo(1)
            m.left.equalToSuperview().offset(20)
            m.right.equalToSuperview().offset(-20)
        }
        
        // 로그인 버튼
        loginButton.snp.makeConstraints { (m) in
            m.centerX.equalToSuperview()
            m.top.equalTo(passwordField.snp.bottom).offset(30)
            m.height.equalTo(buttonheight)
            m.left.equalToSuperview().offset(20)
            m.right.equalToSuperview().offset(-20)
        }
        loginButton.layer.cornerRadius = CGFloat(buttonheight/2)
        
        // 계정찾기 버튼
        findEmailButton.snp.makeConstraints { (m) in
            m.top.equalTo(loginButton.snp.bottom).offset(10)
            m.height.equalTo(buttonheight)
            m.right.equalTo(self.view.snp.centerX).offset(-30)
        }
        
        // 비밀번호 찾기 버튼
        findPasswordButton.snp.makeConstraints { (m) in
            m.top.equalTo(loginButton.snp.bottom).offset(10)
            m.height.equalTo(buttonheight)
            m.left.equalTo(self.view.snp.centerX)
        }
        
        lineOrLine.snp.makeConstraints { (m) in
            m.top.equalTo(findPasswordButton.snp.bottom).offset(40)
            m.centerX.equalToSuperview()
            m.height.equalTo(buttonheight)
            m.left.equalToSuperview().offset(20)
            m.right.equalToSuperview().offset(-20)
        }
        setStackView()
        
    }
}
