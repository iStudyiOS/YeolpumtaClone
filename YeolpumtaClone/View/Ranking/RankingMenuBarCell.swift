//
//  RankingMenuBarCell.swift
//  YeolpumtaClone
//
//  Created by minii on 2021/07/18.
//

import UIKit
import SnapKit

class RankingMenuBarView: UIView {

    func buildDayButton(withText text: String) -> UIView {
        
        let contentView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }()
        
        let dayLabel: UILabel = {
            let label = UILabel()
            label.text = text
            return label
        }()
        
        let barView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.tintColor
            return view
        }()
        
        contentView.addSubview(dayLabel)
        dayLabel.snp.makeConstraints { m in
            m.centerX.centerY.equalToSuperview()
        }
        
        contentView.addSubview(barView)
        barView.snp.makeConstraints { m in
            m.left.equalTo(dayLabel.snp.left)
            m.right.equalTo(dayLabel.snp.right)
            m.bottom.equalToSuperview()
            m.height.equalTo(4)
        }
        
        return contentView
    }
    
    lazy var dayButton = buildDayButton(withText: "일간")
    lazy var weekButton = buildDayButton(withText: "주간")
    lazy var monthButton = buildDayButton(withText: "월간")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        let buttonSpace = 100
        
        self.addSubview(weekButton)
        weekButton.snp.makeConstraints { m in
            m.centerX.centerY.height.equalToSuperview()
        }
        
        self.addSubview(dayButton)
        dayButton.snp.makeConstraints { m in
            m.centerY.height.equalToSuperview()
            m.centerX.equalToSuperview().offset(-buttonSpace)
        }
        
        self.addSubview(monthButton)
        monthButton.snp.makeConstraints { m in
            m.centerY.height.equalToSuperview()
            m.centerX.equalToSuperview().offset(buttonSpace)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class RankingMenuBarCell: UITableViewCell {
    
    static let identifier = "RankingMenuBarCell"
    
    let customView = RankingMenuBarView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemGray6
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.addSubview(customView)
        customView.snp.makeConstraints { m in
            m.height.equalTo(40)
            m.left.right.top.equalToSuperview()
        }
    }
}
