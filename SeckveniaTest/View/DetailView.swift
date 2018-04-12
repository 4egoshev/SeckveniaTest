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

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        frame.size = CGSize(width: frame.width,
                            height: frame.height)
    }
    
    func configView(with film: Film, and image: UIImage?) {
        localizedNameLabel.text = film.localizedName
        nameLabel.text = film.name + " (\(film.year))"
        descriptionText.text = film.descriptionText
        resize(view: localizedNameLabel)
        resize(view: nameLabel)
        resize(view: descriptionText)
        
        let rating = film.rating
        config(rating: rating, for: ratingLabel)
        
        congigPoster(from: image)
    }
    
    func resizeDescritionText() {
        resize(view: descriptionText)
    }
    
    private func congigPoster(from image: UIImage?) {
        guard let poster = image else { return }
        posterImage.image = poster
        
        posterImage.layer.shadowColor = UIColor.black.cgColor
        posterImage.layer.shadowOffset = CGSize(width: 1, height: 2)
        posterImage.layer.shadowOpacity = 0.4
    }
    
    func estimateConentSize() -> CGSize {
        return CGSize(width: bounds.width, height: descriptionText.frame.origin.y + descriptionText.frame.height + 16)
    }
}
