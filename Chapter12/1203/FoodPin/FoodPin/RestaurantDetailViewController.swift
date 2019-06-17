//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by CoderDream on 2019/6/17.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    
    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet var restaurantNameLabel: UILabel!
    @IBOutlet var restaurantTypeLabel: UILabel!
    @IBOutlet var restaurantLocationLabel: UILabel!
    
    var restaurantName = ""
    var restaurantType = ""
    var restaurantLocation = ""
    var restaurantImageName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantNameLabel.text = restaurantName
        restaurantTypeLabel.text = restaurantType
        restaurantLocationLabel.text = restaurantLocation
        
        // Do any additional setup after loading the view.
        restaurantImageView.image = UIImage(named: restaurantImageName)
        
        // Disable Large Titles
        navigationItem.largeTitleDisplayMode = .never
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
