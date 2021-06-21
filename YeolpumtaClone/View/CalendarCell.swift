//
//  CalendarCell.swift
//  YeolpumtaClone
//
//  Created by 김태균 on 2021/06/20.
//

import UIKit
import SnapKit
import FSCalendar

class CalendarCell: UITableViewCell, FSCalendarDelegate, FSCalendarDataSource {
    // MARK: - Properties
    
    static let identifier = "CalendarCell"
        
    private var calendar = FSCalendar()
    
    // Header를 만들기 위한 여정,, 참고 사이트- https://thoonk.tistory.com/44
    private lazy var leftButton: UIButton = {
        var bt = UIButton()
        bt.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        bt.tintColor = .black
        bt.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        return bt
    }()
    
    private lazy var rightButton: UIButton = {
        var bt = UIButton()
        bt.setImage(UIImage(systemName:"chevron.right"), for: .normal)
        bt.tintColor = .black
        bt.addTarget(self, action: #selector(didTapRightButton), for: .touchUpInside)
        return bt
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "yyyy년 M월  "
        return df
    }()
    
    private lazy var dateHeader: UILabel = {
        let label = UILabel()
        label.text = dateFormatter.string(from: calendar.currentPage)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private var currentPage: Date?
    
    private lazy var today: Date = {
        return Date()
    }()
    
    let studyColor1 = Utilities().studyColor(UIColor.orange.withAlphaComponent(0.25), "0~4시간")
    let studyColor2 = Utilities().studyColor(UIColor.orange.withAlphaComponent(0.5), "4~7시간")
    let studyColor3 = Utilities().studyColor(UIColor.orange.withAlphaComponent(0.75), "7~10시간")
    let studyColor4 = Utilities().studyColor(UIColor.orange, "10+시간")

    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        selectionStyle = .none
        backgroundColor = .white
        
        let calendar = calendar
        calendar.locale = Locale(identifier: "ko_KR")
        
        calendar.delegate = self
        calendar.dataSource = self
        
        configuerUI()
        
        configureCalendarUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configuerUI() {
        
        let headerStack = UIStackView(arrangedSubviews: [leftButton, dateHeader, rightButton])
        headerStack.axis = .horizontal
        headerStack.clipsToBounds = true
        
        contentView.addSubview(headerStack)
        headerStack.snp.makeConstraints {
            $0.width.equalTo(150)
            $0.height.equalTo(40)
            $0.top.equalTo(contentView)
            $0.left.equalTo(contentView).offset(12)
        }
 
        contentView.addSubview(calendar)
        calendar.snp.makeConstraints {
            $0.top.equalTo(headerStack).offset(40)
            $0.width.equalTo(contentView)
            $0.height.equalTo(260)
        }
        
        let colorStack = UIStackView(arrangedSubviews: [studyColor1,studyColor2,studyColor3,studyColor4])
        colorStack.axis = .horizontal
        colorStack.spacing = 32
        
        contentView.addSubview(colorStack)
        colorStack.snp.makeConstraints {
            $0.height.equalTo(16)
            $0.top.equalTo(calendar).offset(260 - 2)
            $0.centerX.equalTo(contentView)
        }
        
    }
    
    private func configureCalendarUI() {
        // Header - 기존의 헤더를 숨기기 위함
        calendar.headerHeight = 0
        
        // Weak
        calendar.appearance.weekdayTextColor = .black

        // Cell
        calendar.appearance.titleDefaultColor = .black
        calendar.appearance.borderRadius = 0
        calendar.appearance.titleTodayColor = .black
        calendar.appearance.todayColor = .systemGray6
        calendar.appearance.selectionColor = .none
        calendar.appearance.titleSelectionColor = .black
        calendar.appearance.borderSelectionColor = .red
        calendar.scrollEnabled = false
    }
    
    // MARK: - Actions
    
    private func moveCurrentPage(moveUp: Bool) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = moveUp ? 1 : -1
        self.currentPage = cal.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        self.calendar.setCurrentPage(self.currentPage!, animated: false)
    }
    
    @objc func didTapLeftButton() {
        moveCurrentPage(moveUp: false)
        dateHeader.text = dateFormatter.string(from: calendar.currentPage)
    }
    
    @objc func didTapRightButton() {
        moveCurrentPage(moveUp: true)
        dateHeader.text = dateFormatter.string(from: calendar.currentPage)
    }
}


