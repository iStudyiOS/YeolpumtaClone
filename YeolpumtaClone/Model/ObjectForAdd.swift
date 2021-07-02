//
//  ObjectForAdd.swift
//  YeolpumtaClone
//
//  Created by 김태균 on 2021/07/01.
//

import Foundation

struct ObjectForAdd: Codable {
    let id: Int
    let name: String
 
    init(id: Int, name: String){
        self.id = id
        self.name = name
    }
}
