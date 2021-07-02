//
//  RankingViewController.swift
//  YeolpumtaClone
//
//  Created by 김진태 on 2021/06/13.
//

import UIKit
import NaverThirdPartyLogin

class RankingViewController: UIViewController {

    // MARK: - Properties
    
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle(" 로그아웃", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.tintColor = .darkGray
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        logoutButton.addTarget(self, action: #selector(didTapLogoutButton), for: .touchUpInside)
    }
    
    // MARK: - Helper
    
    @objc func didTapLogoutButton() {
        DatabaseManager.shared.userExists(email: "Naver-ckdals4862-naver-com")
        DatabaseManager.shared.userExists(email: "Kakao-ckdals4862-naver-com")
        
        
        loginInstance?.requestDeleteToken()
        
        print("logout!")
        UserDefaults.standard.set(false, forKey: "userLogged")
        
        let vc = FirstViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
        
    }
    
    func configureUI() {
        self.view.addSubview(logoutButton)
        
        let buttonheight = 50
        
        logoutButton.snp.makeConstraints { (m) in
            m.centerX.centerY.equalToSuperview()
            m.width.equalToSuperview().offset(-40)
            m.height.equalTo(buttonheight)
        }
        
    }
}
