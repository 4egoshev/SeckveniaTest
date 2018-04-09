//
//  FilmsViewController.swift
//  SeckveniaTest
//
//  Created by Jake Walker on 09.04.2018.
//  Copyright © 2018 Aleksandr Chegoshev. All rights reserved.
//

import UIKit
import SwiftyJSON

class FilmsViewController: UITableViewController {
    
    var filmArray = [Film]()
    var sectionArray = [Int]()
    var rowArray = [Array<Film>]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var tempArray = [Int]()
        
        //создать ParseManager и возвращать тьюпл
        let path = Bundle.main.path(forResource: "Films", ofType: "json") as String!
        let jsonData = NSData(contentsOfFile: path!) as NSData!
        do {
            let jsonDict = try JSON(data: jsonData as Data!)
            let jsonArray = jsonDict["films"]
            for (_, item) in jsonArray {
                if let film = Film(json: item) {
                    filmArray.append(film)
                    tempArray.append(film.year)
                }
            }
            for yaer in tempArray {
                if !sectionArray.contains(yaer) {
                    sectionArray.append(yaer)
                }
            }
        } catch {
            print(error)
        }
        
        sectionArray.sort()
        
        for section in sectionArray {
            var tempArray = filmArray.filter({ $0.year == section })
            tempArray.sort(by: { $0.rating > $1.rating })
            rowArray.append(tempArray)
        }
        //
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowArray[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let array = rowArray[indexPath.section]
        cell.textLabel?.text = String(array[indexPath.row].name)
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = UIColor.gray
        let year = UILabel()
        year.translatesAutoresizingMaskIntoConstraints = false
        year.text = String(sectionArray[section])
        header.addSubview(year)
        
        year.leftAnchor.constraint(equalTo: header.leftAnchor, constant: 8).isActive = true
        year.heightAnchor.constraint(equalToConstant: 40).isActive = true
        year.widthAnchor.constraint(equalToConstant: 100).isActive = true
        year.centerYAnchor.constraint(equalTo: header.centerYAnchor).isActive = true
        return header
    }

}
