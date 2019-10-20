//
//  TVGTabBar.swift
//  TVGTabBarController
//
//  Created by Taleb on 9/30/19.
//  Copyright © 2019 Taleb. All rights reserved.
//

import UIKit

protocol TVGTabBarDelegate: AnyObject {
    func tabBar(_ tabBar: TVGTabBar, didSelectItemAt index: Int)
}

class TVGTabBar: UIView {
   
    //Standard Tool bar Height
    public var tabBarHeight:CGFloat = 40
    
    //Tab Bar Padding
    private let tabBarPadding:CGFloat = 2
    
    //Helps when figuring out the order of the tab item without resorting to it's superview
    private let TVGUniqueTag: Int = 57490
    
    //Currently selected Tab
    var currentTaBarIndex:Int = 0
    
    //State of constraints
    private var constraintsLoaded = false
    
    //Delegate used to add external action to a tab bar click
    var delegate: TVGTabBarDelegate?
    
    //Container for "traversing" from one item to another
    var animationContainer: UIView?
    
    //Container for the tab bar - this is so the toolbar stays the standard height on iphoneX
    var tabBarContainer: UIView?
    
    //All tabs in the tab bar
    var tabBarItems: [TVGTabBarItem] = [] {
        didSet {
            updateTabBarItems(tabBarItems)
        }
    }
    
    override public func updateConstraints() {
        if(!constraintsLoaded) {
            //add self constriant
            let bottomOffset = superview!.safeAreaInsets.bottom == 0 ? 4.0 : superview!.safeAreaInsets.bottom
            self.heightAnchor.constraint(equalToConstant: self.tabBarHeight + bottomOffset).isActive = true
            self.leadingAnchor.constraint(equalTo: self.superview!.leadingAnchor).isActive = true
            self.trailingAnchor.constraint(equalTo: self.superview!.trailingAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: self.superview!.bottomAnchor).isActive = true
            
            //tool bar container constraints
            tabBarContainer?.topAnchor.constraint(equalTo: tabBarContainer!.superview!.topAnchor, constant: CGFloat(self.tabBarPadding)).isActive = true
            tabBarContainer?.leadingAnchor.constraint(equalTo: tabBarContainer!.superview!.leadingAnchor).isActive = true
            tabBarContainer?.trailingAnchor.constraint(equalTo: tabBarContainer!.superview!.trailingAnchor).isActive = true
            tabBarContainer?.heightAnchor.constraint(equalToConstant: self.tabBarHeight).isActive = true
            
            //container constraints
            animationContainer?.topAnchor.constraint(equalTo: animationContainer!.superview!.topAnchor).isActive = true
            animationContainer?.trailingAnchor.constraint(equalTo: animationContainer!.superview!.trailingAnchor).isActive = true
            animationContainer?.leadingAnchor.constraint(equalTo: animationContainer!.superview!.leadingAnchor).isActive = true
            animationContainer?.bottomAnchor.constraint(equalTo: animationContainer!.superview!.bottomAnchor).isActive = true
            
            //tabBarItem constraints
            for i in 0..<tabBarItems.count {
                let item = tabBarItems[i]
                item.widthAnchor.constraint(equalTo: item.superview!.widthAnchor, multiplier: 1/CGFloat(tabBarItems.count)).isActive = true
                item.heightAnchor.constraint(equalTo: item.superview!.heightAnchor).isActive = true
                if(i == 0){
                    item.leadingAnchor.constraint(equalTo: item.superview!.leadingAnchor).isActive = true
                } else {
                    let prevItem = tabBarItems[i - 1]
                    item.leadingAnchor.constraint(equalTo: prevItem.trailingAnchor).isActive = true
                }
            }
            
            
            constraintsLoaded = true
        }
        
        super.updateConstraints()
    }
    
    // MARK: - Lifecycle
    convenience init() {
        self.init(frame: CGRect.zero)
        customInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        customInit()
    }
    
    //MARK: - IBAction
    @objc private func didSelectItem(_ sender: TVGTabBarItem) {
        let newItem = sender
        if currentTaBarIndex == tabBarItems.firstIndex(of: sender) {
            return
        }
        
        isUserInteractionEnabled = false
        tabBarItems[currentTaBarIndex].unSelectTab()
        transitionToItem(newItem, true)
    }
    
    // MARK: - Private
    private func customInit() {
        //set default color
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 0.35
        layer.shadowOffset = .zero
        layer.shadowRadius = 5
        
        tabBarContainer = UIView()
        animationContainer = UIView()
        
        if let tabBarContainer = tabBarContainer, let animationContainer = animationContainer {
            tabBarContainer.backgroundColor = .clear
            addSubview(tabBarContainer)
            
            animationContainer.backgroundColor = .clear
            animationContainer.isUserInteractionEnabled = false
            tabBarContainer.addSubview(animationContainer)
            
            tabBarContainer.translatesAutoresizingMaskIntoConstraints = false
            animationContainer.translatesAutoresizingMaskIntoConstraints = false
        }
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Public
    public func selectedTabItem(_ index: Int, animated: Bool) {
        if tabBarItems.count <= index {return}
        isUserInteractionEnabled = false
        tabBarItems[currentTaBarIndex].unSelectTab()
        let newItem = tabBarItems[index]
        transitionToItem(newItem, animated)
    }
    
    
    public func updateTabBarItems(_ tabBarItems: [TVGTabBarItem]) {
        for i in 0..<tabBarItems.count {
            let tabBarItem = tabBarItems[i]
            if let toolBarContainer = tabBarContainer {
                toolBarContainer.addSubview(tabBarItem)
            }
            tabBarItem.tag = Int(TVGUniqueTag) + i
            if i == currentTaBarIndex {tabBarItem.selectTab()}
            tabBarItem.isUserInteractionEnabled = true
            tabBarItem.addTarget(self, action: #selector(didSelectItem(_:)), for: .touchUpInside)
        }
    }
    
    func transitionToItem(_ newItem: TVGTabBarItem, _ animated: Bool) {
        currentTaBarIndex = tabBarItems.firstIndex(of: newItem) ?? 0
        self.isUserInteractionEnabled = true
        tabBarItems[currentTaBarIndex].isUserInteractionEnabled = true
        tabBarItems[currentTaBarIndex].selectTab(animated: animated)
        layoutIfNeeded()
        
        delegate?.tabBar(self, didSelectItemAt: currentTaBarIndex)
    }
}
