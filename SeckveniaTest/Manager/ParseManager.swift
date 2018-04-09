//
//  ParseManager.swift
//  SeckveniaTest
//
//  Created by Jake Walker on 10.04.2018.
//  Copyright © 2018 Aleksandr Chegoshev. All rights reserved.
//

import Foundation
import SwiftyJSON

class ParseManager: NSObject {
    
    static let sharedInstance = ParseManager()
    
    func createArrays() -> (sectionArray: [Int], rowArray: [Array<Film>]) {
        let films = parseJson().films
        let years = parseJson().years
        let yaerArray = createYaerArray(from: years)
        let filmArray = creteFilmArray(from: films, and: yaerArray)
        return (yaerArray,filmArray)
    }
    
    private func parseJson() -> (films: [Film], years: [Int]) {
        var films = [Film]()
        var years = [Int]()
        let path = Bundle.main.path(forResource: "Films", ofType: "json") as String!
        let jsonData = NSData(contentsOfFile: path!) as NSData!
        do {
            let jsonDict = try JSON(data: jsonData as Data!)
            let jsonArray = jsonDict["films"]
            for (_, item) in jsonArray {
                if let film = Film(json: item) {
                    films.append(film)
                    years.append(film.year)
                }
            }
        } catch {
            print(error)
        }
        return (films,years)
    }
    
    private func createYaerArray(from yaers: [Int]) -> [Int] {
        var array = [Int]()
        for year in yaers {
            if !array.contains(year) {
                array.append(year)
            }
        }
        array.sort()
        return array
    }
    
    private func creteFilmArray(from films: [Film], and yearArray: [Int]) -> [Array<Film>] {
        var array = [Array<Film>]()
        for year in yearArray {
            var tempArray = films.filter({ $0.year == year })
            tempArray.sort(by: { $0.rating > $1.rating })
            array.append(tempArray)
        }
        return array
    }
}
