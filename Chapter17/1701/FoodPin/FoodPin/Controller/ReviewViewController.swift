//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by CoderDream on 2019/6/20.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var rateButtons: [UIButton]!
    @IBOutlet var closeButton: UIButton!
    
    var restaurant = Restaurant()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.        
        backgroundImageView.image = UIImage(named: restaurant.image)
        
        // Applying the blur effect
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        // Make the button invisible and move off the screen
        for rateButton in rateButtons {
            //rateButton.transform = moveScaleTransform
            rateButton.alpha = 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
//        for index in 0...4 {
//            UIView.animate(withDuration: 0.4, delay: (0.1 + 0.05 * Double(index)), options: [], animations: {
//                self.rateButtons[index].alpha = 1.0
//                self.rateButtons[index].transform = .identity
//            }, completion: nil)
//        }
//
//        UIView.animate(withDuration: 0.4) {
//            self.closeButton.transform = .identity
//        }
        
        UIView.animate(withDuration: 2.0) {
            for index in 0...4 {
                self.rateButtons[index].alpha = 1.0
            }
        }        
    }
    
    @IBAction func close(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
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
