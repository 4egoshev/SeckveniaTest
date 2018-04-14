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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupView()
        addObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cell.changeContainerViewColor(isSelected: false)
        detailView.resizeDescriptionText()
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: .UIDeviceOrientationDidChange, object: nil)
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.tintColor = UIColor.white
    }

    private func setupView() {
        detailView = Bundle.main.loadNibNamed("DetailView", owner: self, options: nil)?.first as! DetailView
        detailView.add(to: scrollView)
        detailView.configView(with: film)
    }
    
    @objc func rotated() {
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            detailView.resizeDescriptionText()
        } else if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            detailView.resizeDescriptionText()
        }
    }
}

