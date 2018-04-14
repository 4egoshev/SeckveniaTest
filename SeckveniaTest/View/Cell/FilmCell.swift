//
//  FilmCell.swift
//  SeckveniaTest
//
//  Created by Jake Walker on 10.04.2018.
//  Copyright © 2018 Aleksandr Chegoshev. All rights reserved.
//

import UIKit

class FilmCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var localizedNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        accessoryType = .disclosureIndicator
        selectionStyle = .none
    }
    
    func changeContainerViewColor(isSelected: Bool) {
        if isSelected {
            containerView.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        } else {
            containerView.backgroundColor = UIColor.white
        }
        
    }
    func setPoster(with data: Data?) {
        guard let imageData = data else { return }
        posterImage.image = UIImage(data: imageData)
    }
    
    func configCell(from array: [Film], with indexPath: IndexPath) {
        localizedNameLabel.text = array[indexPath.row].localizedName
        nameLabel.text = array[indexPath.row].name
        resize(view: localizedNameLabel)
        resize(view: nameLabel)
        
        let rating = array[indexPath.row].rating
        config(rating: rating, for: ratingLabel)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImage.image = nil
    }
}
