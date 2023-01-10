//
//  DynamicConstrains.swift
//  MarvelVsDC
//
//  Created by Ankit Panchal on 08/01/23.
//

import UIKit

extension UIView {
    
    /// Sets edges to given view
    func constrainEdges(to view: Any) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let top = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0);
        
        let bottom = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0);
        
        let left = NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0);
        
        let right = NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0);
        
        self.superview!.addConstraints([top, left, right, bottom])
    }
    
    /// Sets edges to given view with top margin
    func constrainEdgesWithTop(to view: Any, top topView: Any, topMargin margin: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let top = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: topView, attribute: .bottom, multiplier: 1, constant: margin);
        
        let bottom = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0);
        
        let left = NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0);
        
        let right = NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0);
        
        self.superview!.addConstraints([top, left, right, bottom])
    }
}
