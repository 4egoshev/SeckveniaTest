//
//  DownloadManager.swift
//  SeckveniaTest
//
//  Created by Jake Walker on 11.04.2018.
//  Copyright © 2018 Aleksandr Chegoshev. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
import SwiftyJSON

class DownloadManager {
    
    static let sharedInstance = DownloadManager()

    typealias DownloadImageComplition = (_ data: Data?) -> Void
    typealias DownloadDataComplition = () -> Void
    
    func dowloadImage(from url: String, complition: @escaping DownloadImageComplition) {
        
        Alamofire.request(url).responseData { response in
            guard let data = response.result.value else {
                complition(nil)
                return
            }
            complition(data)
        }
    }
    
    func downloadData(complition: @escaping DownloadDataComplition) {
        //Имитация запроса на сервер и сохранение в БД
        parseJson()
        complition()
    }
    
    private func parseJson(){
        let path = Bundle.main.path(forResource: "Films", ofType: "json") as String!
        let jsonData = NSData(contentsOfFile: path!) as NSData!
        do {
            let jsonDict = try JSON(data: jsonData as Data!)
            let jsonArray = jsonDict["films"]
            for (_, item) in jsonArray {
                if let film = Film(json: item) {
                    save(film: film)
                }
            }
        } catch {
            print(error)
        }
    }
    
    private func save(film: Film) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(film, update: true )
            }
        } catch {
            debugPrint(error)
        }
    }
    
    func getData() -> [Film] {
        do {
            let realm = try Realm()
            let films = realm.objects(Film.self)
            return Array(films)
        } catch {
            debugPrint(error)
            return[]
        }
    }

}
