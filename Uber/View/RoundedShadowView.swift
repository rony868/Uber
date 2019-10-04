//
//  RoundedShadowView.swift
//  Uber
//
//  Created by MD RASHEDUZZAMAN on 07/04/19.
//  Copyright © 2019 MD RASHEDUZZAMAN. All rights reserved.
//

import UIKit

class RoundedShadowView: UIView {

    override func awakeFromNib() {
        setupView()
    }
    func setupView(){
        self.layer.cornerRadius = 5.0
        self.layer.shadowOpacity = 0.2
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
    }

}
