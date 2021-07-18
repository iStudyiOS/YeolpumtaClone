//
//  UserInfoHelper.swift
//  YeolpumtaClone
//
//  Created by minii on 2021/07/05.
//

import Foundation

class UserInfoHelper {
    
    static func setNickName(_ nickName: String) {
        UserDefaults.standard.set(nickName, forKey: "nickName")
    }
    
    static func getNickName() -> String {
        guard let nickName = UserDefaults.standard.value(forKey: "nickName") as? String else {
            return "is empty???"
        }
        
        if nickName.isEmpty {
            return "is empty???"
        }
        
        return nickName
    }
    
    static func setLoginType(_ loginType: LoginType) {
        UserDefaults.standard.set(loginType.rawValue, forKey: "loginType")
    }
    
    static func getLoginType() -> LoginType {
        guard let loginType = UserDefaults.standard.value(forKey: "loginType") as? String else {
            return .None
        }
        
        if loginType == LoginType.Naver.rawValue {
            return .Naver
        }
        
        else {
            return .None
        }
    }
    
    static func resetLogin() {
        UserDefaults.standard.set(LoginType.None.rawValue, forKey: "loginType")
        UserDefaults.standard.set("", forKey: "nickName")
    }
    
    static func isLogin() -> Bool {
        guard let loginType = UserDefaults.standard.value(forKey: "loginType") as? String else {
            return false
        }
        
        return loginType.isEmpty == false
    }
    
}

enum LoginType: String {
    case None = ""
    case Naver = "Naver"
}
