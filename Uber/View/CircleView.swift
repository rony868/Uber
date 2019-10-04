//
//  CircleView.swift
//  Uber
//
//  Created by MD RASHEDUZZAMAN on 07/04/19.
//  Copyright © 2019 MD RASHEDUZZAMAN. All rights reserved.
//

import UIKit

class CircleView: UIView {


    @IBInspectable var borderColor: UIColor? {
        didSet {
            setupView()
        }
    }
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1.5
        self.layer.borderColor = borderColor?.cgColor
    }

}
