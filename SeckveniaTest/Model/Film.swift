//
//  Film.swift
//  SeckveniaTest
//
//  Created by Jake Walker on 09.04.2018.
//  Copyright © 2018 Aleksandr Chegoshev. All rights reserved.
//

import UIKit
import SwiftyJSON

class Film: NSObject {

    var localizedName = ""
    var name = ""
    var year = 0
    var rating = 0.0
    var imageURL = ""
    var descriptText = ""
    
    convenience init? (json: JSON) {
        guard
            let localizedName = json["localized_name"].string,
            let name = json["name"].string,
            let year = json["year"].int,
            let rating = json["rating"].double,
            let imageURL = json["image_url"].string,
            let descriptText = json["description"].string
        else {return nil}
        
        self.init()
        
        self.localizedName = localizedName
        self.name = name
        self.year = year
        self.rating = rating
        self.imageURL = imageURL
        self.descriptText = descriptText
        
    }
}
