//
//  JFConstriantsSimple.swift
//  AppleSupport_AutoLayoutCollectionView
//
//  Created by Joseph Falcone on 9/17/17.
//  Copyright © 2017 Joseph Falcone. All rights reserved.
//

import UIKit

public extension UIView
{
    public func constrain_edges(to: UIView, excludingEdge: UIRectEdge? = nil)
    {
        translatesAutoresizingMaskIntoConstraints = false
        if excludingEdge != .top {
            self.topAnchor      .constraint(equalTo: to.topAnchor)      .isActive = true
        }
        if excludingEdge != .bottom {
            self.bottomAnchor   .constraint(equalTo: to.bottomAnchor)   .isActive = true
        }
        if excludingEdge != .left {
            self.leftAnchor     .constraint(equalTo: to.leftAnchor)     .isActive = true
        }
        if excludingEdge != .right {
            self.rightAnchor    .constraint(equalTo: to.rightAnchor)    .isActive = true
        }
    }
    
    public func constrain_height(_ height: CGFloat)
    {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    public func constrain_topToBottom(of: UIView)
    {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: of.bottomAnchor, constant: 0).isActive = true
    }
    
    public func constrain_left(to: UIView)
    {
        translatesAutoresizingMaskIntoConstraints = false
        leftAnchor.constraint(equalTo: to.leftAnchor).isActive = true
    }
    
    public func constrain_right(to: UIView)
    {
        translatesAutoresizingMaskIntoConstraints = false
        rightAnchor.constraint(equalTo: to.rightAnchor).isActive = true
    }
    
    public func constrain_center(in view: UIView)
    {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
