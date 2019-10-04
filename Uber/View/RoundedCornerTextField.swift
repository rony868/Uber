//
//  RoundedCornerTextField.swift
//  Uber
//
//  Created by MD RASHEDUZZAMAN on 12/04/19.
//  Copyright © 2019 MD RASHEDUZZAMAN. All rights reserved.
//

import UIKit

class RoundedCornerTextField: UITextField {
  
    override func awakeFromNib() {
        setupView()
    }
    func setupView(){
        self.layer.cornerRadius = self.frame.height / 2
    }
}
