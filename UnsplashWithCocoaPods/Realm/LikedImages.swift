//
//  LikedImages.swift
//  UnsplashWithCocoaPods
//
//  Created by Igor Polousov on 06.01.2023.
//

import UIKit

class DataToLikedImages {
    static var dataToLikedImages: [ImageDataFromRealm] = []
}


struct ImageDataFromRealm {
    var id: String
    var name: String
    var image: UIImage
    var createDate: String
}
