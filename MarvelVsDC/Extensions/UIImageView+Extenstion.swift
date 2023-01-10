//
//  UIImageView+Extenstion.swift
//  Test
//
//  Created by ankit on 08/01/23.
//  Copyright © 2023 simform. All rights reserved.
//

import UIKit

extension UIImageView {
    
    // APPLY DROP SHADOW
    func applyDropShadow(shadowColor: UIColor, shadowOffset: CGSize, cornerRadius: CGFloat, shadowOpacity: Float, shadowRadius: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: shadowRadius).cgPath
    }
    
}
