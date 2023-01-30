//
//  TableViewController.swift
//  UnsplashWithCocoaPods
//
//  Created by Igor Polousov on 06.01.2023.
//

import UIKit
import RealmSwift

class TableViewController: UIViewController {
    
    let tableView = UITableView()
    var realmObserver: Results<RealmLikedImages>?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        RealmLikedImages.realmLikedImagesArray = []
        realmObserver =  RealmLikedImages.fetchDataFromRealm()
        RealmLikedImages.transferDataToArrayForTable(realmObserver!)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .systemRed
        view.addSubview(tableView)
        tableView.backgroundColor = .lightGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.cellReuseID)
         
        realmObserver =  RealmLikedImages.fetchDataFromRealm()
        RealmLikedImages.transferDataToArrayForTable(realmObserver!)
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataToLikedImages.dataToLikedImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellReuseID, for: indexPath) as! TableViewCell
        cell.myImageView.image = DataToLikedImages.dataToLikedImages[indexPath.row].image
        cell.lableView.text = DataToLikedImages.dataToLikedImages[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailViewController()
        vc.imageView.image = DataToLikedImages.dataToLikedImages[indexPath.row].image
        vc.createDateLable.text = DataToLikedImages.dataToLikedImages[indexPath.row].createDate
        vc.authorNameLabel.text = DataToLikedImages.dataToLikedImages[indexPath.row].name
        //        vc.placeLabel.text = likedImages[indexPath.row].place
        //        vc.downloadsLabel.text = "DownLoads \(mockImages[indexPath.row].downloads)"
        navigationController?.pushViewController(vc, animated: true)
    }
    
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let ac = UIAlertController(title: "Delete image?", message: "Are you shure you want ot delete image?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            ac.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
                let imageToDelete = DataToLikedImages.dataToLikedImages[indexPath.row]
                RealmLikedImages.deleteObjectFromRealmDataBase(imageToDelete)
                DataToLikedImages.dataToLikedImages.remove(at: indexPath.row)
                tableView.reloadData()
            }))
            ac.addAction(cancelAction)
            present(ac,animated: true)
        }
    }
}


