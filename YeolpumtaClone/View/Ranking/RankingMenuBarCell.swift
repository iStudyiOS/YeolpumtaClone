//
//  RankingMenuBarCell.swift
//  YeolpumtaClone
//
//  Created by minii on 2021/07/18.
//

//import UIKit
//import SnapKit
//
//class RankingMenuBarView: UIView {
//
//    class button: UIButton {
//        var text: String
//
//        lazy var dayLabel: UILabel = {
//            let label = UILabel()
//            label.text = text
//            return label
//        }()
//
//        lazy var barView: UIView = {
//            let view = UIView()
//            view.backgroundColor = UIColor.tintColor
//            view.isHidden = true
//            return view
//        }()
//
//        // code
//        init(text: String, tag: Int) {
//            self.text = text
//            super.init(frame: .zero)
//            self.tag = tag
//            configureUI()
//            setButton()
//        }
//
//        // storyboard
//        required init?(coder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
//
//        func configureUI(){
//            self.addSubview(dayLabel)
//            dayLabel.snp.makeConstraints { m in
//                m.centerX.centerY.equalToSuperview()
//            }
//
//            self.addSubview(barView)
//            barView.snp.makeConstraints { m in
//                m.left.equalTo(dayLabel.snp.left)
//                m.right.equalTo(dayLabel.snp.right)
//                m.bottom.equalToSuperview()
//                m.height.equalTo(4)
//            }
//        }
//
//        func setButton() {
//            self.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
//        }
//
////        override var isSelected: Bool {
////            didSet {
////                dayLabel.textColor = isSelected ? UIColor.tintColor : UIColor.black
////                barView.isHidden = isSelected ? false : true
////            }
////        }
//
//
//        @objc func didTapButton() {
//
//        }
//    }
//
//    let dayButton = button(text: "일간", tag: 0)
//    let weekButton = button(text: "주간", tag: 1)
//    let monthButton = button(text: "월간", tag: 2)
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.backgroundColor = .white
//
//        let buttonSpace = 100
//
//        self.addSubview(weekButton)
//        weekButton.snp.makeConstraints { m in
//            m.centerX.centerY.height.equalToSuperview()
//        }
//
//        self.addSubview(dayButton)
//        dayButton.snp.makeConstraints { m in
//            m.centerY.height.equalToSuperview()
//            m.centerX.equalToSuperview().offset(-buttonSpace)
//        }
//
//        self.addSubview(monthButton)
//        monthButton.snp.makeConstraints { m in
//            m.centerY.height.equalToSuperview()
//            m.centerX.equalToSuperview().offset(buttonSpace)
//        }
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}
//
//class RankingMenuBarCell: UITableViewCell {
//
//    static let identifier = "RankingMenuBarCell"
//
//
//
//    let customView = RankingMenuBarView()
//
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        contentView.backgroundColor = .systemGray6
//
//        configureUI()
//
//
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func configureUI() {
//        contentView.addSubview(customView)
//        customView.snp.makeConstraints { m in
//            m.height.equalTo(40)
//            m.left.right.top.equalToSuperview()
//        }
//
//
//    }
//}


import UIKit
import SnapKit

// MARK: - RankingMenuBar

class RankingMenuBar: UICollectionViewCell {
    
    // MARK: Properties
    static let identifier = "RankingMenuBar"
    
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
    
    // MARK: LIfecycle
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Helpers
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


// MARK: - RankingMenuBarCell

class RankingMenuBarCell: UITableViewCell {
        
    static let identifier = "RankingMenuBarCell"

    let labelNames = ["일간", "주간", "월간"]
        
    var menuBarView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        cv.register(RankingMenuBar.self, forCellWithReuseIdentifier: RankingMenuBar.identifier)
        return cv
    }()
    
    // MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
          
        contentView.backgroundColor = .systemGray6
        selectionStyle = .none
 
        configuerUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Helpers
    private func configuerUI() {
        // menuBar Cell이 들어갈 menuBarView (CollectionView 설정)
        contentView.addSubview(menuBarView)
        menuBarView.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.centerX.leading.trailing.equalTo(contentView)
            $0.top.equalTo(contentView)
        }
        
        menuBarView.delegate = self
        menuBarView.dataSource = self
        
        // InsightsView 화면 로딩시, MenuBar의 Cell이 일간을 Default로 되게끔 지정
//        let selectedIndexPath = IndexPath(item: 0, section: 0)
//        menuBarView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .bottom)
    }
}

//MARK: - UICollectionVIewDelegate, UICollectionViewDataSource

extension RankingMenuBarCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RankingMenuBar.identifier, for: indexPath) as! RankingMenuBar
        
        cell.menuLabel.text = labelNames[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuBar.identifier, for: indexPath) as! MenuBar
//        cell.menuLabel.textColor = .orange
        
        print(indexPath.row)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout - MenuBar Cell의 사이즈 조절

extension RankingMenuBarCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Double(menuBarView.frame.width / 3), height: Double(menuBarView.frame.height))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
