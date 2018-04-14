//
//  UIColor+Gradient.swift
//  SeckveniaTest
//
//  Created by Jake Walker on 12.04.2018.
//  Copyright © 2018 Aleksandr Chegoshev. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func gradientColor(for rating: Double) -> UIColor {
        let maxCount = 10
        let value = CGFloat(rating) / CGFloat(maxCount)
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
}
