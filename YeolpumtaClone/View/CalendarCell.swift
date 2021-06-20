//
//  CalendarCell.swift
//  YeolpumtaClone
//
//  Created by 김태균 on 2021/06/20.
//

import UIKit
import FSCalendar
import SnapKit

class CalendarCell: UITableViewCell {
    // MARK: - Properties
    
    static let identifier = "CalendarCell"
    
    var calendar: FSCalendar!
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .none
        
        configuerUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configuerUI() {
        calendar = FSCalendar()
        calendar.backgroundColor = .none
    
        contentView.addSubview(calendar)
        calendar.snp.makeConstraints {
            $0.width.equalTo(contentView)
            $0.height.equalTo(300)
            $0.top.equalTo(contentView)
        }
    }
}
