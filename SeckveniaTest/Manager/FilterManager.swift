//
//  FilterManager.swift
//  SeckveniaTest
//
//  Created by Jake Walker on 14.04.2018.
//  Copyright © 2018 Aleksandr Chegoshev. All rights reserved.
//

class FilterManager {
    
    static let sharedInstance = FilterManager()
    
    //MARK: - Filter for year top
    
    func filterArraysForYearTop(from films: [Film]) -> (yearArray: [Int], filmArray: [Array<Film>]) {
        var years = [Int]()
        for film in films {
        years.append(film.year)
        }
        let yearArray = createYaerArray(from: years)
        let filmArray = createFilmArray(from: films, and: yearArray)
        return (yearArray,filmArray)
    }
    
    private func createYaerArray(from yaers: [Int]) -> [Int] {
        var yearArray = [Int]()
        for year in yaers {
            if !yearArray.contains(year) {
                yearArray.append(year)
            }
        }
        return yearArray.sorted()
    }
    
    private func createFilmArray(from films: [Film], and years: [Int]) -> [Array<Film>] {
        var filmArray = [Array<Film>]()
        for year in years {
            var tempArray = films.filter({ $0.year == year })
            tempArray.sort(by: { $0.rating > $1.rating })
            filmArray.append(tempArray)
        }
        return filmArray
    }

}
