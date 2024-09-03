//
//  CoinMarketView.swift
//  SesacSwiftUI
//
//  Created by 최승범 on 9/3/24.
//

import SwiftUI

struct CoinMarketView: View {
    
    @State private var text = ""
    @State private var markets = [Market]()
    
    private var filterdResult: [Market] {
        if text.isEmpty {
            return markets
        } else {
            return markets.filter { $0.koreanName.contains(text) ||
                $0.englishName.contains(text) ||
                $0.market.contains(text)
            }
        }
    }
    
    var body: some View {
        
        NavigationView {
            
            List {
                ForEach(filterdResult,
                        id: \.self) { item in
                    ZStack {
                        NavigationLink {
                            DetailView(item: item)
                        } label: {
                            
                        }
                        .opacity(0)
                        
                        CoinComponentCell(market: item)
                    }
                }
            }
            .navigationTitle("검색")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $text,
                        placement: .navigationBarDrawer,
                        prompt: "search")
            .task {
                do {
                    let data = try await UpbitAPI.fetchAllMarket()
                    markets = data
                } catch {
                    
                }
            }
        }
    }
}

struct CoinComponentCell: View {
    let market: Market
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(market.koreanName)
                    .bold()
                Text(market.market.split(separator: "-")[1])
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            Spacer()
            Image(systemName: "star")
        }
        .frame(maxWidth: .infinity)
    }
}

struct DetailView: View {
    
    let item: Market
    
    var body: some View {
        Text(item.koreanName)
    }
}

#Preview {
    CoinMarketView()
}
