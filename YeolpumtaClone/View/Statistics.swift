//
//  Statistics.swift
//  YeolpumtaClone
//
//  Created by 김태균 on 2021/06/20.
//

import UIKit

class Statistics: UICollectionViewCell {
    // MARK:- Properties
    
    static let identifier = "Statistics"
    
    static var stacticDayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let dayLabel = stacticDayLabel
        
    var totalLabel: UITextView = {
        let label = Utilities().statisticsLabel("총 공부 시간")
        return label
    }()

    var averageLabel: UITextView = {
        let label = Utilities().statisticsLabel("평균 공부 시간")
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        contentView.addSubview(dayLabel)
        dayLabel.snp.makeConstraints {
            $0.centerX.equalTo(contentView)
            $0.top.equalTo(contentView).offset(20)
        }

        contentView.addSubview(totalLabel)
        totalLabel.snp.makeConstraints {
            $0.top.equalTo(dayLabel).offset(40)
            $0.left.equalTo(contentView).offset(contentView.frame.width / 10)
            $0.height.equalTo(50)
            $0.width.equalTo(120)
        }

        contentView.addSubview(averageLabel)
        averageLabel.snp.makeConstraints {
            $0.top.equalTo(dayLabel).offset(40)
            $0.trailing.equalTo(contentView).offset(-contentView.frame.width / 10)
            $0.height.equalTo(50)
            $0.width.equalTo(120)
        }
    }
}
