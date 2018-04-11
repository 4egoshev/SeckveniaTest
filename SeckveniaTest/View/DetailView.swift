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
    
    private var localizedNameHeight: NSLayoutConstraint?
    private var nameHeight: NSLayoutConstraint?
    private var descriptionHeight: NSLayoutConstraint?

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        frame.size = CGSize(width: frame.width,
                            height: frame.height)
    }
    
    func configView(with film: Film, and image: UIImage?) {
        let localizedName = film.localizedName
        let name = film.name + " (\(film.year))"
        let description = film.descriptionText
        let rating = film.rating
        
        config(localizedName: localizedName, name: name, description: description)
        config(rating: rating)
        
        guard let poster = image else { return }
        posterImage.image = poster
    }
    
    private func config(localizedName: String, name: String, description: String) {
        localizedNameHeight?.constant = estimateFrame(for: localizedName, with: 17).height+4
        nameHeight?.constant = estimateFrame(for: name, with: 14).height+4
        descriptionHeight?.constant = estimateFrame(for: description, with: 14).height+4

        localizedNameHeight?.isActive = true
        nameHeight?.isActive = true
        descriptionHeight?.isActive = true
        
        localizedNameLabel.text = localizedName
        nameLabel.text = name
        descriptionText.text = description
    }
    
    private func estimateFrame(for text: String, with textSize: CGFloat) -> CGRect {
        let size = CGSize(width: bounds.width/2, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size,
                                                   options: options,
                                                   attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: textSize)],
                                                   context: nil)
    }
    
    private func config(rating: Double) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        ratingLabel.text = formatter.string(from: NSNumber(value: rating))
        
        ratingLabel.textColor = color(for: rating)
    }
    
    private func color(for rating: Double) -> UIColor {
        let count = 10
        let value = CGFloat(rating) / CGFloat(count)
        if value > 0.6 {
            //green
            let greenValue:CGFloat = 0.6
            let redValue = 1 - value
            return UIColor(red: redValue, green: greenValue, blue: 0.0, alpha: 1)
        } else {
            //red
            let greenValue = value - 0.2
            let redValue = 1 - value - 0.2
            return UIColor(red: redValue, green: greenValue, blue: 0.0, alpha: 1)
        }
    }
    
    
    //Need to fix
    func estimateConentSize() -> CGSize {
        return CGSize(width: bounds.width, height: descriptionText.frame.origin.y + estimateFrame(for: descriptionText.text, with: 14).height+4)
    }
    
}
