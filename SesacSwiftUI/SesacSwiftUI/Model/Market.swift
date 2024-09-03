//
//  Market.swift
//  SesacSwiftUI
//
//  Created by 최승범 on 9/3/24.
//

import Foundation

struct Market: Hashable, Codable {
    let market, koreanName, englishName: String

    enum CodingKeys: String, CodingKey {
        case market
        case koreanName = "korean_name"
        case englishName = "english_name"
    }
}
