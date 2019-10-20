//
//  VC1ViewController.swift
//  TVGTabBarControllerDemo
//
//  Created by Taleb on 10/15/19.
//  Copyright © 2019 Taleb. All rights reserved.
//

import UIKit
import FlexColorPicker
import TVGTabBarController

class VC1ViewController: UIViewController {
    
    enum ColorPickerOwn {
        case badgeColor
        case defaultTintColor
        case selectedTintColor
        case pointerColor
        case tabBarBgColor
    }
    
    @IBOutlet private weak var badgeColorView:UIView!
    @IBOutlet private weak var defaultTintColorView:UIView!
    @IBOutlet private weak var selectedTintColorView:UIView!
    @IBOutlet private weak var pointerColorView:UIView!
    @IBOutlet private weak var tabBarBgColorView:UIView!
    //
    private var colorPickerOwn:ColorPickerOwn = .badgeColor
    private var mColorPicker: DefaultColorPickerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mColorPicker = DefaultColorPickerViewController()
        mColorPicker.delegate = self
        //
        let badgeColorTap = UITapGestureRecognizer(target: self, action: #selector(onBadgeColorViewTapped))
        badgeColorView.addGestureRecognizer(badgeColorTap)
        //
        let defaultTintColorTap = UITapGestureRecognizer(target: self, action: #selector(onDeafultTintColorViewTapped))
        defaultTintColorView.addGestureRecognizer(defaultTintColorTap)
        //
        let selectedTintColorTap = UITapGestureRecognizer(target: self, action: #selector(onSelectedTintColorViewTapped))
        selectedTintColorView.addGestureRecognizer(selectedTintColorTap)
        //
        let pointerColorTap = UITapGestureRecognizer(target: self, action: #selector(onPointerColorViewTapped))
        pointerColorView.addGestureRecognizer(pointerColorTap)
        //
        let tabBarBgColorTap = UITapGestureRecognizer(target: self, action: #selector(onTabBarBgColorViewTapped))
        tabBarBgColorView.addGestureRecognizer(tabBarBgColorTap)
        //
        
        
    }
    
    @objc private func onBadgeColorViewTapped() {
        colorPickerOwn = .badgeColor
        mColorPicker.title = "Badge Color"
        mColorPicker.selectedColor = badgeColorView.backgroundColor ?? UIColor.red
        self.navigationController?.pushViewController(mColorPicker, animated: true)
    }
    
    @objc private func onDeafultTintColorViewTapped() {
        colorPickerOwn = .defaultTintColor
        mColorPicker.title = "TabDefaultTintColor"
        mColorPicker.selectedColor = defaultTintColorView.backgroundColor ?? UIColor.black
        self.navigationController?.pushViewController(mColorPicker, animated: true)
    }
    
    @objc private func onSelectedTintColorViewTapped() {
        colorPickerOwn = .selectedTintColor
        mColorPicker.title = "TabSelectedTintColor"
        mColorPicker.selectedColor = selectedTintColorView.backgroundColor ?? UIColor.black
        self.navigationController?.pushViewController(mColorPicker, animated: true)
    }
    
    @objc private func onPointerColorViewTapped() {
        colorPickerOwn = .pointerColor
        mColorPicker.title = "PointerColor"
        mColorPicker.selectedColor = pointerColorView.backgroundColor ?? UIColor.black
        self.navigationController?.pushViewController(mColorPicker, animated: true)
    }
    
    @objc private func onTabBarBgColorViewTapped() {
        colorPickerOwn = .tabBarBgColor
        mColorPicker.title = "TabBarBackgroundColor"
        mColorPicker.selectedColor = tabBarBgColorView.backgroundColor ?? UIColor.black
        self.navigationController?.pushViewController(mColorPicker, animated: true)
    }
    
    
    
    @IBAction func tabTitleSwitchChanged(_ sender: UISwitch) {
        var tvgTabBarController:TVGTabBarController?
        
        if let parent = parent as? UINavigationController {
            tvgTabBarController = parent.parent as? TVGTabBarController
        }else {tvgTabBarController = parent as? TVGTabBarController}
        
        tvgTabBarController?.tabsTitleIsHidden = !sender.isOn
        
    }
    
    @IBAction func currentTabBadgeValueChanged(_ sender: UIStepper) {
        var tvgTabBarController:TVGTabBarController?
        
        if let parent = parent as? UINavigationController {
            tvgTabBarController = parent.parent as? TVGTabBarController
        }else {tvgTabBarController = parent as? TVGTabBarController}
        //tvgTabBarController?.tabBarItems[0].badge?.value = NSNumber(value: sender.value)
        //if you didn't seted any badge before, you must use below code 
        tvgTabBarController?.tabBarItems[0].badge = TVGTabBarBadge(value: NSNumber(value: sender.value))
    }
    
    @IBAction func tabPointerStyleChanged(_ sender: UISegmentedControl) {
        var tvgTabBarController:TVGTabBarController?
        
        if let parent = parent as? UINavigationController {
            tvgTabBarController = parent.parent as? TVGTabBarController
        }else {tvgTabBarController = parent as? TVGTabBarController}
        
        var pointerStyle = TVGPointerStyle.line
        if sender.selectedSegmentIndex == 0 {pointerStyle = .circle}
        
        tvgTabBarController?.tabPointerStyle = pointerStyle
    }
    
    @IBAction func tabItemSizeChanged(_ sender: UISegmentedControl) {
        var tvgTabBarController:TVGTabBarController?
        
        if let parent = parent as? UINavigationController {
            tvgTabBarController = parent.parent as? TVGTabBarController
        }else {tvgTabBarController = parent as? TVGTabBarController}
        
        var tabBarSize = TVGTabBarSize.large
        if sender.selectedSegmentIndex == 1 {
            tabBarSize = .normal
        }else if sender.selectedSegmentIndex == 2 {
            tabBarSize = .small
        }
        
        tvgTabBarController?.tabbarSize = tabBarSize
    }
    
}

extension VC1ViewController : ColorPickerDelegate {
    
    func colorPicker(_ colorPicker: ColorPickerController, selectedColor: UIColor, usingControl: ColorControl) {
    }
    
    func colorPicker(_ colorPicker: ColorPickerController, confirmedColor: UIColor, usingControl: ColorControl) {
        
        var tvgTabBarController:TVGTabBarController?
        
        if let parent = parent as? UINavigationController {
            tvgTabBarController = parent.parent as? TVGTabBarController
        }else {tvgTabBarController = parent as? TVGTabBarController}
        
        switch colorPickerOwn {
        case .badgeColor:
            tvgTabBarController?.tabsBadgeColor = confirmedColor
            badgeColorView.backgroundColor = confirmedColor
            break
            
        case .defaultTintColor:
            tvgTabBarController?.tabsDefaultTintColor = confirmedColor
            defaultTintColorView.backgroundColor = confirmedColor
            break
            
        case .selectedTintColor:
            tvgTabBarController?.tabsSelectedTintColor = confirmedColor
            selectedTintColorView.backgroundColor = confirmedColor
            break
            
        case .pointerColor:
            tvgTabBarController?.tabsPointerColor = confirmedColor
            pointerColorView.backgroundColor = confirmedColor
            break
            
        case .tabBarBgColor:
            tvgTabBarController?.tabBarBackgroundColor = confirmedColor
            tabBarBgColorView.backgroundColor = confirmedColor
            break
            
        default:
            return
        }
    }
}
