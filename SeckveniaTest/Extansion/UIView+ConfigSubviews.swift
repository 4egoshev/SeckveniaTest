//
//  UIView+ConfigSubviews.swift
//  SeckveniaTest
//
//  Created by Jake Walker on 12.04.2018.
//  Copyright © 2018 Aleksandr Chegoshev. All rights reserved.
//

import UIKit

extension UIView {
    
    func resize(view: UIView) {
        let fixWidth = view.frame.width
        let newSize = view.sizeThatFits(CGSize(width: fixWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = view.frame
        newFrame.size = CGSize(width: CGFloat(fmaxf(Float(newSize.width), Float(fixWidth))), height: newSize.height)
        view.frame = newFrame
    }
    
    func config(rating: Double, for label: UILabel) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        label.text = formatter.string(from: NSNumber(value: rating))!
        
        label.textColor = UIColor.gradientColor(for: rating)
    }
}
