//
//  UINavigationController+Ext.swift
//  FoodPin
//
//  Created by Simon Ng on 13/9/2017.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    open override var childViewControllerForStatusBarStyle: UIViewController? {
        return topViewController
    }
    
}
