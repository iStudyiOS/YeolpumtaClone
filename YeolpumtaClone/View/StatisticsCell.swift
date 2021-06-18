//
//  StatisticsCell.swift
//  YeolpumtaClone
//
//  Created by 김태균 on 2021/06/18.
//

import UIKit
import SnapKit


class StatisticsCell: UITableViewCell {
    
    var statisticsView = UIView()
    
    static let identifier = "StatisticsCell"
    
    private let menuBar: MenuBar = {
        let menu = MenuBar()
        
        return menu
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.backgroundColor = .systemGray5
        
        contentView.addSubview(menuBar)
        menuBar.snp.makeConstraints {
            $0.topMargin.equalTo(10)
            $0.width.equalTo(contentView)
            $0.height.equalTo(60)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helpers
    
    func setupMenuBar() {
        contentView.addSubview(menuBar)
//        contentView.addcon
    }
    
}
