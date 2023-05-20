//
//  ContentView.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 16.05.2023.
//

import SwiftUI

struct LoginVC: View {
    
    private let backgroundColor = UIColor(hex: "#7557D6")
    
    @State var emailText: String = ""
    @State var passwordText: String = ""
    
    var body: some View {
        
        NavigationView {
            GeometryReader { geo in
                
                Color(backgroundColor).ignoresSafeArea()
                
                ZStack {
                    
                    Image("SalonUp! Simge")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .opacity(0.11)
                    
                    VStack {
                        HStack {
                            Text("SalonUp!")
                                .foregroundColor(.white)
                                .fontWeight(.heavy)
                                .font(Font.system(size: 60))
                                .padding(.top, 40)
                        }
                        
                        HStack {
                            Text("Individual")
                                .foregroundColor(.white)
                                .font(Font.system(size: 30))
                        }
                        
                        Spacer()
                        
                        ZStack {
                            Rectangle()
                                .frame(width: .infinity, height: 50)
                                .foregroundColor(.white)
                                .cornerRadius(16)
                            
                            TextField("Mail Adresinizi Giriniz", text: $emailText)
                                .textContentType(.emailAddress)
                                .padding(.horizontal)
                            
                        }
                        .padding()
                        
                        ZStack {
                            Rectangle()
                                .frame(width: .infinity, height: 50)
                                .foregroundColor(.white)
                                .cornerRadius(16)
                            
                            SecureField("Şifrenizi Giriniz", text: $passwordText)
                                .textContentType(.password)
                                .padding(.horizontal)
                            
                        }
                        .padding(.horizontal)
                        
                        VStack {
                            Button {
                                print("Giriş Clicked")
                            } label: {
                                Text("Giriş Yap")
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color("LoginButtonColor"))
                                    .foregroundColor(.white)
                                    .cornerRadius(16)
                            }
                        }
                        .padding(.top, 50)
                        .padding(.horizontal)
                        
                        HStack {
                            Button {
                                print("test")
                            } label: {
                                ZStack {
                                    Rectangle()
                                        .frame(width: .infinity, height: 50)
                                        .foregroundColor(.black)
                                        .cornerRadius(16)
                                    
                                    HStack {
                                        Image("AppleLogo")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                        
                                        Text("Apple İle Giriş")
                                            .foregroundColor(.white)
                                            .fontWeight(.light)
                                            .font(Font.system(size: 15))
                                    }
                                }
                            }
                            
                            Button {
                                print("test")
                            } label: {
                                ZStack {
                                    Rectangle()
                                        .frame(width: .infinity, height: 50)
                                        .foregroundColor(.white)
                                        .cornerRadius(16)
                                    
                                    HStack {
                                        Image("GoogleLogo")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                        
                                        Text("Google İle Giriş")
                                            .foregroundColor(.black)
                                            .fontWeight(.light)
                                            .font(Font.system(size: 15))
                                    }
                                }
                            }
                        }
                        .padding(.top, 5)
                        .padding(.horizontal)
                        
                        Spacer()
                        
                        VStack {
                            Text("Hesabın Yok Mu?")
                                .foregroundColor(.white)
                                .font(Font.system(size: 18))
                                .padding(.bottom, 1)
                            
                            Button {
                                print("Sign Up Clicked")
                            } label: {
                                Text("Hemen Kaydol")
                                    .foregroundColor(Color("LightGray"))
                            }
                            .padding(.bottom, 25)
                            
                            
                        }
                        
                    }
                }
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginVC()
    }
}
