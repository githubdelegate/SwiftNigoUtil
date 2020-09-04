//
//  UIView+AnimationUtil.swift
//  cleaner
//
//  Created by zy on 2020/9/4.
//  Copyright © 2020 gramm. All rights reserved.
//

import Foundation
import UIKit


public extension UIButton {
    private struct AssociatedKey {
        static var animationUserInteractKey = "animationUserInteractKey"
    }
    
    /// 是否支持动画过程中支持点击事件 ， 记住 要设置animation option userinteract
    var animationUserInteract: Bool {
        set {
            setAssociated(value: newValue, associatedKey: &AssociatedKey.animationUserInteractKey)
        }
        
        get {
            return getAssociated(associatedKey: &AssociatedKey.animationUserInteractKey)  ?? true
        }
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if animationUserInteract {
            let p = self.convert(point, to: superview)
            if let pre = layer.presentation() {
                return (pre.hitTest(p) != nil)
            }
        }
        return super.point(inside: point, with: event)
    }
}

// 抖动方向枚举
public enum ShakeDirection: Int {
    case horizontal // 水平抖动
    case vertical // 垂直抖动
}

public extension UIView {
    /**
     扩展UIView增加抖动方法

     @param direction：抖动方向（默认是水平方向）
     @param times：抖动次数（默认5次）
     @param interval：每次抖动时间（默认0.1秒）
     @param delta：抖动偏移量（默认2）
     @param completion：抖动动画结束后的回调
     */
    func shake(direction: ShakeDirection = .horizontal, times: Int = 5,
                      interval: TimeInterval = 0.1, delta: CGFloat = 2,
                      completion: (() -> Void)? = nil) {
        // 播放动画
        UIView.animate(withDuration: interval, delay: 0, options: .allowUserInteraction, animations: {
            switch direction {
            case .horizontal:
                self.layer.setAffineTransform(CGAffineTransform(translationX: delta, y: 0))
                break
            case .vertical:
                self.layer.setAffineTransform(CGAffineTransform(translationX: 0, y: delta))
                break
            }
        }) { (_) -> Void in
            // 如果当前是最后一次抖动，则将位置还原，并调用完成回调函数
            if times == 0 {
                UIView.animate(withDuration: interval, animations: { () -> Void in
                    self.layer.setAffineTransform(CGAffineTransform.identity)
                }, completion: { (_) -> Void in
                    completion?()
                })
            }
            // 如果当前不是最后一次抖动，则继续播放动画（总次数减1，偏移位置变成相反的）
            else {
                self.shake(direction: direction, times: times - 1, interval: interval,
                           delta: delta * -1, completion: completion)
            }
        }
    }
}

