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
        addObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cell.changeContainerViewColor(isSelested: false)
        checkOrientation()
    }
    
    private func checkOrientation() {
        if UIDevice.current.orientation.isLandscape {
            detailView.resizeDescritionTex()
        }
        scrollView.contentSize = detailView.estimateConentSize()
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: .UIDeviceOrientationDidChange, object: nil)
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.tintColor = UIColor.white
    }

    private func setupView() {
        scrollView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        detailView = Bundle.main.loadNibNamed("DetailView", owner: self, options: nil)?.first as! DetailView
        scrollView.addSubview(detailView)
        detailView.configView(with: film, and: poster)
    }
    
    @objc func rotated() {
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            detailView.resizeDescritionTex()
        } else if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            detailView.resizeDescritionTex()
        }
        scrollView.contentSize = detailView.estimateConentSize()
    }
}

