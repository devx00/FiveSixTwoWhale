//
//  ViewController.swift
//  FiveSixTwoInterview
//
//  Created by Zach Hanson on 1/26/21.
//

import UIKit

class MainViewController: UICollectionViewController {
    var whales: [Whale] = Whale.allWhales()
    var colors = [
        UIColor(red: 52/255, green: 199/255, blue: 89/255, alpha: 1),
        UIColor(red: 1, green: 149/255, blue: 0, alpha: 1),
        UIColor(red: 1, green: 59/255, blue: 48/255, alpha: 1),
        UIColor(red: 175/255, green: 82/255, blue: 222/255, alpha: 1)
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(WhaleCollectionViewCell.self, forCellWithReuseIdentifier: WhaleCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.contentInsetAdjustmentBehavior = .never
        
    }
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionViewLayout.invalidateLayout()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func changeLayout() {
        
        if collectionView.collectionViewLayout.isKind(of: GridLayout.self) {
            self.collectionView.setCollectionViewLayout(QuizLayout(), animated: true)
        } else {
            self.collectionView.setCollectionViewLayout(GridLayout(), animated: true)
        }
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        changeLayout()
    }

}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return whales.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WhaleCollectionViewCell.reuseIdentifier, for: indexPath) as! WhaleCollectionViewCell
        cell.whale = whales[indexPath.item]
        cell.bgColor = colors[indexPath.item % colors.count]
        cell.setFullScreenMode(collectionView.collectionViewLayout.isKind(of: QuizLayout.self))
        
        return cell
    }
}
