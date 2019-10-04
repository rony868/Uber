//
//  RoundedMapView.swift
//  Uber
//
//  Created by MD RASHEDUZZAMAN on 30/05/19.
//  Copyright © 2019 MD RASHEDUZZAMAN. All rights reserved.
//

import UIKit
import MapKit

class RoundedMapView: MKMapView {
    
    override func awakeFromNib() {
        setupView()
    }

    func setupView(){
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 10
        
    }
}
