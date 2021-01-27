//
//  GridLayout.swift
//  FiveSixTwoInterview
//
//  Created by Zach Hanson on 1/26/21.
//

import UIKit

class GridLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        
        let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
        let cellWidth = (availableWidth / 2).rounded(.down)
        let insetMargins = UIEdgeInsets(top: collectionView.layoutMargins.top, left: collectionView.layoutMargins.left, bottom: 0, right: collectionView.layoutMargins.right)
        let cellHeight = (collectionView.bounds.inset(by: insetMargins).height / 2).rounded(.down)
        self.itemSize = CGSize(width: cellWidth, height: cellHeight)
        self.sectionInset = UIEdgeInsets(top: self.minimumInteritemSpacing, left: 0.0, bottom: 0.0, right: 0.0)
        self.sectionInsetReference = .fromSafeArea
    }
}
