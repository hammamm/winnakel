//
//  UIView+Extension.swift
//  WainNakel
//
//  Created by hammam abdulaziz on 15/04/1442 AH.
//  Copyright © 2020 Hammam Abdulaziz - devhammam@gmail.com All rights reserved.

import UIKit

extension UIView{
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2)
        self.layer.masksToBounds = true
    }
    
    func setWidth(width:CGFloat) {
        var frame:CGRect = self.frame
        frame.size.width = width
        self.frame = frame
    }
    
    func setHeight(height:CGFloat) {
        var frame:CGRect = self.frame
        frame.size.height = height
        self.frame = frame
    }
}
