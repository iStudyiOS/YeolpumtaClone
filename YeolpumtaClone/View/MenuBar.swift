//
//  MenuBar.swift
//  YeolpumtaClone
//
//  Created by 김태균 on 2021/06/18.
//

import UIKit

class MenuBar: UICollectionViewCell {

    let staisticsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let selectedLine: UIView = {
        let view = UIView()
        return view
    }()
    
    // MenuBar 선택시 색상 변경
    override var isHighlighted: Bool {
        didSet {
            staisticsLabel.textColor = isHighlighted ? UIColor.orange : UIColor.black
            selectedLine.backgroundColor = isHighlighted ? UIColor.orange : UIColor.white
        }
    }
    
    override var isSelected: Bool {
        didSet {
            staisticsLabel.textColor = isSelected ? UIColor.orange : UIColor.black
            selectedLine.backgroundColor = isSelected ? UIColor.orange : UIColor.white
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
                
        contentView.addSubview(staisticsLabel)
        staisticsLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(contentView)
        }
        
        contentView.addSubview(selectedLine)
        selectedLine.snp.makeConstraints {
            $0.bottom.centerX.equalTo(contentView)
            $0.width.equalTo(contentView.frame.width / 3)
            $0.height.equalTo(4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

