//
//  DetailRankingCell.swift
//  YeolpumtaClone
//
//  Created by minii on 2021/07/25.
//

import UIKit
import SnapKit

class DetailRankingCustomView: UIView {
    
    let rankLabel: UILabel = {
        let label = UILabel()
        label.text = "2"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .systemOrange
        return label
    }()
    
    let nickNameLabel: UILabel = {
        let label = UILabel()
        label.text = "아이디"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.textColor = .systemOrange
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "취업"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .systemOrange
        return label
    }()
    
    let progressBar: UIView = {
        let bar = UIView()
        bar.backgroundColor = .orange
        return bar
    }()
    
    let isStudyingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "square.and.arrow.up")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        
        self.addSubview(rankLabel)
        rankLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(40)
        }
        
        self.addSubview(nickNameLabel)
        nickNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(rankLabel.snp.right).offset(30)
        }
        
        self.addSubview(typeLabel)
        typeLabel.snp.makeConstraints {
            $0.left.equalTo(nickNameLabel.snp.left)
            $0.bottom.equalTo(nickNameLabel.snp.top).offset(-5)
        }
        
        self.addSubview(isStudyingImageView)
        isStudyingImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-40)
        }
        
        self.addSubview(timeLabel)
        timeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalTo(isStudyingImageView.snp.left).offset(-30)
        }
        
        self.addSubview(progressBar)
        progressBar.snp.makeConstraints {
            $0.left.equalTo(nickNameLabel.snp.left)
            $0.right.equalTo(timeLabel.snp.right)
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(5)
            $0.height.equalTo(3)
        }
    }
    
    
}

class DetailRanking: UICollectionViewCell {
    
    static let identifier = "DetailRanking"
    
    let customView = DetailRankingCustomView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        contentView.addSubview(customView)
        customView.frame = contentView.bounds
//        customView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: 100)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}



class DetailRankingCell: UITableViewCell {
    
    static let identifier = "DetailRankingCell"
    
    var DetailRankingView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        cv.register(DetailRanking.self, forCellWithReuseIdentifier: DetailRanking.identifier)
        cv.backgroundColor = .white
        return cv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        selectionStyle = .none
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.addSubview(DetailRankingView)
        DetailRankingView.snp.makeConstraints {
            $0.height.equalTo(300)
            $0.centerX.leading.trailing.top.equalTo(contentView)
        }
        
        DetailRankingView.delegate = self
        DetailRankingView.dataSource = self
    }
}


extension DetailRankingCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailRanking.identifier, for: indexPath) as! DetailRanking
        cell.customView.rankLabel.text = "\(indexPath.row + 1)"
        return cell
    }
    
}

extension DetailRankingCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
