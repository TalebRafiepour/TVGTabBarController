//
//  TVGTabBarController.swift
//  TVGTabBarController
//
//  Created by Taleb on 9/30/19.
//  Copyright © 2019 Taleb. All rights reserved.
//

import UIKit

public protocol TVGTabBarControllerDelegate: AnyObject {
    func tabBarController(_ tabBarController: TVGTabBarController, didSelect: UIViewController)
}

public enum TVGTabBarSize:CGFloat {
    case large = 48.0
    case normal = 40.0
    case small = 36.0
}

open class TVGTabBarController: UIViewController {
    
    //Delegate for adding actions to tab clicks
    open var delegate: TVGTabBarControllerDelegate?
    
    //Custom tab bar
    private var tabBar: TVGTabBar?
    
    //tabbar item size
    open var tabbarSize: TVGTabBarSize = .normal {
        didSet{
            reinitTabBar()
        }
    }
    
    open var animDurationOfVC: Double = 0.15
    
    //tabs badge color
    open var tabsBadgeColor:UIColor =
        UIColor.init(red: 253/255, green: 10/255, blue: 0, alpha: 1) {
        didSet {
            if let tabbar = tabBar {
                for item in tabbar.tabBarItems {
                    item.tabBadgeColor  = tabsBadgeColor
                }
            }
        }
    }
    
    //TabBarItem's default tint color
    open var tabsDefaultTintColor: UIColor = .black {
        didSet {
            if let tabbar = tabBar {
                for item in tabbar.tabBarItems {
                    item.defaultTintColor  = tabsDefaultTintColor
                }
            }
        }
    }
    
    //TabBarItem's selected tint color
    open var tabsSelectedTintColor: UIColor = .black {
        didSet {
            if let tabbar = tabBar {
                for item in tabbar.tabBarItems {
                    item.selectedTintColor  = tabsSelectedTintColor
                }
            }
        }
    }
    
    //TabBarItem's selected tint color
    open var tabsTitleIsHidden: Bool = false {
        didSet {
            if let tabbar = tabBar {
                for item in tabbar.tabBarItems {
                    item.titleIsHidden  = tabsTitleIsHidden
                }
            }
        }
    }
    
    //TabBarItem's selected tint color
    open var tabsPointerColor: UIColor = .black {
        didSet {
            if let tabbar = tabBar {
                for item in tabbar.tabBarItems {
                    item.pointerColor  = tabsPointerColor
                }
            }
        }
    }
    
    //TabBarItem's line width
    open var tabPointerStyle: TVGPointerStyle = .circle {
        didSet {
            if let tabbar = tabBar {
                for item in tabbar.tabBarItems {
                    item.pointerStyle  = tabPointerStyle
                }
            }
        }
    }
    
    //TabBarItem's line width
    open var tabsFont: UIFont? = UIFont.systemFont(ofSize: 14) {
        didSet {
            if let tabbar = tabBar {
                for item in tabbar.tabBarItems {
                    item.itemFont  = tabsFont
                }
            }
        }
    }
    
    //TabBar Background Color
    open var tabBarBackgroundColor:UIColor = .white {
        didSet{self.tabBar?.backgroundColor = self.tabBarBackgroundColor}
    }
    
    //vc views
    private var vcViews = [UIView]()
    
    //View controllers associated with the tabs
    open var viewControllers: [UIViewController] = []  {
        didSet {
            vcViews = []
            self.children.forEach{$0.removeFromParent()}
            for vc in viewControllers {
                if let vcView = vc.view, let _ = tabBar {
                    vcViews.append(vcView)
                    self.addChild(vc)
                }
            }
        }
    }
    
    //Items that are displayed in the tab bar
    open var tabBarItems: [TVGTabBarItem] = [] {
        didSet {
            for i in 1..<tabBarItems.count {
                let item1: TVGTabBarItem? = tabBarItems[i - 1]
                let item2: TVGTabBarItem? = tabBarItems[i]
                if (item1?.tabTitle != nil && item2?.tabTitle == nil) || (item1?.tabTitle == nil && item2?.tabTitle != nil) {
                    let myException = NSException(name: NSExceptionName("TVGTabBarControllerException"), reason: "Tabs must have all text or no text", userInfo: nil)
                    print("Error: \(myException)")
                    return
                }
            }
            if let tabBar = tabBar {
                tabBar.tabBarItems = tabBarItems
            }
        }
    }
    
    
    private func replaceContainerView(vcView: UIView) {
        vcViews.forEach{$0.removeFromSuperview()}
        
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height-(tabBar?.frame.height ?? 48))
        vcView.frame = frame
        vcView.alpha = 0.0
        self.view.insertSubview(vcView, at: 0)
        
        UIView.animate(withDuration: animDurationOfVC) {
            vcView.alpha = 1
        }
        
    }
    
    //Currently selected view controller
    open var selectedViewController: UIViewController? {
        didSet {
            if let _ = tabBar, let selectedViewController = selectedViewController,
                let selectedPosition = viewControllers.firstIndex(of: selectedViewController) {
                let vcView = vcViews[selectedPosition]
                replaceContainerView(vcView: vcView)
                delegate?.tabBarController(self, didSelect: selectedViewController)
            }
        }
    }
    
    override open var hidesBottomBarWhenPushed: Bool {
        didSet {
            self.tabBar?.isHidden = hidesBottomBarWhenPushed
        }
    }
    
    // MARK: - Lifecycle
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }
    
    private func commonInit() {
        hidesBottomBarWhenPushed = false
        // init tab bar
        tabBar = TVGTabBar()
        if let tabBar = tabBar {
            tabBar.delegate = self
            view.addSubview(tabBar)
            tabBar.tabBarHeight = self.tabbarSize.rawValue
            tabBar.backgroundColor = tabBarBackgroundColor
        }
    }
    
    private func reinitTabBar() {
        if let tabbar = tabBar {
            tabbar.removeConstraints(tabbar.constraints)
            tabbar.removeFromSuperview()
        }
        else {return}
        tabBar = TVGTabBar()
        if let tabBar = tabBar {
            tabBar.delegate = self
            tabBar.tabBarHeight = self.tabbarSize.rawValue
            tabBar.backgroundColor = tabBarBackgroundColor
            self.view.addSubview(tabBar)
            tabBar.tabBarItems = self.tabBarItems
        }
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        //make sure we always have a selected tab
        if selectedViewController == nil && viewControllers.count > 0 {
            selectedViewController = viewControllers[0]
        }else {
            let temp = self.delegate
            self.delegate = nil
            tabBar?.selectedTabItem(viewControllers.firstIndex(of: selectedViewController!) ?? 0, animated: false)
            self.delegate = temp
        }
    }
    
    open func setSelectedViewController(_ viewController: UIViewController, animated: Bool) {
        if viewController == selectedViewController {return}
        selectedViewController = viewController
        if let tabBar = tabBar {
            let index = (viewControllers as NSArray).index(of: viewController)
            tabBar.selectedTabItem(index, animated: animated)
        }
    }
}

extension TVGTabBarController: TVGTabBarDelegate {
    func tabBar(_ tabBar: TVGTabBar, didSelectItemAt index: Int) {
        selectedViewController = viewControllers[index]
    }
}
