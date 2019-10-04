//
//  RoundedImageView.swift
//  Uber
//
//  Created by MD RASHEDUZZAMAN on 07/04/19.
//  Copyright © 2019 MD RASHEDUZZAMAN. All rights reserved.
//

import UIKit

class RoundedImageView: UIImageView {

    override func awakeFromNib() {
        setupView()
    }
    func setupView(){
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }

}
