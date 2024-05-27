//
//  UIColor+Extension.swift
//  Travel
//
//  Created by 최승범 on 5/27/24.
//

import UIKit

extension UIColor {
    
   static func randomColor() -> UIColor{
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        
        let color = UIColor(red: red,
                            green: green,
                            blue: blue,
                            alpha: 1.0)
        return color
    }
    
}
