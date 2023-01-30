//
//  MainViewController.swift
//  UnsplashWithCocoaPods
//
//  Created by Igor Polousov on 06.01.2023.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupVCs()
     
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }
    
    func setupVCs() {
          viewControllers = [
              createNavController(for: CollectionViewController(), title: NSLocalizedString("Random images", comment: ""), image: UIImage(systemName: "cube.transparent")!),
              createNavController(for: TableViewController(), title: NSLocalizedString("Liked Images", comment: ""), image: UIImage(systemName: "archivebox")!)
          ]
      }
}
