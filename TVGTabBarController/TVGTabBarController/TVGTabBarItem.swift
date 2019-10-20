//
//  TVGTabBarItem.swift
//  TVGTabBarController
//
//  Created by Taleb on 9/30/19.
//  Copyright © 2019 Taleb. All rights reserved.
//

import UIKit


//Pointer Style
public enum TVGPointerStyle {
    case circle
    case line
}

public class TVGTabBarItem: UIButton {
    
    //properties
    private let itemPadding: CGFloat = 12.0
    private var isSelect: Bool = false {
        didSet {updateTintColor()}
    }
    
    private var constraintsLoaded = false
    
    public var pointerColor:UIColor = .red {
        didSet {
            self.tabPointerView.backgroundColor = pointerColor
        }
    }
    
    public var defaultTintColor:UIColor = .black {
        didSet{updateTintColor()}
    }
    
    public var selectedTintColor:UIColor = .black {
        didSet{updateTintColor()}
    }
    
    public var titleIsHidden: Bool = false {
        didSet{
            self.tabTitle?.isHidden = titleIsHidden
            if self.isSelect {
                if titleIsHidden {self.tabImageView.alpha = 1.0}
                else {self.tabImageView.alpha = 0.0}
            }
        }
    }
    
    //TabItem font
    public var itemFont:UIFont? = UIFont.systemFont(ofSize: 14) {
        didSet{
            self.tabTitle?.font = itemFont
            print("font setted : \(self.itemFont!.pointSize)")
        }
    }
    
    //TabItem Pointer Style
    public var pointerStyle:TVGPointerStyle = .circle {
        didSet{updatePointerStyle(style: pointerStyle)}
    }
    
    //TabItem Badge Color
    public var tabBadgeColor:UIColor =
        UIColor.init(red: 253/255, green: 10/255, blue: 0, alpha: 1) {
        didSet {self.badge?.badgeColor = tabBadgeColor}
    }
    
    
    //UIView that houses the selected/unselected icons
    private var container: UIView!
    
    //Tab title
    var tabTitle: UILabel?
    
    //TabItem ImageView
    private var tabImageView: UIImageView!
    
    //TabItem pointer view
    private var tabPointerView: UIView!
    
    //An optional badge to display in the top right corner
    public var badge: TVGTabBarBadge? {
        willSet {
            if let badge = badge {
                badge.removeFromSuperview()
            }
        }
        
        didSet {
            if let badge = badge {
                badge.badgeColor = tabBadgeColor
                self.addSubview(badge)
                setNeedsUpdateConstraints()
            }
        }
    }
    
    convenience public init(image: UIImage) {
        self.init()
        customInit(image: image, title: nil)
    }
    
    convenience public init(image: UIImage, title: String?) {
        self.init()
        customInit(image: image, title: title)
    }
    
    private func customInit(image: UIImage, title: String?) {
        //remove all subviews
        subviews.forEach({ $0.removeFromSuperview()})
        //create container
        self.container = UIView()
        self.addSubview(self.container)
        self.container.isUserInteractionEnabled = false
        
        //create iamgeview
        self.tabImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        tabImageView.image = image.withRenderingMode(.alwaysOriginal).withTintColor(defaultTintColor)
        self.tabImageView.contentMode = .scaleAspectFit
        self.container.addSubview(self.tabImageView)
        
        //create title
        if title != nil {
            self.tabTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            let text = NSMutableAttributedString(string: title!)
            text.addAttribute(.foregroundColor, value: defaultTintColor, range: NSRange(location: 0, length: text.length))
            text.addAttribute(.font, value: itemFont ?? UIFont.systemFont(ofSize: 14), range: NSRange(location: 0, length: text.length))
            self.tabTitle?.attributedText = text
            self.tabTitle?.textAlignment = .center
            self.tabTitle?.numberOfLines = 0
            //add title to container
            self.container.addSubview(self.tabTitle!)
            self.tabTitle!.alpha = 0
        }
        
        //create pointer
        self.tabPointerView = UIView(frame: CGRect(x: 0, y: 0, width: bounds.height/10, height: bounds.height/10))
        self.tabPointerView.backgroundColor = pointerColor
        self.addSubview(self.tabPointerView)
        self.tabPointerView.alpha = 0
        
        setNeedsUpdateConstraints()
    }
    
