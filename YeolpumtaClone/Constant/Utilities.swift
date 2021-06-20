//
//  Utilities.swift
//  YeolpumtaClone
//
//  Created by 김태균 on 2021/06/20.
//

import UIKit

class Utilities {
    
    func statisticsLabel(_ firstString: String) -> UITextView {
        let textView = UITextView()
                
        let statisticLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 15)
            label.text = firstString
            label.textColor = .orange
            return label
        }()
        
        let timeLable: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 28)
            label.text = "00:00:00"
            label.textColor = .black
            return label
        }()
        
        let statisticStack = UIStackView(arrangedSubviews: [statisticLabel, timeLable])
        statisticStack.spacing = CGFloat(4)
        statisticStack.alignment = .center
        statisticStack.axis = .vertical
        textView.addSubview(statisticStack)
        statisticStack.snp.makeConstraints {
            $0.centerX.centerY.equalTo(textView)
        }
        return textView
    }
}
