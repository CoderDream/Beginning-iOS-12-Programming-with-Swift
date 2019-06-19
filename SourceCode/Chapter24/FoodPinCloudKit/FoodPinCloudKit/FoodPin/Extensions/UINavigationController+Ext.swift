//
//  UINavigationController+Ext.swift
//  FoodPin
//
//  Created by Simon Ng on 18/8/2018.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
    
}
