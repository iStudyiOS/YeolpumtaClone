//
//  StatisticsCell.swift
//  YeolpumtaClone
//
//  Created by 김태균 on 2021/06/20.
//

import UIKit
import SnapKit

class StatisticsCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "StatisticsCell"
    
    static var statisticsViewStatic: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        cv.register(Statistics.self, forCellWithReuseIdentifier: Statistics.identifier)
        return cv
    }()
    
    let statisticsView = statisticsViewStatic
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none

        configuerUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configuerUI() {
        contentView.addSubview(statisticsView)
        statisticsView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(contentView)
            $0.height.equalTo(400)
            $0.width.equalTo(contentView)
        }
        
        statisticsView.delegate = self
        statisticsView.dataSource = self
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        statisticsView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .bottom)
    }
}

//MARK: - UICollectionVIewDelegate, UICollectionViewDataSource

extension StatisticsCell: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Statistics.identifier, for: indexPath) as! Statistics
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout - Statistics Cell의 사이즈 조절

extension StatisticsCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: statisticsView.frame.width, height: statisticsView.frame.height)
    }
}
