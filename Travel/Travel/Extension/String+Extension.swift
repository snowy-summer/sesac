//
//  String+Extension.swift
//  Travel
//
//  Created by 최승범 on 6/1/24.
//

import Foundation

extension String {
    
    func dateFormatted() -> String {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd HH:mm"
        
        if let formattedDate = formmater.date(from: self) {
            formmater.dateFormat = "yy.MM.dd"
            
            return formmater.string(from: formattedDate)
        }
        
        return "실패"
    }
    
}
