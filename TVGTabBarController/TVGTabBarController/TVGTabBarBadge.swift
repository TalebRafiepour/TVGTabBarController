//
//  TVGTabBarBadge.swift
//  TVGTabBarController
//
//  Created by Taleb on 9/30/19.
//  Copyright © 2019 Taleb. All rights reserved.
//

import UIKit

public class TVGTabBarBadge: UIView {
    
    enum TVGBadgeProperties {
        static let TVGBadgeHeight:CGFloat = 18.0
        static let TVGBadgePadding:CGFloat = 5.0
    }
    
    //Badge value for this tab. setting badge value to nil ir zero will always hide that
    public var value: NSNumber? {
        didSet {self.updateBadge()}
    }
    
    //Badge value text color
    public var textColor:UIColor = UIColor.white {didSet{updateBadge()}}
    
    //Optional badge background color. Set to nil to not draw a background
    public var badgeColor: UIColor =
        UIColor.init(red: 253/255, green: 10/255, blue: 0, alpha: 1) {
        didSet{updateBadge()}
    }
    
    private var badgeLabel:UILabelPadding!
    
    //font
    public var font = UIFont(name: "Arial", size: 14) {didSet{updateBadge()}}
    
    //Mark - Lifecycle
    public convenience init(value: NSNumber, badgeColor: UIColor = .red) {
        self.init(frame:CGRect(x:0, y: 0, width: TVGBadgeProperties.TVGBadgeHeight, height: TVGBadgeProperties.TVGBadgeHeight))
        self.badgeColor = badgeColor
        self.value = value
        self.backgroundColor = .clear
        isUserInteractionEnabled = false
        self.badgeLabel = UILabelPadding()
        translatesAutoresizingMaskIntoConstraints = false
        updateBadge()
    }
    
    
    //set self constriant
    public override func updateConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        self.heightAnchor.constraint(equalToConstant: self.frame.height).isActive = true
        if let superView = superview {
            self.topAnchor.constraint(equalTo: superView.topAnchor, constant: -5).isActive = true
            self.leadingAnchor.constraint(equalTo: superView.centerXAnchor, constant: 0).isActive = true
        }
        
        super.updateConstraints()
    }
    
    //MARK - Private
    private func updateBadge() {
        self.badgeLabel.removeFromSuperview()
        if value == nil || value == 0 {
            return
        }
        let title = "\(String(describing: value!))"
        self.badgeLabel.text = title
        self.badgeLabel.textColor = textColor
        self.badgeLabel.backgroundColor = badgeColor
        self.badgeLabel.font = self.font
        
        self.addSubview(self.badgeLabel)
        self.badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.badgeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.badgeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        //
        self.badgeLabel.layer.masksToBounds = true
        self.badgeLabel.layer.cornerRadius = self.bounds.height*0.45
    }
    
}

//padding label
fileprivate class UILabelPadding: UILabel {

    let padding = UIEdgeInsets(top: 0.5, left: 4, bottom: 0.5, right: 4)
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize : CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding.left + padding.right
        let heigth = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }
}
