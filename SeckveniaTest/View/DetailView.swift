//
//  DetailView.swift
//  SeckveniaTest
//
//  Created by Jake Walker on 11.04.2018.
//  Copyright © 2018 Aleksandr Chegoshev. All rights reserved.
//

import UIKit

class DetailView: UIView {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var localizedNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    
    func add(to view:UIView) {
        view.addSubview(self)
        
        leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func configView(with film: Film) {
        localizedNameLabel.text = film.localizedName
        nameLabel.text = film.name + " (\(film.year))"
        descriptionText.text = film.descriptionText
        resize(view: localizedNameLabel)
        resize(view: nameLabel)
        resize(view: descriptionText)
        
        let rating = film.rating
        config(rating: rating, for: ratingLabel)
        
        posterImage.af_setImage(withURL: URL(string: film.imageURL)!)
        configPoster()
    }
    
    func resizeDescriptionText() {
        resize(view: descriptionText)
        estimateFrame()
    }
    
    private func configPoster() {
        posterImage.layer.shadowColor = UIColor.black.cgColor
        posterImage.layer.shadowOffset = CGSize(width: 1, height: 2)
        posterImage.layer.shadowOpacity = 0.4
    }
    
    private func estimateFrame() {
        frame.size = CGSize(width: bounds.width,
                            height: descriptionText.frame.origin.y + descriptionText.frame.height + 16)
    }
}
