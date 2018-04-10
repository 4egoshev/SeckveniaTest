//
//  DownloadManager.swift
//  SeckveniaTest
//
//  Created by Jake Walker on 11.04.2018.
//  Copyright © 2018 Aleksandr Chegoshev. All rights reserved.
//

import UIKit
import Alamofire

class DownloadManager {
    
    static let sharedInstance = DownloadManager()

    typealias DowloadImageComplition = (_ data: Data?) -> Void
    
    func dowloadImage(from url: String, complition: @escaping DowloadImageComplition) {
    
        Alamofire.request(url).responseData { response in
            guard let data = response.result.value else {
                complition(nil)
                return
            }
            complition(data)
        }
    }

}
