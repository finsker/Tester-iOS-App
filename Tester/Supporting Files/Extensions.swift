//
//  Extensions.swift
//  Tester
//
//  Created by Nikita Popov on 07.06.2018.
//  Copyright © 2018 Nikita Popov. All rights reserved.
//

import UIKit

extension Int{
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

extension MutableCollection {
    mutating func shuffle(){
        let c = count
        guard c > 1 else {
            return
        }
        for (firstUnshuffled, unshuffledCount) in zip(indices,stride(from: c, to: 1, by: -1)) {
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}
extension UIView {
    
    func sliceCorners(radius: Int) {
        layer.cornerRadius = CGFloat(radius)
        clipsToBounds = true
    }
    func stopLoadAnimation(){
        print("stop")
        //layer.sublayers?.removeFirst()
        guard let subs = layer.sublayers else { return }
        guard let index = subs.index(where: {(item)-> Bool in
            return item.name == "gradient"
        }) else { return }
        
        layer.sublayers?.remove(at: index)
    }
    
    func startLoadAnimation() {
        print("start")
        
        let gradient = CAGradientLayer()
        if let back = self.backgroundColor{
            gradient.colors = [back.cgColor, UIColor.gray.cgColor, back.cgColor]
        } else {
            gradient.colors = [UIColor.clear.cgColor,UIColor.green,UIColor.clear.cgColor]
        }
        gradient.name = "gradient"
        gradient.startPoint = CGPoint(x: 0,y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        gradient.frame = CGRect(origin: layer.bounds.origin, size: CGSize(width: layer.bounds.width, height: layer.bounds.height*5))
        layer.insertSublayer(gradient, at: 0)
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.fromValue = -self.frame.width
        animation.toValue = self.frame.width
        animation.repeatCount = Float.infinity
        animation.duration = 0.6
        gradient.add(animation, forKey: "loadAnimation")
        
    }
    
}
