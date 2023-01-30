//
//  CollectionViewController.swift
//  UnsplashWithCocoaPods
//
//  Created by Igor Polousov on 06.01.2023.
//

import UIKit

class CollectionViewController: UIViewController  {
    
    let searchController: UISearchController = UISearchController()
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        //searchController.searchResultsUpdater = self
        navigationController?.navigationBar.tintColor = .systemRed
        createCollectionView()
        APISession.shared.fetchData(query: "trees", view: collectionView)
    }
    
    
    func createCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (view.frame.size.width / 2) - 8, height: view.frame.size.height / 3.5)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset.right = CGFloat(10)
        //layout.sectionInset.left = CGFloat(10)
        layout.sectionInset.top = CGFloat(10)
        layout.sectionInset.bottom = CGFloat(10)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .lightGray
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.cellID)
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
    }
    
}


extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return APISession.shared.resultsLoadedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.cellID, for: indexPath) as! ImageCell
        
//        if let url = URL(string: APISession.shared.resultsl[indexPath.item].urls.regular) {
//            DispatchQueue.global().async {
//                if let data = try? Data(contentsOf: url) {
//                    let image = UIImage(data: data)
//                    DispatchQueue.main.sync {
//                        cell.imageView.image = image
//                    }
//                }
//            }
//        }
        let data = APISession.shared.resultsLoadedImages[indexPath.row].image
        cell.imageView.image = UIImage(data: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        //        if let url = URL(string: APISession.shared.results[indexPath.item].urls.regular) {
        //            DispatchQueue.global().async {
        //                if let data = try? Data(contentsOf: url) {
        //                    DispatchQueue.main.async {
        //                        let image = UIImage(data: data)
        //                        vc.imageView.image = image
        //                    }
        //                }
        //            }
        let data = APISession.shared.resultsLoadedImages[indexPath.row].image
        vc.imageView.image = UIImage(data: data)
        vc.imageToSave = APISession.shared.resultsLoadedImages[indexPath.item]
        vc.authorNameLabel.text = APISession.shared.resultsLoadedImages[indexPath.item].userName
        vc.createDateLable.text = APISession.shared.resultsLoadedImages[indexPath.item].created_at
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension CollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.resignFirstResponder()
        guard let text = searchBar.text else {return}
        APISession.shared.resultsLoadedImages = []
        APISession.shared.fetchData(query: text, view: collectionView)
    }
    
}

