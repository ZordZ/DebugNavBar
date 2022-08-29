# DebugNavBar

[![CI Status](https://img.shields.io/travis/MrTrent/DebugNavBar.svg?style=flat)](https://travis-ci.org/MrTrent/DebugNavBar)
[![Version](https://img.shields.io/cocoapods/v/DebugNavBar.svg?style=flat)](https://cocoapods.org/pods/DebugNavBar)
[![License](https://img.shields.io/cocoapods/l/DebugNavBar.svg?style=flat)](https://cocoapods.org/pods/DebugNavBar)
[![Platform](https://img.shields.io/cocoapods/p/DebugNavBar.svg?style=flat)](https://cocoapods.org/pods/DebugNavBar)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Description

DebugNavBar is usefull navigation bar for some debugging task.    

#### :small_orange_diamond: Step 1 - General setup
First of all you need to setup UINavigationBar and UINavigationBarDelegate.    
You can do it by Storyboard(like in example) or programmatically(need example?).

-- About UINavigationBarDelegate.    
You can create your custom UINavigationControllerDelegate inherited from DebugNavBarDelegate just dont't forget to call super methods.    
Another option for integration is create your custom UINavigationControllerDelegate. With stored instance of DebugNavBarDelegate and requried call of:
```swift
func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {}
```    

#### :small_orange_diamond: Step 2 - Configurator(debug info)    
Now we need setup Configurator for debug info.    

```swift
import DebugNavBar
import ZUCore
//....

// height of debug text line
DebugNavBar.Configurator.height = 10 // if you'll change width - you'll lose auto-width
// text aligment
DebugNavBar.Configurator.alignmentMode = .center
// font color
DebugNavBar.Configurator.fontColor = .white
// font size
DebugNavBar.Configurator.fontSize = 8.0
// condition block which determinants when need show debug text line
DebugNavBar.Configurator.showCondition_Block = {
    return AppUtils.isDebug
}
// Here you can setup your static debugString. But also you can implement dynamic debugString.
DebugNavBar.Configurator.debugString_Block = {
    return "Example Configurator Test String"
}
```    

-- About dynamic debugString.    
Dynamic debugString is a string which is different and provided by view controller implementation.
It's useful when you want show view controller class, url or other staff.
Just implement:
```swift
extension TestDebugVC: DynamicDebugString_Protocol {
    var debugString: String {
        return "Example of Dynamic Debug String"
    }
}
```    

#### :small_orange_diamond: Step 3 - Configurator(debug menu)    
Now we need setup Configurator for debug menu.    

```swift
// set your custom gesture constructor if you want. Default gesture is like in example.
DebugNavBar.Configurator.debugGesture_Block = {
    let longTap = UILongPressGestureRecognizer()
    longTap.minimumPressDuration = 1.0
    return longTap
}
// set your debug view controller constructor (requried)
DebugNavBar.Configurator.segueDestination_Block = {
    let vc = TestDebugVC()
    return vc
}
// set password check - you can implement password check by server or use it like in example
// if pass is correct - debug menu is avaliable until restart app
DebugNavBar.Configurator.passwordCheck_Block = { (enteredPassword, success, error) in
    enteredPassword == "1234" ? success() : error()
}
// indicates that debug menu is always enable in debug scheme without enter password or only after enter password
DebugNavBar.Configurator.menuAlwaysEnableInDebug = false
// indicates that debug menu is enable in release scheme only after entering password or not avaliable
DebugNavBar.Configurator.menuEnableInRelease = false        
```    

## Requirements

:small_blue_diamond: swift 5 :small_blue_diamond: ios 13.0 :small_blue_diamond:

## Installation

DebugNavBar is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DebugNavBar'
```

## Author

MrTrent, show6time@gmail.com

## License

DebugNavBar is available under the MIT license. See the LICENSE file for more info.
