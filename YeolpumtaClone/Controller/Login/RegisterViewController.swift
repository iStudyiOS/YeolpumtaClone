//
//  RegisterViewController.swift
//  YeolpumtaClone
//
//  Created by minii on 2021/06/17.
//

import UIKit

// layoutSubview 써보기...
class RegisterViewController: UIViewController {
    // MARK: - Properties
    
    let emailButton: UIButton = {
        let button = UIButton()
        button.setTitle(" 이메일로 시작하기", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.setImage(UIImage(systemName: "envelope.fill"), for: .normal)
        button.tintColor = .darkGray
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        updateUI()
    }
    
    // MARK: - Helper
    
    // UI 레이아웃
    func updateUI() {
        view.addSubview(emailButton)
        
        let buttonheight = 50
        
        emailButton.snp.makeConstraints { (m) in
            m.centerX.centerY.equalToSuperview()
            m.height.equalTo(buttonheight)
            m.left.equalToSuperview().offset(20)
            m.right.equalToSuperview().offset(-20)
        }
        emailButton.imageView?.snp.makeConstraints({ (m) in
            m.left.equalToSuperview().offset(10)
            m.top.equalToSuperview().offset(10)
            m.width.equalTo(buttonheight-20)
            m.height.equalTo(buttonheight-20)
        })
        
        
        // 버튼 모서리 둥글게
        emailButton.layer.cornerRadius = CGFloat(buttonheight/6)
    }
}
