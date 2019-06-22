//
//  RoundedTextField.swift
//  FoodPin
//
//  Created by CoderDream on 2019/6/22.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import UIKit

class RoundedTextField: UITextField {

    // 左右两边各 padding 10 points 点
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10);
    
    // 文本矩形的大小
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    // 提示信息的矩形大小
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    // 可输入的编辑框矩形大小
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 圆角半径 5.0
        self.layer.cornerRadius = 5.0
        // 设置 告诉layer将位于它之下的layer都遮盖住
        self.layer.masksToBounds = true
    }
}
