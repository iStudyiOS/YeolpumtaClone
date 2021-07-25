//
//  TopThreeRankingCell.swift
//  YeolpumtaClone
//
//  Created by minii on 2021/07/25.
//

import UIKit
import SnapKit

// MARK:- TopThreeRanking

class TopThreeRanking: UICollectionViewCell {
    
    static let identifier = "TopThreeRanking"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "square.and.arrow.up")
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.textColor = .systemOrange
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.centerX.equalTo(contentView)
            $0.width.height.equalTo(contentView.frame.height/2)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.centerX.equalTo(contentView)
            $0.centerY.equalTo(contentView).offset(contentView.frame.height/4)
        }
        
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints {
            $0.centerX.equalTo(contentView)
            $0.centerY.equalTo(nameLabel.snp.centerY).offset(contentView.frame.height/6)
        }
        
    }
}


// MARK:- TopThreeRankingCell

class TopThreeRankingCell: UITableViewCell {
    
    static let identifier = "TopThreeRankingCell"
    
    let nameLabels = ["1번", "2번", "3번"]
    let timeLabels = ["11:11:11", "22:22:22", "33:33:33"]
    
    var topThreeRankingView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        cv.register(TopThreeRanking.self, forCellWithReuseIdentifier: TopThreeRanking.identifier)
        cv.backgroundColor = .white
        return cv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemGray6
        selectionStyle = .none
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        
        contentView.addSubview(topThreeRankingView)
        topThreeRankingView.snp.makeConstraints {
            $0.height.equalTo(200)
            $0.centerX.leading.trailing.top.equalTo(contentView)
        }
        
        topThreeRankingView.delegate = self
        topThreeRankingView.dataSource = self
        
    }
}

extension TopThreeRankingCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopThreeRanking.identifier, for: indexPath) as! TopThreeRanking
        
        cell.nameLabel.text = nameLabels[indexPath.row]
        cell.timeLabel.text = timeLabels[indexPath.row]
        
        return cell
    }
}

extension TopThreeRankingCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: topThreeRankingView.frame.width/4, height: topThreeRankingView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    // collectionview center horizontally
    // https://stackoverflow.com/questions/34267662/how-to-center-horizontally-uicollectionview-cells/65958390
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let totalCellWidth: CGFloat = (topThreeRankingView.frame.width/4)*3
        let totalSpacingWidth: CGFloat = 10*2
        
        let leftInset = (contentView.frame.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    
}
