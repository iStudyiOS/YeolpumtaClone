//
//  MenuBar.swift
//  YeolpumtaClone
//
//  Created by 김태균 on 2021/06/20.
//

import UIKit

class MenuBar: UICollectionViewCell {
    // MARK: - Properties
    
    static let identifier = "MenuBar"
    
    let menuLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let selectedLine = UIView()
    
    // MenuBar 선택시 색상 변경
    override var isSelected: Bool {
        didSet {
            menuLabel.textColor = isSelected ? UIColor.orange : UIColor.black
            selectedLine.backgroundColor = isSelected ? UIColor.orange : UIColor.white
        }
    }
    
    // MARK: - LIfecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        contentView.addSubview(menuLabel)
        menuLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(contentView)
        }

        contentView.addSubview(selectedLine)
        selectedLine.snp.makeConstraints {
            $0.bottom.centerX.equalTo(contentView)
            $0.width.equalTo(contentView.frame.width / 3)
            $0.height.equalTo(4)
        }
    }
}

