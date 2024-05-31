//
//  Identifier+Extension.swift
//  Travel
//
//  Created by 최승범 on 5/31/24.
//

import UIKit

extension UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
}
