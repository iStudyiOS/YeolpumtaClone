//
//  DatePickerCell.swift
//  YeolpumtaClone
//
//  Created by minii on 2021/07/18.
//

import UIKit
import SnapKit

class DatePickerCell: UITableViewCell {
    
    static let identifier = "DatePickerCell"
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "몇월 몇일?"
        return label
    }()
    
    let leftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = UIColor.tintColor
        return button
    }()
    
    let rightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = UIColor.tintColor
        return button
    }()
    
    let whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemGray6
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        
        let height = 48
        let buttonsize = height/2
        
        contentView.addSubview(whiteView)
        whiteView.snp.makeConstraints {
            $0.height.equalTo(height)
            $0.centerX.top.width.equalTo(contentView)
        }
        
        whiteView.addSubview(leftButton)
        leftButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(buttonsize)
            $0.left.equalToSuperview().offset(20)
        }
        
        whiteView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
        
        whiteView.addSubview(rightButton)
        rightButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(buttonsize)
            $0.right.equalToSuperview().offset(-20)
        }
    }
}
