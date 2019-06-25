//
//  NewRestaurantController.swift
//  FoodPin
//
//  Created by CoderDream on 2019/6/23.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import UIKit
import CoreData

class NewRestaurantController: UITableViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var photoImageView: UIImageView!
    
    var restaurant: RestaurantMO!    
    
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

        // Configure navigation bar appearance 定义导航栏的样式，包括文字颜色
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        if let customFont = UIFont(name: "Rubik-Medium", size: 35.0) {
            navigationController?.navigationBar.largeTitleTextAttributes =
                [ NSAttributedString.Key.foregroundColor: UIColor(red: 231, green: 76, blue: 60),
                  NSAttributedString.Key.font: customFont ]
        }
        
        // Configure table view
        tableView.separatorStyle = .none
    }

    // MARK: - Table view data source
    // MARK: - UITableViewDelegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 如果选择的第一个 Cell
        if indexPath.row == 0 {
            // 创建警告控制器
            let photoSourceRequestController = UIAlertController(title: "", message: "Choose your photo source", preferredStyle: .actionSheet)
            // 相机警告
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .camera
                    imagePicker.delegate = self
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            // 相片库警告
            let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default, handler: { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    imagePicker.delegate = self
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            // 将两个警告添加到控制器中
            photoSourceRequestController.addAction(cameraAction)
            photoSourceRequestController.addAction(photoLibraryAction)
            
            // For iPad
            if let popoverController = photoSourceRequestController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
            }
            // 显示警告控制器
            present(photoSourceRequestController, animated: true, completion: nil)
        }
    }

    
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
    
    // MARK: - Action method (Exercise #2)
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        if nameTextField.text == ""
            || typeTextField.text == ""
            || addressTextField.text == ""
            || phoneTextField.text == ""
            || summaryTextView.text == "" {
            let alertController = UIAlertController(
                                    title: "Oops",
                                    message: "We can't proceed because one of the fields is blank. Please note that all fields are required.",
                                    preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
        print("Name: \(nameTextField.text ?? "")")
        print("Type: \(typeTextField.text ?? "")")
        print("Location: \(addressTextField.text ?? "")")
        print("Phone: \(phoneTextField.text ?? "")")
        print("Description: \(summaryTextView.text ?? "")")
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            restaurant = RestaurantMO(context: appDelegate.persistentContainer.viewContext)
            
            restaurant.name = nameTextField.text
            restaurant.type = typeTextField.text
            restaurant.location = addressTextField.text
            restaurant.phone = phoneTextField.text
            restaurant.summary = summaryTextView.text
            restaurant.isVisited = false
            
            if let restaurantImage = photoImageView.image {
                restaurant.image = restaurantImage.pngData()
            }
            
            print("Saving data to context ...")
            appDelegate.saveContext()
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }
        
        let leadingConstraint = NSLayoutConstraint(
                                    item: photoImageView,
                                    attribute: .leading,
                                    relatedBy: .equal,
                                    toItem: photoImageView.superview,
                                    attribute: .leading,
                                    multiplier: 1,
                                    constant: 0)
        leadingConstraint.isActive = true
        
        let trailingConstraint = NSLayoutConstraint(
                                    item: photoImageView,
                                    attribute: .trailing,
                                    relatedBy: .equal,
                                    toItem: photoImageView.superview,
                                    attribute: .trailing,
                                    multiplier: 1,
                                    constant: 0)
        trailingConstraint.isActive = true
        
        let topConstraint = NSLayoutConstraint(
                                item: photoImageView,
                                attribute: .top,
                                relatedBy: .equal,
                                toItem: photoImageView.superview,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0)
        topConstraint.isActive = true
        
        let bottomConstraint = NSLayoutConstraint(
                                item: photoImageView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: photoImageView.superview,
                                attribute: .bottom,
                                multiplier: 1,
                                constant: 0)
        bottomConstraint.isActive = true
        
        dismiss(animated: true, completion: nil)
    }
}
