//
//  DatabaseManager.swift
//  YeolpumtaClone
//
//  Created by minii on 2021/06/30.
//

import Foundation
import FirebaseDatabase

struct YeolpumtaUser {
    let name: String
    let email: String
    
    // '.' '#' '$' '[' or ']' not contain..
    var safeEmail: String {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
}

class DatabaseManager {
    // single ton
    static let shared = DatabaseManager()
    
    let db: DatabaseReference = Database.database().reference()
}

// FirebaseDB 데이터 다루기
extension DatabaseManager {
    
    // 가입된 이메일 존재하는지 확인
    func userExists(email: String) {
        db.child(email).observeSingleEvent(of: .value, with: { snapshot in
            let exists = snapshot.exists()
            
            if exists {
                print("\(email) : \(exists)")
            } else {
                print("\(email) : \(exists)")
            }
        })
    }
    
    func insertUser(user: YeolpumtaUser, loginto: String) {
        
        let userId = "\(loginto)-\(user.safeEmail)"
        
        self.db.child(userId).setValue([
            "name": user.name,
            "email": user.email,
            "loginto": loginto
        ])
    }
}

/*
 
 userId: String // "\(loginto)-\(email)" {
    "name": String  // 나중에 닉네임으로 변경하기..
    "email": String // safeEmail?
    "loginto" String // naver, kakao, google, facebook, email
 }
 
*/
