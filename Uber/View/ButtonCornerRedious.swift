//
//  ButtonCornerRedious.swift
//  Uber
//
//  Created by MD RASHEDUZZAMAN on 12/04/19.
//  Copyright © 2019 MD RASHEDUZZAMAN. All rights reserved.
//

import UIKit

class ButtonCornerRedious: UIButton {
    override func awakeFromNib() {
        setupView()
    }

    func setupView(){
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.clear.cgColor
    }
}
