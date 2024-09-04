//
//  RandomImageView.swift
//  SesacSwiftUI
//
//  Created by 최승범 on 9/4/24.
//

import SwiftUI

import SwiftUI

struct RandomImageView: View {
    let url = URL(string: "https://picsum.photos/200")
    @State private var sectionList = ["첫번째 섹션", "두번째 섹션", "세번째 섹션"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach($sectionList, id: \.self) { $item in
                    section(title: $item)
                }
            }
            .navigationTitle("My Random Image")
        }
    }
    
    func section(title: Binding<String>) -> some View {
        return VStack(alignment: .leading) {
            Text(title.wrappedValue)
                .font(.subheadline)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<6) { item in
                        let image = AsyncImage(url: url)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            
                        NavigationLink {
                            NavigationLazyView(
                                RandomImageDetailView(image, sectionTitle: title)
                            )
                        } label: {
                            image
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding()
    }
}

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: some View {
        build()
    }
}

struct RandomImageDetailView<Content: View>: View {
    let image: Content
    @Binding var sectionTitle: String
    
    init(_ image: Content, sectionTitle: Binding<String>) {
        self.image = image
        self._sectionTitle = sectionTitle
    }
    
    var body: some View {
        VStack {
            image
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            TextField("Edit Section Title", text: $sectionTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
        }
        .navigationTitle(sectionTitle)
    }
}

#Preview {
    RandomImageView()
}
