//
//  DetailViewController.swift
//  UnsplashWithCocoaPods
//
//  Created by Igor Polousov on 06.01.2023.
//

import UIKit

class DetailViewController: UIViewController {
    let imageView = UIImageView()
    let authorNameLabel = UILabel()
    let createDateLable = UILabel()
    let placeLabel = UILabel()
    let downloadsLabel = UILabel()
    
    var imageToSave: ResultsLoadedImages?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        view.addSubview(authorNameLabel)
        view.addSubview(createDateLable)
        view.addSubview(placeLabel)
        view.addSubview(downloadsLabel)
        authorNameLabel.font = UIFont(name: "chalkduster", size: 15)
        authorNameLabel.textColor = .systemRed
        authorNameLabel.textAlignment = .right
        createDateLable.font = UIFont(name: "chalkduster", size: 14)
        createDateLable.textColor = .systemRed
        createDateLable.textAlignment = .right
        placeLabel.font = UIFont(name: "chalkduster", size: 20)
        placeLabel.textColor = .systemRed
        placeLabel.textAlignment = .right
        downloadsLabel.font = UIFont(name: "chalkduster", size: 20)
        downloadsLabel.textColor = .systemRed
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addImageToLiked))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
    }
    
    @objc func addImageToLiked() {
        if let imageToSave {
            APISession.shared.likedImages.append(imageToSave)
            RealmLikedImages.transferData()
            RealmLikedImages.addObjectsToRealmDataBase()
        }
        
        let ac = UIAlertController(title: "The Image added to liked", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(ac, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        authorNameLabel.frame = CGRect(x: 190, y: 680, width: 200, height: 30)
        createDateLable.frame = CGRect(x: 190, y: 700, width: 200, height: 30)
        placeLabel.frame = CGRect(x: 190, y: 720, width: 200, height: 30)
        downloadsLabel.frame = CGRect(x: 190, y: 740, width: 200, height: 30)
    }
}

