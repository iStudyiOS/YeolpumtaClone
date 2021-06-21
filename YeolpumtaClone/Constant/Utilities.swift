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
    
    func studyColor(_ color: UIColor, _ text: String) -> UIView {
        let studyView = UIView()
        
        let colorView: UIView = {
            let view = UIView()
            view.backgroundColor = color
            view.snp.makeConstraints {
                $0.width.height.equalTo(10)
            }
            view.layer.cornerRadius = 10 / 2
            return view
        }()
        
        let studyText: UILabel = {
            let label = UILabel()
            label.text = text
            label.font = UIFont.systemFont(ofSize: 10)
            return label
        }()
        
        let stack = UIStackView(arrangedSubviews: [colorView,studyText])
        stack.axis = .horizontal
        stack.spacing = 6
        
        studyView.snp.makeConstraints {
            $0.height.equalTo(16)
            $0.width.equalTo(40)
        }
        
        studyView.addSubview(stack)
        stack.snp.makeConstraints {
            $0.centerX.centerY.equalTo(studyView)
        }
        
        return studyView
    }
}
