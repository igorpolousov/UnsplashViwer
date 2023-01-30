//
//  APIData.swift
//  UnsplashWithCocoaPods
//
//  Created by Igor Polousov on 06.01.2023.
//

import UIKit

final class APISession {
    static let shared = APISession()
    var results: [ResultResponse] = []
    var likedImages: [ResultsLoadedImages] = []
    var resultsLoadedImages: [ResultsLoadedImages] = []
    
    let accessKey = "PAtPIfZt8GEaDguqFikINPk508DCK61tMCc7mj-k8YY"
    let secretKey = "x-83Ie8ZGdvwylRzDqVyAJKv6W_uAL7b-CltGo05tl8"
    
    func fetchData(query: String, view: UICollectionView? = nil) {
        let urlString = "https://api.unsplash.com/search/photos?page=1&per_page=10&query=\(query)&client_id=\(accessKey)"
        guard let url = URL(string: urlString) else {return}
        let request = URLRequest(url: url)
       URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {return}
            if let json = try? JSONDecoder().decode(ApiResponse.self, from: data) {
                // Transfer data to required format
                APISession.shared.results = json.results
                for dataObject in APISession.shared.results {
                    var a =  ResultsLoadedImages(id: "", image: Data(), userName: "", created_at: "")
                    a.id = dataObject.id
                    a.userName = dataObject.user.name
                    a.created_at = dataObject.created_at
                    if let url = URL(string: dataObject.urls.regular) {
                        if let data = try? Data(contentsOf: url) {
                            a.image = data
                        }
                    }
                    self.resultsLoadedImages.append(a)
                }
                DispatchQueue.main.async {
                    if let view{
                        view.reloadData()
                    }
                }
            }
       }.resume()
    }
}
