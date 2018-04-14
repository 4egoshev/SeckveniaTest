//
//  DownloadManager.swift
//  SeckveniaTest
//
//  Created by Jake Walker on 11.04.2018.
//  Copyright © 2018 Aleksandr Chegoshev. All rights reserved.
//

import Alamofire

class DownloadManager {
    
    static let sharedInstance = DownloadManager()

    typealias DownloadFilmsComplition = () -> Void
    
    func downloadFilms(complition: @escaping DownloadFilmsComplition) {
        //Имитация запроса на сервер
        ParseManager.sharedInstance.parseFilms()
        complition()
    }
    
}
