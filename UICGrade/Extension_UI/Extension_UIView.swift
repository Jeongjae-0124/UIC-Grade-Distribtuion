//
//  Extension_UIView.swift
//  UICGrade
//
//  Created by Jeongjae on 11/3/22.
//

import UIKit

extension UIView{
    @IBInspectable var borderWidth:CGFloat{
        set{
            layer.borderWidth=newValue
        }
        get{
            return layer.borderWidth
        }
    }
    @IBInspectable var borderColor:UIColor?{
        set{
            guard let uiColor = newValue else{return}
            layer.borderColor=uiColor.cgColor
        }
        get{
            guard let color = layer.borderColor else{return nil}
            return UIColor(cgColor:color)
        }
    }
}
