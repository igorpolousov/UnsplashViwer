//
//  TableViewCell.swift
//  UnsplashWithCocoaPods
//
//  Created by Igor Polousov on 06.01.2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let cellReuseID = "TableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: TableViewCell.cellReuseID)
        contentView.addSubview(myImageView)
        contentView.backgroundColor = .lightGray
        contentView.addSubview(lableView)
        myImageView.clipsToBounds = true
        myImageView.contentMode = .scaleToFill
        myImageView.layer.cornerRadius = 30
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let myImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    let lableView: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "chalkduster", size: 18)
        return label
    }()
    
    override func layoutSubviews() {
        myImageView.frame = CGRect(x: 5, y: 5, width: 60, height: 60)
        lableView.frame = CGRect(x: 75, y: 10, width: 200, height: 40)
    }
}

