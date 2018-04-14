//
//  FilmsViewController.swift
//  SeckveniaTest
//
//  Created by Jake Walker on 09.04.2018.
//  Copyright © 2018 Aleksandr Chegoshev. All rights reserved.
//

import UIKit
import SwiftyJSON
import AlamofireImage

class FilmsViewController: UITableViewController {
    
    let cellIdentifier = "film_cell"
    let segueIdentifier = "to_detail"
    
    var selectedCell = FilmCell()
    
    var sectionArray = [Int]()
    var contentArray = [Array<Film>]()

    override func viewDidLoad() {
        super.viewDidLoad()
        downloadData()
        setupNavBar()
        setupTableView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        selectedCell.changeContainerViewColor(isSelected: false)
    }
    
    //MARK: - Content
    
    private func downloadData() {
        DownloadManager.sharedInstance.downloadFilms {
            self.sectionArray = DataBaseManager.sharedInstance.getFilteredArraysForTop().yearArray
            self.contentArray = DataBaseManager.sharedInstance.getFilteredArraysForTop().filmArray
        }
    }

    //MARK: - View
    
    private func setupNavBar() {
        navigationController?.navigationBar.barTintColor = UIColor.orange
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white,
                                                                   NSAttributedStringKey.font: UIFont.systemFont(ofSize: 21, weight: .bold)]
    }
    
    private func setupTableView() {
        tableView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        tableView.register(UINib(nibName: "FilmCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }

    // MARK: - TableView DataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentArray[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FilmCell
        let rowArray = contentArray[indexPath.section]
        cell.configCell(from: rowArray, with: indexPath)
        return cell
    }
    
    // MARK: - TableView Delegate
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as! HeaderView
        header.config(with: sectionArray[section])
        return header
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = tableView.cellForRow(at: indexPath) as! FilmCell
        selectedCell.changeContainerViewColor(isSelected: true)
        performSegue(withIdentifier: segueIdentifier, sender: indexPath)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            let detailViewController = segue.destination as! DetailViewController
            let indexPath = sender as! IndexPath
            detailViewController.film = contentArray[indexPath.section][indexPath.row]
        }
    }
                                                                                                                                                     
}
