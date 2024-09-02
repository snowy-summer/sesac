//
//  ContentView.swift
//  SesacSwiftUI
//
//  Created by 최승범 on 9/2/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Hello, My Polaroid")
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                Image(systemName: "star")
                    .resizable()
                    .frame(width: 200, height: 200)
                Spacer()
                NavigationLink("시작하기") {
                    ProfileView()
                }
                .font(.subheadline)
                .bold()
                .foregroundStyle(.white)
                .frame(width: 300, height: 44)
                .background(Capsule().fill(.blue))
                .padding()
                
            }
        }
    }
}

#Preview {
    ContentView()
}
