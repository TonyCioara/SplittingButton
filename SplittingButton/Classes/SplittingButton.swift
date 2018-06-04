//
//  SplittingButton.swift
//  splittingButtonLibrary
//
//  Created by Tony Cioara on 5/29/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import UIKit

/*  The direction will be used when displaying the buttons in a direction or in a list.  */
enum Direction {
    case right
    case left
    case up
    case down
}

/*  Display mode is used to figure out which configuration your buttons will be displayed in.    */
enum DisplayMode {
    case circle
    case list
    case direction
}

/*  The DataSource is responsible for creating all the sub-buttons displayed by the SplittingButton.
 Your View Controller must inherit from SplittingButtonDataSource.   */
protocol SplittingButtonDataSource {
    func buttonForIndexAt(index: Int) -> UIButton
    func numberOfButtons() -> Int
}

/*  The Delegate is responsible what happens when you click any of the sub-buttons.
 Your View Controller must inherit from SplittingButtonDelegate.   */
protocol SplittingButtonDelegate {
    func didTapButtonAt(button: UIButton, index: Int)
}

/*  This is the SplittingButton class.
 When clicked, the SplittingButton will display multiple buttons in a display configurations chosen by you.
 It will also display a cancel button that may be configured to your liking.
 When any of the sub-buttons are clicked the SplittingButtonDelegate will tell your View Controller which one was clicked.
 Your view controller must inherit from SplittingButtonDataSource and SplittingButtonDelegate.
 The button's delegate and dataSource must be set to the View Controller.
 Check the ButtonsViewController for sample code.   */
class SplittingButton: UIButton {
    
    private var buttonArray: [UIButton] = []
    private var darkView = UIView()
    
    private var displayMode: DisplayMode?
    private var direction: Direction?
    private var collums: Int?
    
    /*  To customize the cancelButton use the setCancelButtonBackgroundImage or
     setCancelButtonTitle methods  */
    private var cancelButton: UIButton?
    
    public func setCancelButtonBackgroundImage(image: UIImage) {
        let button = UIButton(frame: self.frame)
        button.setBackgroundImage(image, for: .normal)
        self.cancelButton = button
    }
    
    public func setCancelButtonTitle(text: String, font: UIFont) {
        let button = UIButton(frame: self.frame)
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = font
        self.cancelButton = button
    }
    
    private var target: UIViewController!
    
    /*  When the dataSource is set up properly, it will create an array of all the underlying buttons.    */
    public var dataSource: SplittingButtonDataSource! {
        didSet {
            buttonArray = []
            for index in 0 ..< self.dataSource.numberOfButtons() {
                let button = self.dataSource.buttonForIndexAt(index: index)
                button.alpha = 0.0
                button.tag = index
                buttonArray.append(button)
            }
            
            if self.delegate != nil {
                for button in buttonArray {
                    button.addTarget(self, action: #selector(tappedSubButton(sender:)), for: .touchDown)
                }
            }
        }
        
    }
    
    /*  When the delegate is set up properly it will add the target to each button. */
    public var delegate: SplittingButtonDelegate? {
        didSet {
            for button in buttonArray {
                button.addTarget(self, action: #selector(tappedSubButton(sender:)), for: .touchDown)
            }
        }
    }
    
    /* This is an internal init, not visible to the outside world.
     Please use the convenience initializers when creating the button.   */
    private init(frame: CGRect, target: UIViewController) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(clicked(sender:)), for: .touchDown)
        
        self.target = target
        
        self.darkView.frame = self.target.view.bounds
        self.darkView.backgroundColor = UIColor.lightGray
        self.darkView.alpha = 0.0
    }
    
    /* When the splitting button is clicked the background becomes dark.
     You may customize the color of the background using this method.    */
    public func setBackgroundColor(color: UIColor) {
        self.darkView.backgroundColor = color
    }
    
    /*  This convenience init is used for displaying the buttons in a circle around the SplittingButton.
     The first button will be placed above the SplittingButton, continuing to display clockwise.    */
    convenience init(animateInCircleWithFrame: CGRect, target: UIViewController) {
        self.init(frame: animateInCircleWithFrame, target: target)
        
        self.displayMode = DisplayMode.circle
    }
    
    /*  This convenience init is used for displaying the buttons lined up in a direction, starting from the SplittingButton.    */
    convenience init(animateInDirectionWithFrame: CGRect, target: UIViewController, direction: Direction) {
        self.init(frame: animateInDirectionWithFrame, target: target)
        
        self.displayMode = DisplayMode.direction
        self.direction = direction
    }
    
    /*  This convenience init is used for displaying the buttons in a list.
     You may cutomize it by selecting the direction and number of collums.   */
    convenience init(animateInListWithFrame: CGRect, target: UIViewController, direction: Direction, collums: Int) {
        self.init(frame: animateInListWithFrame, target: target)
        
        self.displayMode = DisplayMode.list
        self.direction = direction
        self.collums = collums
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*  When a sub-button is clicked, the SplittingButton calls the delegate. */
    @objc func tappedSubButton(sender: UIButton) {
        
        self.delegate?.didTapButtonAt(button: sender, index: sender.tag)
    }
    
    /*  When the splittingButton is clicked it displays the cancelButton and the sub-buttons.   */
    @objc func clicked(sender: UIButton) {
        
        self.alpha = 0.0
        self.isHidden = true
        
        animateDarkView()
        repositionButtonFrames()
        addButtonsToSuperView()
        setUpCancelButton()
        
        //        TODO: Change depending on state
        switch displayMode! {
        case .circle:
            animateButtonsInCircle()
        case .direction:
            animateButtonsInDirection()
        case .list:
            animateButtonsInList()
        }
    }
    
    /*  Makes the dark view appear in the background.   */
    private func animateDarkView() {
        self.target.view.addSubview(darkView)
        UIView.animate(withDuration: 0.5) {
            self.darkView.alpha = 0.5
        }
    }
    
    /*  Makes sure all the sub-button frames are in the right place when animation starts.  */
    private func repositionButtonFrames() {
        for button in self.self.buttonArray {
            button.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: self.frame.width, height: self.frame.height)
        }
    }
    
