//
//  DataBaseManager.swift
//  SeckveniaTest
//
//  Created by Jake Walker on 14.04.2018.
//  Copyright © 2018 Aleksandr Chegoshev. All rights reserved.
//

import RealmSwift

class DataBaseManager {
    
    static let sharedInstance = DataBaseManager()
    
    //MARK: - Save

    func save(film: Film) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(film, update: true)
            }
        } catch {
            debugPrint(error)
        }
    }
    
    //MARK: - Get
    
    func getFilteredArraysForTop() -> (yearArray: [Int], filmArray: [Array<Film>]) {
        let films = getFilms()
        let tuple = FilterManager.sharedInstance.filterArraysForYearTop(from: films)
        return tuple
    }
    
    private func getFilms() -> [Film] {
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
