//
//  UIViewUtil.swift
//  cleaner
//
//  Created by zy on 2020/8/26.
//  Copyright © 2020 gramm. All rights reserved.
//

import Foundation
import UIKit

// 方便 在 xib 里面直接 设置各种属性
public extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            if layer.shadowColor != nil {
                return UIColor(cgColor: layer.shadowColor!)
            } else {
                return nil
            }
        }
        set {
            if newValue != nil {
                layer.shadowColor = newValue?.cgColor
                layer.masksToBounds = false
            }
        }
      }
      
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        
        set {
            layer.shadowOpacity = newValue
        }
      }
      
    @IBInspectable var shadowOffset: CGSize {
        get
        {
            return layer.shadowOffset
        }
        
        set
        {
            layer.shadowOffset = newValue
        }
      }
      
    @IBInspectable var shadowRadius: CGFloat {
        get
        {
            return layer.shadowRadius
        }
    
        set
        {
            layer.shadowRadius = newValue
        }
      }
}

// 自定义view，用@IBDesignable修饰
@IBDesignable public class GrammView: UIView {
}
@IBDesignable public class GrammBtn: UIButton {
}
@IBDesignable public class GrammLabel: UILabel {
}
@IBDesignable public class GrammImageView: UIImageView {
}

/// 顶部对其label
public class VerticalTopAlignLabel: UILabel {
    public override func drawText(in rect:CGRect) {
        guard let labelText = text else {  return super.drawText(in: rect) }

        let attributedText = NSAttributedString(string: labelText, attributes: [NSAttributedString.Key.font: font!])
        var newRect = rect
        newRect.size.height = attributedText.boundingRect(with: rect.size, options: .usesLineFragmentOrigin, context: nil).size.height

        if numberOfLines != 0 {
            newRect.size.height = min(newRect.size.height, CGFloat(numberOfLines) * font.lineHeight)
        }

        super.drawText(in: newRect)
    }

}
