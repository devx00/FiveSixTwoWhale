//
//  WhaleCollectionViewCell.swift
//  FiveSixTwoInterview
//
//  Created by Zach Hanson on 1/26/21.
//

import UIKit

class WhaleCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "whale-cell-reuse-id"
    let containerView = UIView()
    let nameContainer = UIView()
    let nameLabel = UILabel()
    let whaleImageViewContainer = UIView()
    let whaleImageView = UIImageView()
    lazy var topConstraint: NSLayoutConstraint = whaleImageViewContainer.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16.0)
    lazy var bottomConstraint: NSLayoutConstraint = nameContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0)
    
    var whale: Whale? {
        didSet {
            self.nameLabel.text = whale?.name
            self.loadImage()
        }
    }
    var bgColor: UIColor? {
        didSet {
            containerView.backgroundColor = bgColor
        }
    }
    
    func setFullScreenMode(_ on: Bool) {
        // If in fullscreen portrait mode add extra padding to accomodate notch and swipe bar.
        let extraTop = on && !UIDevice.current.orientation.isLandscape
        self.topConstraint.constant = extraTop ? 48 : 16
        self.bottomConstraint.constant = extraTop ? -16 : 0
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes?) {
        self.layoutIfNeeded()
    }
    
    override func willTransition(from oldLayout: UICollectionViewLayout, to newLayout: UICollectionViewLayout) {
        self.setFullScreenMode(newLayout.isKind(of: QuizLayout.self))
        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
        
    }
    
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      configure()
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
}



extension WhaleCollectionViewCell {
    
    func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        whaleImageViewContainer.translatesAutoresizingMaskIntoConstraints = false
        whaleImageView.translatesAutoresizingMaskIntoConstraints = false
        nameContainer.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        nameContainer.addSubview(nameLabel)
        containerView.addSubview(nameContainer)
        whaleImageViewContainer.addSubview(whaleImageView)
        containerView.addSubview(whaleImageViewContainer)
        
        contentView.addSubview(containerView)
        
        nameLabel.textAlignment = .center
        
        whaleImageView.clipsToBounds = true
        whaleImageView.contentMode = .scaleAspectFit
        
        whaleImageViewContainer.layer.cornerRadius = 5
        whaleImageViewContainer.backgroundColor = .white
        
        
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            containerView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            topConstraint,
            whaleImageViewContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12.0),
            whaleImageViewContainer.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -24.0),
            whaleImageViewContainer.bottomAnchor.constraint(equalTo: nameContainer.topAnchor),
            nameContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            nameContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            bottomConstraint,
            nameContainer.heightAnchor.constraint(equalToConstant: 50.0),
            nameLabel.centerYAnchor.constraint(equalTo: nameContainer.centerYAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: nameContainer.centerXAnchor),
            whaleImageView.centerYAnchor.constraint(equalTo: whaleImageViewContainer.centerYAnchor),
            whaleImageView.centerXAnchor.constraint(equalTo: whaleImageViewContainer.centerXAnchor),
            whaleImageView.heightAnchor.constraint(lessThanOrEqualTo: whaleImageViewContainer.heightAnchor, multiplier: 1.0),
            whaleImageView.widthAnchor.constraint(lessThanOrEqualTo: whaleImageViewContainer.widthAnchor, multiplier: 1.0)
            
            
        ])
        
    }
    
    func loadImage() {
        whaleImageView.image = nil
        
        whale?.fetchImageDataAsync(completion: { (imageData) in
            DispatchQueue.main.async {
                if let imageData = imageData {
                    self.whaleImageView.image = UIImage(data: imageData)
                }
            }
        })
    }
}
