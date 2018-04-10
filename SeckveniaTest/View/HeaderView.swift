//
//  HeaderView.swift
//  SeckveniaTest
//
//  Created by Jake Walker on 10.04.2018.
//  Copyright © 2018 Aleksandr Chegoshev. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    @IBOutlet weak var yearLabel: UILabel!
    
    func config(with year: Int) {
        backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        yearLabel.text = String(year)
    }

}
