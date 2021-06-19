//
//  StatisticsCell.swift
//  YeolpumtaClone
//
//  Created by 김태균 on 2021/06/18.
//

import UIKit
import SnapKit


class StatisticsCell: UITableViewCell {
        
    static let identifier = "StatisticsCell"

    let labelNames = ["일간", "주간", "월간"]
    
    lazy var menuBarView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        cv.register(MenuBar.self, forCellWithReuseIdentifier: "MenuBar")
        return cv
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
          
        contentView.backgroundColor = .systemGray6
        selectionStyle = .none
 
        // menuBar Cell이 들어갈 menuBarView (CollectionView 설정)
        contentView.addSubview(menuBarView)
        menuBarView.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.centerX.equalTo(contentView)
            $0.top.equalTo(contentView).offset(10)
            $0.leading.equalTo(contentView)
            $0.trailing.equalTo(contentView)
        }
        
        menuBarView.delegate = self
        menuBarView.dataSource = self
        
        // InsightsView 화면 로딩시, MenuBar의 Cell이 일간을 Default로 되게끔 지정
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        menuBarView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .bottom)
    } 
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UICollectionVIewDelegate, UICollectionViewDataSource

extension StatisticsCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuBar", for: indexPath) as! MenuBar
        
        cell.staisticsLabel.text = labelNames[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuBar", for: indexPath) as! MenuBar
        cell.staisticsLabel.textColor = .orange
        print("Updating,,,")
    }
}

// MARK: - UICollectionViewDelegateFlowLayout - MenuBar Cell의 사이즈 조절

extension StatisticsCell: UICollectionViewDelegateFlowLayout {
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

