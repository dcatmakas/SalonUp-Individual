//
//  ProfileVC.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 30.05.2023.
//

import SwiftUI

struct ProfileVC: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var name: String = ""
    @State var surname: String = ""
    
    var body: some View {
        
        VStack {
            VStack {
                HStack {
                    Image("dogukan")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                }
                
                HStack {
                    Text("Doğukan Çatmakaş")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .fontWeight(.bold)
                        .font(.title)
                        .padding()
                }
            }
            
            VStack {
                ZStack {
                    Rectangle()
                        .frame(width: .infinity, height: 50)
                        .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(colorScheme == .dark ? Color.white : Color.black)
                        )
                        .cornerRadius(16)
                    
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                            .padding(.leading)
                        
                        TextField("Doğukan", text: $name)
                            .textContentType(.emailAddress)
                            .padding(.trailing)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }

                }
                .padding()
                
                ZStack {
                    Rectangle()
                        .frame(width: .infinity, height: 50)
                        .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(colorScheme == .dark ? Color.white : Color.black)
                        )
                        .cornerRadius(16)
                    
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                            .padding(.leading)
                        
                        TextField("Çatmakaş", text: $surname)
                            .textContentType(.emailAddress)
                            .padding(.trailing)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }

                }
                .padding(.horizontal)
                
                ZStack {
                    Rectangle()
                        .frame(width: .infinity, height: 50)
                        .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(colorScheme == .dark ? Color.white : Color.black)
                        )
                        .cornerRadius(16)
                    
                    HStack {
                        Image(systemName: "figure.dress.line.vertical.figure")
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                            .padding(.leading)
                        
                        TextField("Erkek", text: $name)
                            .textContentType(.emailAddress)
                            .padding(.trailing)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }

                }
                .padding()
            }
            
        }
        .background(colorScheme == .dark ? Color("DarkModeColor") : .white)
    }
}

struct ProfileVC_Previews: PreviewProvider {
    static var previews: some View {
        ProfileVC()
    }
}
