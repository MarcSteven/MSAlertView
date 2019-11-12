//
//  UIView+CornerRadius.swift
//  MSAlert
//
//  Created by Marc Zhao on 2017/11/12.
//  Copyright © 2017 - 2019 Marc Zhao. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    var cornerRadius:CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds  = newValue > 0
        }
    }
}
