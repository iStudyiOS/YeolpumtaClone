//
//  UIColor+Ext.swift
//  YeolpumtaClone
//
//  Created by 김진태 on 2021/06/17.
//

import UIKit.UIColor

extension UIColor {
    static let tintColor: UIColor = .systemOrange
}

extension UIColor {

     class func color(data:Data) -> UIColor? {
          return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor
     }

     func encode() -> Data? {
          return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
     }
}
