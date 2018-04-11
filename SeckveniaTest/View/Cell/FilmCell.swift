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
    
    private var localizedNameHeight: NSLayoutConstraint?
    private var nameHeight: NSLayoutConstraint?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        accessoryType = .disclosureIndicator
        selectionStyle = .none
    }
    
    func changeContainerViewColor(isSelested: Bool) {
        if isSelested {
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
        let localizedName = array[indexPath.row].localizedName
        let name = array[indexPath.row].name
        let rating = array[indexPath.row].rating
        
        config(localizedName: localizedName, name: name)
        config(rating: rating)
    }
    
    private func config(localizedName: String, name: String) {
        localizedNameHeight?.isActive = false
        nameHeight?.isActive = false
        localizedNameHeight?.constant = estimateFrame(for: localizedName, with: 15).height+4
        nameHeight?.constant = estimateFrame(for: name, with: 12).height+4
        localizedNameHeight?.isActive = true
        nameHeight?.isActive = true
        
        localizedNameLabel.text = localizedName
        nameLabel.text = name
    }
    
    private func config(rating: Double) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        ratingLabel.text = formatter.string(from: NSNumber(value: rating))
        
        ratingLabel.textColor = color(for: rating)
    }
    
    private func estimateFrame(for text: String, with textSize: CGFloat) -> CGRect {
        let size = CGSize(width: bounds.width/2, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size,
                                                   options: options,
                                                   attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: textSize)],
                                                   context: nil)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        localizedNameHeight?.isActive = false
        nameHeight?.isActive = false
        posterImage.image = nil
    }
}
