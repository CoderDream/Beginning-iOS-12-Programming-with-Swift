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
        
        let moveRightTransform = CGAffineTransform.init(translationX: 600, y: 0)
        let scaleUpTransform = CGAffineTransform.init(scaleX: 5.0, y: 5.0)
        let moveScaleTransform = scaleUpTransform.concatenating(moveRightTransform)
        
        // Make the button invisible and move off the screen
        for rateButton in rateButtons {
            rateButton.transform = moveScaleTransform
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
        
//        UIView.animate(withDuration: 2.0) {
//            for index in 0...4 {
//                self.rateButtons[index].alpha = 1.0
//            }
//        }
//        UIView.animate(withDuration: 0.4, delay: 0.1, options: [], animations: {
//            self.rateButtons[0].alpha = 1.0
//            self.rateButtons[0].transform = .identity
//        }, completion: nil)
//
//        UIView.animate(withDuration: 0.4, delay: 0.15, options: [], animations: {
//            self.rateButtons[1].alpha = 1.0
//            self.rateButtons[1].transform = .identity
//        }, completion: nil)
//
//        UIView.animate(withDuration: 0.4, delay: 0.2, options: [], animations: {
//            self.rateButtons[2].alpha = 1.0
//            self.rateButtons[2].transform = .identity
//        }, completion: nil)
//
//        UIView.animate(withDuration: 0.4, delay: 0.25, options: [], animations: {
//            self.rateButtons[3].alpha = 1.0
//            self.rateButtons[3].transform = .identity
//        }, completion: nil)
//
//        UIView.animate(withDuration: 0.4, delay: 0.3, options: [], animations: {
//            self.rateButtons[4].alpha = 1.0
//            self.rateButtons[4].transform = .identity
//        }, completion: nil)
        
        UIView.animate(withDuration: 1.0, delay: 0.1, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.3, options: [], animations: {
            self.rateButtons[0].alpha = 1.0
            self.rateButtons[0].transform = .identity
        }, completion: nil)
        
        UIView.animate(withDuration: 1.0, delay: 0.1, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.3, options: [], animations: {
            self.rateButtons[1].alpha = 1.0
            self.rateButtons[1].transform = .identity
        }, completion: nil)
        
        UIView.animate(withDuration: 1.0, delay: 0.1, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.3, options: [], animations: {
            self.rateButtons[2].alpha = 1.0
            self.rateButtons[2].transform = .identity
        }, completion: nil)
        
        UIView.animate(withDuration: 1.0, delay: 0.1, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.3, options: [], animations: {
            self.rateButtons[3].alpha = 1.0
            self.rateButtons[3].transform = .identity
        }, completion: nil)
        
        UIView.animate(withDuration: 1.0, delay: 0.1, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.3, options: [], animations: {
            self.rateButtons[4].alpha = 1.0
            self.rateButtons[4].transform = .identity
        }, completion: nil)
        
        
       
        
        
        
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
