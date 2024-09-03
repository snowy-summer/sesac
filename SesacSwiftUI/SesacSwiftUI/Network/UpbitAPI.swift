//
//  UpbitAPI.swift
//  SesacSwiftUI
//
//  Created by 최승범 on 9/3/24.
//

import Foundation

struct UpbitAPI {
    
    private init() { }

    static func fetchAllMarket(completion: @escaping ([Market]) -> Void) {
        
        let url = URL(string: "https://api.upbit.com/v1/market/all")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let decodedData = try JSONDecoder().decode([Market].self, from: data)
                DispatchQueue.main.async {
                    completion(decodedData)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    static func fetchAllMarket() async throws -> [Market] {
        
        let url = URL(string: "https://api.upbit.com/v1/market/all")!
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let decodedData = try? JSONDecoder().decode([Market].self, from: data) else {
            throw CustomError.mo
        }
        
        return decodedData
        
        
        
    }
}

enum CustomError: Error {
    case mo
}
