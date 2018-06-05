# SplittingButton

[![CI Status](https://img.shields.io/travis/TonyCioara/SplittingButton.svg?style=flat)](https://travis-ci.org/TonyCioara/SplittingButton)
[![Version](https://img.shields.io/cocoapods/v/SplittingButton.svg?style=flat)](https://cocoapods.org/pods/SplittingButton)
[![License](https://img.shields.io/cocoapods/l/SplittingButton.svg?style=flat)](https://cocoapods.org/pods/SplittingButton)
[![Platform](https://img.shields.io/cocoapods/p/SplittingButton.svg?style=flat)](https://cocoapods.org/pods/SplittingButton)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Swift 4.1 and above
Xcode 8.0 and above

## Installation

SplittingButton is available at https://cocoapods.org/pods/SplittingButton. To install
it, simply add the following line to your Podfile:

```ruby
pod 'SplittingButton'
```

Go to your directory and run ```pod install``` in the terminal
Open your Xcode workspace

## How to use

First you need to ```import SplittingButton``` into your project.

Instantiate a splitting button by doing ```mySplittingButton = SplittingButton(```
This will provide you with 3 options:

1.  ```SplittingButton(animateInCircleWithFrame: CGRect, target: UIViewController)```
    When the button is clicked, it will display the underlying button in a circle around the main button.
    Pass in your View Controller as the target and create a CGRect to your liking a a frame.
    
2. ```SplittingButton(animateInDirectionWithFrame: CGRect, target: UIViewController, direction: Direction)```
    When the button is clicked, it will display the underlying button in a line, originating from the main button.
    Pass in your View Controller as the target, create a CGRect to your liking a a frame, and pass in the direction in which you wish to display your buttons.
    
3.```SplittingButton(animateInListWithFrame: CGRect, target: UIViewController, direction: Direction, collums: Int)```
    When the button is clicked, it will display the underlying button in a list.
    Pass in your View Controller as the target, create a CGRect to your liking a a frame, pass in the direction in which you wish to display your buttons, and an Int as the number of collums for your list.
    
    
### Now that you have your splitting button, we need to make sure you have the right dataSource and delegate

Make your View Controller inherit from the protocols SplittingButtonDataSource and SplittingButtonDelegate.
    ```class ButtonsViewController: UIViewController, SplittingButtonDataSource, SplittingButtonDelegate {```


The dataSource protocol will require you to have the following functions in your View Controller:
```func numberOfButtons() -> Int```
    This function is responsible for finding out how many buttons you want to display when you click your SplittingButton.
    
```func buttonForIndexAt(index: Int) -> UIButton```
    This function is responsible for finding out what you want each button to look like.
    

The delegate protocol will require one function:
```func didTapButtonAt(button: UIButton, index: Int)```
    This function lets you choose the functionality of each button.
    
    
Don't forget to set the dataSource and delegate of the SplittingButton after creating it.
```mySplittingButton.dataSource = self```
```mySplittingButton.delegate = self```


### Now you can customize your splitting button and add it to the view

### More customization options:

When you click the splittingButton the background becomes gray. To customize the background color use:
```setBackgroundColor(color: UIColor)```

To customize your cancel button use:
```setCancelButtonTitle(text: String, font: UIFont)``` or
```setCancelButtonBackgroundImage(image: UIImage)```

To cancel the SplittingButton programatically use:
```cancel()```


### Notes

1. The buttons that pop up when clicking on the SplittingButton will have the same frame as the splittingButton.
This is in order to pick the proper positions when displaying them.

2. You may have to restrict the amount of buttons depending on your display options, in order to make them fit in the superView.

3. The distance between the buttons is not yet customizable. It will always equal the width/height of the buttons themselves.



## Author

TonyCioara, tonyangelo9707@gmail.com

## License

SplittingButton is available under the MIT license. See the LICENSE file for more info.
