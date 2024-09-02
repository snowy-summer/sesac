//
//  ProfileView.swift
//  SesacSwiftUI
//
//  Created by 최승범 on 9/2/24.
//

import SwiftUI

import SwiftUI

struct ProfileView: View {
    @State private var nickname: String = ""
    @State private var selectedMBTI: [String] = ["", "", "", ""]
    @State private var isSheet = false
    
    var body: some View {
        VStack {
            
            ProfileImageView()
            TextFieldWithUnderLine(placeholder: "닉네임을 입력해주세요 :)",
                                   nickname: $nickname)
            mbtiView
            Spacer()
            nextButton
            
        }
        .sheet(isPresented: $isSheet, content: {
            SuccessView()
        })
    }
    
    var mbtiView: some View {
        HStack(alignment: .top) {
            Text("MBTI")
                .font(.headline)
            
            VStack {
                HStack(spacing: 8) {
                    MBTICircleButton(letter: "E", selectedMBTI: $selectedMBTI[0])
                    MBTICircleButton(letter: "S", selectedMBTI: $selectedMBTI[1])
                    MBTICircleButton(letter: "T", selectedMBTI: $selectedMBTI[2])
                    MBTICircleButton(letter: "J", selectedMBTI: $selectedMBTI[3])
                }
                
                HStack(spacing: 8) {
                    MBTICircleButton(letter: "I", selectedMBTI: $selectedMBTI[0])
                    MBTICircleButton(letter: "N", selectedMBTI: $selectedMBTI[1])
                    MBTICircleButton(letter: "F", selectedMBTI: $selectedMBTI[2])
                    MBTICircleButton(letter: "P", selectedMBTI: $selectedMBTI[3])
                }
            }
            .padding(.leading)
        }
        .padding()
    }
    
    var nextButton: some View {
        Button(action: {
            isSheet = true
        }) {
            Text("완료")
                .font(.subheadline)
                .bold()
                .foregroundStyle(.white)
                .frame(width: 300, height: 44)
                .background(Capsule().fill(.blue))
        }
        .padding()
    }
}

struct ProfileImageView: View {
    var body: some View {
        VStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
                .overlay(
                    Image(systemName: "camera")
                        .padding(8)
                        .background(Color.white)
                        .clipShape(Circle())
                        .offset(x: 35, y: 35)
                )
        }
        .padding(.top, 50)
    }
}

struct TextFieldWithUnderLine: View {
    
    let placeholder: String
    @Binding var nickname: String
    
    var body: some View {
        VStack {
            TextField(placeholder, text: $nickname)
                .padding(.horizontal)
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.black)
                .padding(.leading, 16)
                .padding(.trailing, 16)
        }.padding()
    }
}

struct MBTICircleButton: View {
    let letter: String
    @Binding var selectedMBTI: String
    
    var body: some View {
        Button(action: {
            selectedMBTI = letter
        }) {
            Text(letter)
                .frame(width: 50, height: 50)
                .foregroundColor(selectedMBTI == letter ? .white : .black)
                .background(selectedMBTI == letter ? Color.blue : Color.white)
                .overlay(
                    Circle()
                        .stroke(Color.gray, lineWidth: 1)
                )
                .cornerRadius(25)
        }
    }
}

#Preview {
    ProfileView()
}
