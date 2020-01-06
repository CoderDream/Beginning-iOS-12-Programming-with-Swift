//
//  UINavigationController+Ext.swift
//  FoodPin
//
//  Created by CoderDream on 2019/6/18.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
    
}
