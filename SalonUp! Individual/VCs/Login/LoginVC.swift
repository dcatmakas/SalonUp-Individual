//
//  ContentView.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 16.05.2023.
//

import SwiftUI
import Firebase
import FirebaseAuth
import LoadingView

struct LoginVC: View {
    
    private let backgroundColor = UIColor(hex: "#7557D6")
    
    @State private var signInError: Bool = false
    @State private var errorMessage: String = ""
    
    @State var emailText: String = ""
    @State var passwordText: String = ""
    @State var goFeedVC: Bool = false
    @State var goSignUpVC: Bool = false
    @State var isPasswordVisible: Bool = false
    
    var body: some View {
        
        GeometryReader { geo in
            
            Color(backgroundColor).ignoresSafeArea()

            ZStack {
                
                Image("SalonUp! Simge")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()
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
                            .fontWeight(.light)
                            .font(Font.system(size: 30))
                    }
                    
                    Spacer()
                    
                    ZStack {
                        Rectangle()
                            .frame(width: .infinity, height: 50)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                        
                        HStack {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(Color("MainColor"))
                                .padding(.leading)
                            
                            TextField("Mail Adresi", text: $emailText)
                                .textContentType(.emailAddress)
                                .padding(.trailing)
                        }
                        
                    }
                    .padding()
                    
                    ZStack {
                        Rectangle()
                            .frame(width: .infinity, height: 50)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                        
                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundColor(Color("MainColor"))
                                .padding(.leading, 18)
                            
                            if isPasswordVisible {
                                TextField("Şifre", text: $passwordText)
                                    .textContentType(.newPassword)
                                    .padding(.trailing)
                            } else {
                                SecureField("Şifre", text: $passwordText)
                                    .textContentType(.newPassword)
                                    .padding(.trailing)
                            }
                            
                            Button {
                                isPasswordVisible.toggle()
                            } label: {
                                Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(.gray)
                            }
                            .padding(.trailing)
                        }
                            
                    }
                    .padding(.horizontal)
                    
                    VStack {
                        Button {
//                            goFeedVC = true
                            SignIn(email: emailText, password: passwordText)
                            
                        } label: {
                            Text("Giriş Yap")
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color("LoginButtonColor"))
                                .foregroundColor(.white)
                                .cornerRadius(16)
                        }
                        
                        .fullScreenCover(isPresented: $goFeedVC) {
                            FeedVC()
                        }
                    }
                    .padding(.top, 50)
                    .padding(.horizontal)
                    
                    HStack {
                        Button {
                            // Apple ile giriş
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
                            // Google ile giriş
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
                            goSignUpVC = true
                        } label: {
                            Text("Hemen Kaydol")
                                .foregroundColor(Color("LightGray"))
                        }
                        .padding(.bottom, 25)
                        
                        .fullScreenCover(isPresented: $goSignUpVC) {
                            SignUpVC()
                        }

                    }
                    
                }
            }
            
        }
        .onTapGesture {
            hideKeyboard()
        }
        
        .alert(isPresented: $signInError) {
            AlertMessage(title: "Hata!", message: "Bir Hata Oluştu.", dismissButton: "Tamam")
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    private func SignIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authdata, error in
            if error != nil {
                signInError = true
            } else {
                goFeedVC = true
            }
        }
    }
    
    private func AlertMessage(title: String, message: String, dismissButton: String) -> Alert {
        return Alert(
        title: Text(title),
        message: Text(message),
        dismissButton: .default(Text(dismissButton))
        )
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginVC()
    }
}
