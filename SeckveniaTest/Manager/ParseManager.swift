//
//  ParseManager.swift
//  SeckveniaTest
//
//  Created by Jake Walker on 14.04.2018.
//  Copyright © 2018 Aleksandr Chegoshev. All rights reserved.
//

import SwiftyJSON

class ParseManager {
    
    static let sharedInstance = ParseManager()
    
    func parseFilms() {
        let path = Bundle.main.path(forResource: "Films", ofType: "json") as String!
        let jsonData = NSData(contentsOfFile: path!) as NSData!
        do {
            let jsonDict = try JSON(data: jsonData as Data!)
            let jsonArray = jsonDict["films"]
            for (_, item) in jsonArray {
                if let film = Film(json: item) {
                    DataBaseManager.sharedInstance.save(film: film)
                }
            }
        } catch {
            print(error)
        }
    }

}
