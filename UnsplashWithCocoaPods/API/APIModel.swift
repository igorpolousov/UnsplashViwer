//
//  APIModel.swift
//  UnsplashWithCocoaPods
//
//  Created by Igor Polousov on 06.01.2023.
//

import UIKit

struct ApiResponse: Codable {
    let results: [ResultResponse]
}

struct ResultResponse: Codable {
    var id: String
    var urls: Urls
    var user: User
    var created_at: String
}

struct Urls: Codable {
    var regular: String
}

struct User: Codable {
    var name: String
}

struct ResultsLoadedImages {
    var id: String
    var image: Data
    var userName: String
    var created_at: String
}