    /*  Adds all the subbuttons to the superview.   */
    private func addButtonsToSuperView() {
        for button in buttonArray {
            self.target.view.addSubview(button)
        }
    }
    
    /* Creates and adds cancel button to the superview.
     If the cancel button isn't customized, the default one will be used.
     For information on how to customize the cancel button check lines 55-56.   */
    private func setUpCancelButton() {
        var button = UIButton()
        if self.cancelButton != nil {
            button = self.cancelButton!
        } else {
            button.setBackgroundImage(#imageLiteral(resourceName: "cancelButton"), for: .normal)
            button.frame = self.frame
        }
        
        button.addTarget(self, action: #selector(cancelButtonPressed(sender:)), for: .touchDown)
        button.alpha = 0.0
        self.target.view.addSubview(button)
        
        UIView.animate(withDuration: 0.75) {
            button.alpha = 1.0
        }
    }
    
    /*  When the cancel button is pressed animate and remove all the sub-buttons.
     Remove the cancel button and make the splittingButton appear.   */
    @objc func cancelButtonPressed(sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.darkView.alpha = 0.0
        }) { (true) in
            self.darkView.removeFromSuperview()
        }
        UIView.animate(withDuration: 0.25, delay: 0.15, options: .curveEaseIn, animations: {
            self.alpha = 1.0
        }) { (true) in
            self.isHidden = false
        }
        
        for button in buttonArray {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                button.frame = self.frame
            }) { (true) in
                button.removeFromSuperview()
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                button.alpha = 0.0
            }, completion: nil)
        }
        sender.removeFromSuperview()
    }
    
    /*  This method is used for animating the buttons in a circle.   */
    private func animateButtonsInCircle() {
        
        var radius: CGFloat
        if self.frame.width > self.frame.height {
            radius = self.frame.width * 2
        } else {
            radius = self.frame.height * 2
        }
        
        let increment = 2 * CGFloat.pi / CGFloat(buttonArray.count)
        
        for index in 0 ..< buttonArray.count {
            
            self.buttonArray[index].alpha = 1.0
            
            let xPos = sin(increment * CGFloat(index)) * radius + self.frame.midX - buttonArray[index].frame.width / 2
            let yPos = cos(increment * CGFloat(index)) * (0 - radius) + self.frame.midY - buttonArray[index].frame.height / 2
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.buttonArray[index].alpha = 1.0
                self.buttonArray[index].frame = CGRect(x: xPos, y: yPos, width: self.buttonArray[index].frame.width, height: self.buttonArray[index].frame.height)
            }, completion: nil)
        }
    }
    
    /*  This method is used to animate the buttons in a direction.  */
    private func animateButtonsInDirection() {
        
        var xOffset: CGFloat = 0
        var yOffset: CGFloat = 0
        
        for index in 0 ..< buttonArray.count {
            
            switch direction! {
            case .down:
                yOffset += self.frame.height * 2
            case .up:
                yOffset -= self.frame.height * 2
            case .right:
                xOffset += self.frame.width * 2
            case .left:
                xOffset -= self.frame.width * 2
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.buttonArray[index].alpha = 1.0
                self.buttonArray[index].frame = CGRect(x: self.frame.minX + xOffset, y: self.frame.minY + yOffset, width: self.buttonArray[index].frame.width, height: self.buttonArray[index].frame.height)
            }, completion: nil)
        }
    }
    
    /*  This method is used to animate the buttons is a list.   */
    private func animateButtonsInList() {
        
        var yOffset: CGFloat = 0
        var initialXOffset: CGFloat = 0
        
        var lines = Double(self.buttonArray.count) / Double(collums!)
        lines.round(.awayFromZero)
        
        
        switch direction! {
        case .down:
            initialXOffset -= self.frame.width * CGFloat(collums! - 1)
        case .up:
            initialXOffset -= self.frame.width * CGFloat(collums! - 1)
            yOffset -= self.frame.height * 2 * (CGFloat(lines) + 1)
        case .right:
            initialXOffset += self.frame.width * 2
            yOffset -= self.frame.height * CGFloat(lines + 1)
        case .left:
            initialXOffset -= self.frame.width * 2 * (CGFloat(collums!))
            yOffset -= self.frame.height * CGFloat(lines + 1)
        }
        
        var xOffset = initialXOffset
        
        for index in 0 ..< buttonArray.count {
            
            if index % collums! == 0 {
                xOffset = initialXOffset
                yOffset += self.frame.height * 2
            } else {
                xOffset += self.frame.width * 2
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.buttonArray[index].alpha = 1.0
                self.buttonArray[index].frame = CGRect(x: self.frame.minX + xOffset, y: self.frame.minY + yOffset, width: self.buttonArray[index].frame.width, height: self.buttonArray[index].frame.height)
            }, completion: nil)
        }
    }
}

