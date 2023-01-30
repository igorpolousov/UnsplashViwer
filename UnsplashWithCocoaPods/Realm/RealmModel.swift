//
//  RealmModel.swift
//  UnsplashWithCocoaPods
//
//  Created by Igor Polousov on 06.01.2023.
//

import UIKit
import RealmSwift

// 1.  Realm object class

class RealmLikedImages: Object, Codable {
    
    override init() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    }
    
    @objc dynamic var id: String = ""
    @objc dynamic var createdDate:String = ""
    @objc dynamic var userName: String = ""
    @objc dynamic var image: Data?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    
    // 2. Realm objects array
    static var realmLikedImagesArray: [RealmLikedImages] = []
    
    // 3. Transfer data to realm array
    static func transferData() {
            guard !APISession.shared.likedImages.isEmpty else {return}
            let a = RealmLikedImages()
            for image in APISession.shared.likedImages {
                a.id = image.id
                a.createdDate = image.created_at
                a.userName = image.userName
                a.image = image.image
            }
            realmLikedImagesArray.append(a)
    }
    
    // 4. Adding objects to Realm DataBase
    static func addObjectsToRealmDataBase() {
        let realmData = List<RealmLikedImages>()
        print("REALM ARRAY add")
        print(realmLikedImagesArray.count)
        for object in realmLikedImagesArray {
            realmData.append(object)
        }
        
        do {
            let realm = try Realm()
            realm.beginWrite()
            //let imageFromRealm = realm.objects(RealmLikedImages.self)
            //realm.delete(imageFromRealm)
            realm.add(realmData)
            try realm.commitWrite()
            print("REALM DATA")
            print(realm.configuration.fileURL as Any)
        } catch {
            print("ERROR REALM")
            print(error.localizedDescription)
        }
    }
    
    
    // 5. Fetching data from from Realm data Base
    static func fetchDataFromRealm() -> Results<RealmLikedImages> {
        var observerArray: Results<RealmLikedImages>!
        do {
            let realm = try Realm()
            let realmObserver = realm.objects(RealmLikedImages.self)
            observerArray = realmObserver
            
        } catch {
            print(error.localizedDescription)
        }
        return observerArray
    }
    
    // 5.1 Transfer data to table array
    static func transferDataToArrayForTable(_ realmArray: Results<RealmLikedImages>) {
        DataToLikedImages.dataToLikedImages.removeAll()
        for data in realmArray {
            var b = ImageDataFromRealm(id: "", name: "", image: UIImage(), createDate: "")
            b.name = data.userName
            b.id = data.id
            b.createDate = data.createdDate
            if let data = data.image {
                if let image = UIImage(data: data) {
                    b.image = image
                }
            }
            DataToLikedImages.dataToLikedImages.append(b)
        }
    }
    
    // 6. Deleting objects from Realm Data Base
    static func deleteObjectFromRealmDataBase(_ object: ImageDataFromRealm) {
        
        do {
            let realm = try Realm()
            try realm.write {
                let objectsToDelete = realm.objects(RealmLikedImages.self).where {
                    $0.id == object.id
                }
                realm.delete(objectsToDelete)
            }
            //try realm.commitWrite()
            print("REALM DATA DELETE")
            print(realm.configuration.fileURL as Any)
        } catch {
            print("ERROR REALM DELETE")
            print(error.localizedDescription)
        }
    }
}