    override public func updateConstraints() {
        if(!constraintsLoaded) {
            translatesAutoresizingMaskIntoConstraints = false
            //add container constraints
            self.container.translatesAutoresizingMaskIntoConstraints = false
            self.container.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -itemPadding).isActive = true
            self.container.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -itemPadding).isActive = true
            self.container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            self.container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            
            //add contraints to images
            self.tabImageView.translatesAutoresizingMaskIntoConstraints = false
            self.tabImageView.centerXAnchor.constraint(equalTo: self.container.centerXAnchor).isActive = true
            self.tabImageView.centerYAnchor.constraint(equalTo: self.container.centerYAnchor).isActive = true
            self.tabImageView.widthAnchor.constraint(equalTo: self.container.widthAnchor, constant: -itemPadding/2).isActive = true
            self.tabImageView.heightAnchor.constraint(equalTo: self.container.heightAnchor, constant: -itemPadding/2).isActive = true
            
            //add constriant to title
            if self.tabTitle != nil {
                self.tabTitle!.translatesAutoresizingMaskIntoConstraints = false
                self.tabTitle!.heightAnchor.constraint(equalTo: self.container.heightAnchor, constant: -itemPadding/2).isActive = true
                self.tabTitle!.widthAnchor.constraint(equalTo: self.container.widthAnchor, constant: -itemPadding/2).isActive = true
                self.tabTitle!.centerXAnchor.constraint(equalTo: self.container.centerXAnchor).isActive = true
                self.tabTitle!.centerYAnchor.constraint(equalTo: self.container.centerYAnchor).isActive = true
            }
            
            //add constraint to pointer
            updatePointerStyle(style: self.pointerStyle)
            
            constraintsLoaded = true
        }
        
        super.updateConstraints()
        
        
    }
    
    
    //set PointerStyle
    private func updatePointerStyle(style: TVGPointerStyle) {
        
        self.tabPointerView.removeFromSuperview()
        self.tabPointerView.removeConstraints(self.tabPointerView.constraints)
        self.addSubview(self.tabPointerView)
        
        self.tabPointerView.translatesAutoresizingMaskIntoConstraints = false
        self.tabPointerView.centerXAnchor.constraint(equalTo: self.tabPointerView.superview!.centerXAnchor).isActive = true
        self.tabPointerView.bottomAnchor.constraint(equalTo: self.tabPointerView.superview!.bottomAnchor).isActive = true
        //
        if style == .circle {
            self.tabPointerView.widthAnchor.constraint(equalToConstant: 4).isActive = true
            self.tabPointerView.heightAnchor.constraint(equalToConstant: 4).isActive = true
            self.tabPointerView.layer.cornerRadius = 2
        }else {
            self.tabPointerView.widthAnchor.constraint(equalTo: self.tabPointerView!.superview!.widthAnchor, multiplier: 0.75) .isActive = true
            self.tabPointerView.heightAnchor.constraint(equalTo: self.tabPointerView!.superview!.heightAnchor, multiplier: 0.05) .isActive = true
            self.tabPointerView.layer.cornerRadius = 4
        }
    }
    
    
    func updateTintColor() {
        UIView.animate(withDuration: 0.15) {
            if self.isSelect {
                self.tabImageView.image = self.tabImageView.image?.withRenderingMode(.alwaysOriginal).withTintColor(self.selectedTintColor)
                self.tabTitle?.textColor = self.selectedTintColor
            }else {
                self.tabImageView.image = self.tabImageView.image?.withRenderingMode(.alwaysOriginal).withTintColor(self.defaultTintColor)
                self.tabTitle?.textColor = self.defaultTintColor
            }
        }
    }
    
    
    //set Selected
    func selectTab(animated: Bool = true) {
        if isSelect {return}
        else {isSelect = true}
        
        let animDuration = animated ? 0.2 : 0.0
        UIView.animate(withDuration: animDuration) {
            self.tabPointerView.alpha = 1.0
            if self.tabTitle != nil && !self.titleIsHidden {
                self.tabImageView.alpha = 0.0
                self.tabTitle?.alpha = 1.0
            }
        }
    }
    
    //set unSelected
    func unSelectTab(animated: Bool = true) {
        if !isSelect {return}
        else {isSelect = false}
        
        let animDuration = animated ? 0.15 : 0.0
        UIView.animate(withDuration: animDuration) {
            self.tabPointerView.alpha = 0.0
            if self.tabTitle != nil && !self.titleIsHidden {
                self.tabImageView.alpha = 1.0
                self.tabTitle?.alpha = 0.0
            }
        }
    }
    
    
}
