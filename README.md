# TVGTabBarController
beautiful TabBar with custom styles and animations

## Demo
Here are some style of demos using `TVGTabBarController`.

| default style | With no tilte | pointerStyle => Line |
|:---:|:---:|:---:|
| <img src="https://github.com/TalebRafiepour/TVGTabBarController/blob/master/screenshots/1.png" width="200"> | <img src="https://github.com/TalebRafiepour/TVGTabBarController/blob/master/screenshots/2.png" width="200"> | <img src="https://github.com/TalebRafiepour/TVGTabBarController/blob/master/screenshots/3.png" width="200"> 

| change attrs colors | change attrs colors | change attrs colors |
|:---:|:---:|:---:|
| <img src="https://github.com/TalebRafiepour/TVGTabBarController/blob/master/screenshots/4.png" width="200"> | <img src="https://github.com/TalebRafiepour/TVGTabBarController/blob/master/screenshots/5.png" width="200"> | <img src="https://github.com/TalebRafiepour/TVGTabBarController/blob/master/screenshots/6.png" width="200"> 

| with landscape mode |
|:---:|
| <img src="https://github.com/TalebRafiepour/TVGTabBarController/blob/master/screenshots/7.png" width="200"> |


## Installation
###  CocoaPods
To integrate TVGTabBarController into your Xcode project using CocoaPods, specify it in your `Podfile`:
```ruby
platform :ios, '13.0'
use_frameworks!

target 'YourProjectName' do
  pod 'TVGTabBarController'
end
```
And then remember to `import TVGTabBarController` module before using it.

###  Manually
You could directly copy and add the folder `TVGTabBarController` which contains 'TVGTabBarController.swift' file to your project.   


## Usage
You could use `TVGTabBarController` like you use `UIViewController`, create a ViewController and exteds it by TVGTabBarController programmatically. Additionally, clone this [Demo](https://github.com/TalebRafiepour/TVGTabBarController) project to find out how easy it is working.
### Programmatically
```swift
    
import UIKit
import TVGTabBarController

class ViewController: TVGTabBarController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTVGTabBar()
    }
    
    fileprivate func initTVGTabBar() {
        var tabBarItem, tabBarItem2, tabBarItem3, tabBarItem4: TVGTabBarItem
        
        tabBarItem  = TVGTabBarItem(image: UIImage(named: "home")!, title: "Home")
        tabBarItem2 = TVGTabBarItem(image: UIImage(named: "like")!, title: "Like")
        tabBarItem3 = TVGTabBarItem(image: UIImage(named: "favorite")!, title: "Favorite")
        tabBarItem4 = TVGTabBarItem(image: UIImage(named: "profile")!, title: "Profile")
        
        let badge = TVGTabBarBadge(value:3, badgeColor: .red)
        tabBarItem.badge = badge
        
        
        let vc1 = storyboard!.instantiateViewController(identifier: "VC1ViewControlelr")
        let vc2 = storyboard!.instantiateViewController(identifier: "VC2ViewControlelr")
        let vc3 = storyboard!.instantiateViewController(identifier: "VC3ViewControlelr")
        let vc4 = storyboard!.instantiateViewController(identifier: "VC4ViewControlelr")
        
        self.delegate = self
        self.viewControllers = [vc1, vc2, vc3,vc4]
        self.tabBarItems = [tabBarItem,tabBarItem2,tabBarItem3,tabBarItem4]
        //self.tabsBadgeColor = UIColor.blue
        //self.tabsSelectedTintColor = .orange
        //self.tabsDefaultTintColor = .gray
        //self.tabsTitleIsHidden = true
        //self.tabsPointerColor = .orange
        //self.animDurationOfVC = 0.15
        //self.tabbarSize = .normal
        //self.tabPointerStyle = .circle
        //self.tabsFont = UIFont(name: "Arial", size: 14)
        //self.selectedViewController = vc3
    }
}


extension ViewController: TVGTabBarControllerDelegate {
    func tabBarController(_ tabBarController: TVGTabBarController, didSelect: UIViewController) {
        print("Delegate success!");
    }
}


```

