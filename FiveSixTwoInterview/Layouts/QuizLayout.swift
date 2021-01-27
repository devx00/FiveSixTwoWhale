//
//  QuizLayout.swift
//  FiveSixTwoInterview
//
//  Created by Zach Hanson on 1/27/21.
//

import UIKit

class QuizLayout: UICollectionViewFlowLayout {
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
        
        let cellWidth = collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right
        let cellHeight = collectionView.bounds.height
        self.itemSize = CGSize(width: cellWidth, height: cellHeight)
        self.sectionInsetReference = .fromSafeArea
    }
    
}
