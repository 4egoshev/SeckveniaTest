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
    
    var sectionArray = [Int]()
    var rowArray = [Array<Film>]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupContent()
    }
    
    private func setupContent() {
        sectionArray = ParseManager.sharedInstance.createArrays().sectionArray
        rowArray = ParseManager.sharedInstance.createArrays().rowArray
    }

    // MARK: - UITableViewDataSource
    
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
    
    // MARK: - UITableViewDelegate
    
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
