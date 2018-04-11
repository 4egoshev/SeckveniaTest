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
        setupNavBar()
        setupContent()
        setupTableView()
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.barTintColor = UIColor.orange
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white,
                                                                   NSAttributedStringKey.font: UIFont.systemFont(ofSize: 21, weight: .bold)]
    }
    
    private func setupContent() {
        sectionArray = ParseManager.sharedInstance.createArrays().sectionArray
        rowArray = ParseManager.sharedInstance.createArrays().rowArray
    }
    
    private func setupTableView() {
        tableView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        tableView.register(UINib(nibName: "FilmCell", bundle: nil), forCellReuseIdentifier: "film_cell")
    }

    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowArray[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "film_cell", for: indexPath) as! FilmCell
        let array = rowArray[indexPath.section]
        DownloadManager.sharedInstance.dowloadImage(from: array[indexPath.row].imageURL) { (data) in
            cell.setPoster(with: data)
        }
        cell.configCell(from: array, with: indexPath)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as! HeaderView
        header.config(with: sectionArray[section])
        return header
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FilmCell
        cell.changeContainerViewColor(isSelested: true)
        performSegue(withIdentifier: "to_detail", sender: indexPath)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "to_detail" {
            let detailViewController = segue.destination as! DetailViewController
            let indexPath = sender as! IndexPath
            let cell = tableView.cellForRow(at: indexPath) as!FilmCell
            
            detailViewController.cell = cell
            detailViewController.film = rowArray[indexPath.section][indexPath.row]
            detailViewController.poster = cell.posterImage.image
        }
        
    }
                                                                                                                                                     
}
