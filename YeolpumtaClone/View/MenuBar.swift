//
//  MenuBar.swift
//  YeolpumtaClone
//
//  Created by 김태균 on 2021/06/18.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate {

    lazy var collectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .brown
        return cv
    }()
    
    let cellId = "cellId"
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        collectionview.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        self.collectionview.addSubview(collectionview)
        collectionview.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.width.equalTo(collectionview)
            $0.height.equalTo(40)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .brown
        return cell
    }
}
