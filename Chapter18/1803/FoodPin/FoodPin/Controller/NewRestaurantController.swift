//
//  NewRestaurantController.swift
//  FoodPin
//
//  Created by CoderDream on 2019/6/23.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import UIKit

class NewRestaurantController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet var photoImageView: UIImageView!
    
    @IBOutlet var nameTextField: RoundedTextField! {
        didSet {
            nameTextField.tag = 1
            nameTextField.becomeFirstResponder()
            nameTextField.delegate = self
        }
    }
    
    @IBOutlet var typeTextField: RoundedTextField! {
        didSet {
            typeTextField.tag = 2
            typeTextField.delegate = self
        }
    }
    
    @IBOutlet var addressTextField: RoundedTextField! {
        didSet {
            addressTextField.tag = 3
            addressTextField.delegate = self
        }
    }
    
    @IBOutlet var phoneTextField: RoundedTextField! {
        didSet {
            phoneTextField.tag = 4
            phoneTextField.delegate = self
        }
    }
    
    @IBOutlet var summaryTextView: UITextView! {
        didSet {
            summaryTextView.tag = 5
            summaryTextView.layer.cornerRadius = 5.0
            summaryTextView.layer.masksToBounds = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    
    // MARK: - UITextFieldDelegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 获取tag + 1 的文本框
        if let nextTextField = view.viewWithTag(textField.tag + 1) {
            // 如果存在，则把当前的文本框解绑首个响应者
            textField.resignFirstResponder()
            // 下一个文本框作为首个响应者
            nextTextField.becomeFirstResponder()
        }
        
        return true
    }
}
