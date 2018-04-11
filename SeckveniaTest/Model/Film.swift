//
//  Film.swift
//  SeckveniaTest
//
//  Created by Jake Walker on 09.04.2018.
//  Copyright © 2018 Aleksandr Chegoshev. All rights reserved.
//

import SwiftyJSON
import RealmSwift

class Film: Object {

    @objc dynamic var localizedName = ""
    @objc dynamic var name = ""
    @objc dynamic var year = 0
    @objc dynamic var rating = 0.0
    @objc dynamic var imageURL = ""
    @objc dynamic var descriptionText = ""
    
    convenience init? (json: JSON) {
        guard
            let localizedName = json["localized_name"].string,
            let name = json["name"].string,
            let year = json["year"].int,
            let rating = json["rating"].double,
            let imageURL = json["image_url"].string,
            let descriptionText = json["description"].string
        else {return nil}
        
        self.init()
        
        self.localizedName = localizedName
        self.name = name
        self.year = year
        self.rating = rating
        self.imageURL = imageURL
        self.descriptionText = descriptionText
    }
    
    override static func primaryKey() -> String? {
        return "name"
    }
}
