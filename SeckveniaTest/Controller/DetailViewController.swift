//
//  ViewController.swift
//  SeckveniaTest
//
//  Created by Jake Walker on 09.04.2018.
//  Copyright © 2018 Aleksandr Chegoshev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var cell = FilmCell()
    var detailView = DetailView()
    
    var film = Film()
    var poster: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cell.changeContainerViewColor(isSelested: false)
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.tintColor = UIColor.white
    }

    private func setupView() {
        detailView = Bundle.main.loadNibNamed("DetailView", owner: self, options: nil)?.first as! DetailView
        scrollView.addSubview(detailView)
        detailView.configView(with: film, and: poster)
//        scrollView.contentSize = detailView.estimateConentSize()
        scrollView.contentSize = detailView.frame.size
        scrollView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
    }


}

