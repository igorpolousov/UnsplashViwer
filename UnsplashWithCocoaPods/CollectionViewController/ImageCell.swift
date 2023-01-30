//
//  ImageCell.swift
//  UnsplashWithCocoaPods
//
//  Created by Igor Polousov on 06.01.2023.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
   static let cellID = "ImageCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
   
    override func layoutSubviews() {
        imageView.frame = CGRect(x: 10, y: 10, width: contentView.frame.size.width - 10, height: contentView.frame.size.height - 10)
    }
}
