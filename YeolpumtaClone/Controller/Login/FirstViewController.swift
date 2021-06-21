//
//  FirstViewController.swift
//  YeolpumtaClone
//
//  Created by minii on 2021/06/17.
//

import UIKit
import SnapKit

class FirstViewController: UIViewController {
    
    // MARK: - Properties
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.ImageName.plus)
        return imageView
    }()
    
    let textLabel: UILabel = {
        let text = UILabel()
        text.text = "공부, 혼자 하지 말고 열품타에서 함께 하세요!"
        return text
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("새로 시작하기", for: .normal)
        button.setTitleColor(UIColor.systemOrange, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemOrange.cgColor
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(UIColor.systemOrange, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemOrange.cgColor
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUI()
        
        self.loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        self.registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
    }
    
    // MARK: - Helper
    
    // 로그인 버튼 눌렸을때
    @objc func didTapLoginButton() {
        let vc = LoginViewController()
        vc.title = "로그인"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // 새로 시작하기 버튼 눌렀을때
    @objc func didTapRegisterButton() {
        let vc = RegisterViewController()
        vc.title = "등록하기"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // UI 레이아웃
    func setUI() {
        view.addSubview(imageView)
        view.addSubview(textLabel)
        view.addSubview(registerButton)
        view.addSubview(loginButton)
        
        let buttonheight = 40
        
        imageView.snp.makeConstraints { (m) in
            m.centerX.centerY.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints { (m) in
            m.centerX.equalToSuperview()
            m.top.equalTo(imageView.snp.bottom).offset(80)
        }
        
        loginButton.snp.makeConstraints { (m) in
            m.bottom.equalTo(view.snp.bottom).offset(-70)
            m.height.equalTo(buttonheight)
            m.left.equalToSuperview().offset(20)
            m.right.equalToSuperview().offset(-20)
        }
        
        registerButton.snp.makeConstraints { (m) in
            m.bottom.equalTo(loginButton.snp.top).offset(-10)
            m.height.equalTo(buttonheight)
            m.left.equalToSuperview().offset(20)
            m.right.equalToSuperview().offset(-20)
        }
        
        // 버튼 모서리 둥글게
        loginButton.layer.cornerRadius = CGFloat(buttonheight/2)
        registerButton.layer.cornerRadius = CGFloat(buttonheight/2)
    }
}
