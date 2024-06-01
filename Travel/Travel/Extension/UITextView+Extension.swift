//
//  UITextView+Extension.swift
//  Travel
//
//  Created by 최승범 on 6/1/24.
//

import UIKit

extension UITextView {
    var estimatedSizeHeight: CGFloat {
        let size = CGSize(width: self.frame.size.width, height: .infinity)
        let estimatedSize = self.sizeThatFits(size)
        return estimatedSize.height
    }
}
