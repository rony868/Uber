//
//  CenterVCDelegate.swift
//  Uber
//
//  Created by MD RASHEDUZZAMAN on 08/04/19.
//  Copyright © 2019 MD RASHEDUZZAMAN. All rights reserved.
//

import Foundation

protocol CenterVCDelegate {
    func toggleLeftPanel()
    func addLeftPanelViewController()
    func animateLeftPanel(shouldExpand: Bool)
}
