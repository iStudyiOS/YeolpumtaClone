//
//  RegisterViewController.swift
//  YeolpumtaClone
//
//  Created by minii on 2021/06/17.
//

import UIKit
import NaverThirdPartyLogin
import Alamofire

// layoutSubview 써보기...
class RegisterViewController: UIViewController {

    
    // MARK: - Properties
    
    let registerStackView = RegisterStackView()
    
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        setStackView()
        setButtonTouchFunc()
        
    }
    
    // MARK: - Helper
    
    // 스택뷰 배치
    func setStackView() {
        view.addSubview(registerStackView)
        registerStackView.snp.makeConstraints { (m) in
            m.centerX.centerY.width.equalToSuperview()
        }
    }
    
    // 버튼 터치시 기능
    func setButtonTouchFunc() {
        registerStackView.emailButton.addTarget(self, action: #selector(didTapEmailButton), for: .touchUpInside)
        registerStackView.naverButton.addTarget(self, action: #selector(didTapNaverButton), for: .touchUpInside)
        registerStackView.logoutButton.addTarget(self, action: #selector(didTapLogoutButton), for: .touchUpInside)
    }
    
    // emailButton 터치시
    @objc func didTapEmailButton() {
        let vc = EmailRegisterViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
    
    // naverButton 터치시
    @objc func didTapNaverButton() {
        loginInstance?.delegate = self
        loginInstance?.requestThirdPartyLogin()
    }
    
//     logoutButton 터치시
    @objc func didTapLogoutButton() {
        loginInstance?.requestDeleteToken()
    }
}

// MARK: - Naver Login

extension RegisterViewController: NaverThirdPartyLoginConnectionDelegate {
    
    // 로그인 성공한 경우 호출
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("Success Login")
        getNaverInfo()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(true, forKey: "userLogged")
    }
    
    // refresh token
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
//        loginInstance?.accessToken
    }
    
    // 로그아웃
    func oauth20ConnectionDidFinishDeleteToken() {
        print("log out")
    }
    
    // 모든 error
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("error = \(error.localizedDescription)")
    }
    
    func getNaverInfo() {
        guard let isValidAccessToken = loginInstance?.isValidAccessTokenExpireTimeNow() else {
            return
        }
        
        if !isValidAccessToken {
            print("no accesstoken...")
            return
        }
        
        guard let tokenType = loginInstance?.tokenType,
              let accessToken = loginInstance?.accessToken else {
            return
        }
        
        let urlStr = "https://openapi.naver.com/v1/nid/me"
        let url = URL(string: urlStr)!
        
        let authorization = "\(tokenType) \(accessToken)"
        
        let req = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
        
        req.responseJSON(completionHandler: { response in
            guard let result = response.value as? [String: Any] else { return }
            guard let object = result["response"] as? [String: Any] else { return }
            guard let name = object["name"] as? String else { return }
            guard let email = object["email"] as? String else { return }
            
            let user = YeolpumtaUser(name: name, email: email)
            let loginto = "Naver"
            
            DatabaseManager.shared.insertUser(user: user, loginto: loginto)
        })
        
        
    }
    
    
}

// MARK:- RegisterStackView

class RegisterStackView: UIStackView {
    
    // init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
        self.spacing = 10
        self.alignment = .center
        self.distribution = .fill
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Properties
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
    
    let naverButton: UIButton = {
        let button = UIButton()
        button.setTitle(" 네이버로 시작하기", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.setImage(UIImage(systemName: "envelope.fill"), for: .normal)
        button.tintColor = .darkGray
        return button
    }()
    
    let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle(" 로그아웃", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.tintColor = .darkGray
        return button
    }()
    
    // UI 레이아웃
    func configureUI() {
        self.addArrangedSubview(emailButton)
        self.addArrangedSubview(naverButton)
        self.addArrangedSubview(logoutButton)
        
        let buttonheight = 50
        
        emailButton.snp.makeConstraints { (m) in
            m.height.equalTo(buttonheight)
            m.width.equalToSuperview().offset(-40)
        }
        emailButton.imageView?.snp.makeConstraints { (m) in
            m.left.equalToSuperview().offset(10)
            m.top.equalToSuperview().offset(10)
            m.width.equalTo(buttonheight-20)
            m.height.equalTo(buttonheight-20)
        }
        
        naverButton.snp.makeConstraints { (m) in
            m.height.equalTo(buttonheight)
            m.width.equalToSuperview().offset(-40)
        }
        naverButton.imageView?.snp.makeConstraints { (m) in
            m.left.equalToSuperview().offset(10)
            m.top.equalToSuperview().offset(10)
            m.width.equalTo(buttonheight-20)
            m.height.equalTo(buttonheight-20)
        }
        
        logoutButton.snp.makeConstraints { (m) in
            m.height.equalTo(buttonheight)
            m.width.equalToSuperview().offset(-40)
        }
        
        // 버튼 모서리 둥글게
        emailButton.layer.cornerRadius = CGFloat(buttonheight/6)
        naverButton.layer.cornerRadius = CGFloat(buttonheight/6)
        
    }
}
