//
//  ViewController.swift
//  SplittingButton
//
//  Created by TonyCioara on 06/04/2018.
//  Copyright (c) 2018 TonyCioara. All rights reserved.
//

import UIKit
import SplittingButton

/*    This is the sample View Controller for demoing the functionality of the button.
 When the SplittingButton is clicked it will create multiple custom buttons.  */
class ViewController: UIViewController, SplittingButtonDelegate, SplittingButtonDataSource {
    
    /*  The label displays which button was tapped last */
    let buttonDisplayLabel = UILabel()
    
    /*  This function comes from the SplittingButtonDelegate protocol.
     You will use this to decide what each of the buttons will do.    */
    func didTapButtonAt(button: UIButton, index: Int) {
        if index == 0 {
            self.buttonDisplayLabel.text = "Facebook button clicked"
        } else if index == 1 {
            self.buttonDisplayLabel.text = "Twitter button clicked"
        } else if index == 2 {
            self.buttonDisplayLabel.text = "Instagram button clicked"
        } else {
            self.buttonDisplayLabel.text = "Red button clicked"
        }
    }
    
    /*  This function comes from the SplittingButtonDataSource protocol.
     It is used to customizeeach of the buttons contained within the splitting button.    */
    func buttonForIndexAt(index: Int) -> UIButton {
        let button = UIButton()
        
        if index == 0 {
            button.setBackgroundImage(#imageLiteral(resourceName: "facebookLogo"), for: .normal)
        } else if index == 1 {
            button.setBackgroundImage(#imageLiteral(resourceName: "twitterLogo"), for: .normal)
        } else if index == 2 {
            button.setBackgroundImage(#imageLiteral(resourceName: "instagramLogo"), for: .normal)
        } else {
            button.backgroundColor = .red
        }
        
        return button
    }
    
    /*  This function comes from the SplittingButtonDataSource protocol.
     It is reponsible for determining the number of sub-buttons you want to have in the SplittingButton. */
    func numberOfButtons() -> Int {
        return 3
    }
    
    /*  Setting up the label for demoing the functionality of the buttons   */
    func setUpLabel() {
        let font = UIFont(name: ".SFUIText-Medium", size: 18)!
        self.buttonDisplayLabel.font = font
        self.buttonDisplayLabel.frame = CGRect(x: 0, y: self.view.frame.height - 48, width: self.view.frame.width, height: 24)
        self.buttonDisplayLabel.textAlignment = .center
        self.view.addSubview(self.buttonDisplayLabel)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpLabel()
        
        /* Initializing the splitting button requires a frame, a target (usually your view controller),
         and may require a direction or collums, depending on the type of initializer called.
         You may choose to animate it in a circle, a direction, or a list with collums and direction.
         Depending on your configuration you may have to restrict the number of sub-buttons.
         Uncomment the lines below and try it out for yourself.   */
        
        let frame = CGRect(x: self.view.frame.midX - 20, y: self.view.frame.midY - 20, width: 40, height: 40)
        
        let splittingButton = SplittingButton(animateInCircleWithFrame: frame, target: self)
        //        let splittingButton = SplittingButton(animateInDirectionWithFrame: frame, target: self, direction: .left)
        //        let splittingButton = SplittingButton(animateInListWithFrame: frame, target: self, direction: .down, collums: 3)
        
        
        /*  We must set the dataSource and the delegate for the splittingButton  */
        splittingButton.dataSource = self
        splittingButton.delegate = self

        /*  Configure the button aesthetically and display it by adding it to the view  */
        splittingButton.setBackgroundImage(#imageLiteral(resourceName: "shareButton"), for: .normal)
        self.view.addSubview(splittingButton)
    }
}

