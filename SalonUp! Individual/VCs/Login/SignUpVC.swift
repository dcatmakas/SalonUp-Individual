//
//  SignUpVC.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 24.05.2023.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct SignUpVC: View {
    
    @State var emailText: String = ""
    @State var usernameText: String = ""
    @State var passwordText: String = ""
    @State var passwordAgainText: String = ""
    @State var isPasswordVisible: Bool = false
    @State var goFeedVC: Bool = false
    @State var goLoginVC: Bool = false
    
    var body: some View {
        
        GeometryReader { geo in
            
            Color("MainColor").ignoresSafeArea()
            
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
                    
                    VStack {
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
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        
                        ZStack {
                            Rectangle()
                                .frame(width: .infinity, height: 50)
                                .foregroundColor(.white)
                                .cornerRadius(16)
                            
                            HStack {
                                Image(systemName: "person.fill")
                                    .foregroundColor(Color("MainColor"))
                                    .padding(.leading)
                                
                                TextField("Kullanıcı Adı", text: $usernameText)
                                    .textContentType(.username)
                                    .padding(.trailing)
                            }
                        }
                        .padding(.horizontal)
                        
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
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        
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
                                    TextField("Şifre Tekrar", text: $passwordAgainText)
                                        .padding(.trailing)
                                } else {
                                    SecureField("Şifre Tekrar", text: $passwordAgainText)
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
                    }
                    
                    VStack {
                        Button {
                            goFeedVC = true
//                            SignUp(email: emailText, username: usernameText, password: passwordText)
                            // Kayıt olma işlemleri
                        } label: {
                            Text("Kayıt Ol")
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
                    .padding(.top, 15)
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
                                    
                                    Text("Apple İle Kaydol")
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
                                    
                                    Text("Google İle Kaydol")
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
                        Text("Hesabın Var Mı?")
                            .foregroundColor(.white)
                            .font(Font.system(size: 18))
                            .padding(.bottom, 1)
                            
                        Button {
                            goLoginVC = true
                        } label: {
                            Text("Hemen Giriş Yap")
                                .foregroundColor(Color("LightGray"))
                        }
                        .padding(.bottom, 25)
                        
                        .fullScreenCover(isPresented: $goLoginVC) {
                            LoginVC()
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
    
    private func SignUp(email: String, username: String, password: String) {
        // Kayıt olma işlemleri gerçekleşecek
    }
    
}

struct SignUpVC_Previews: PreviewProvider {
    static var previews: some View {
        SignUpVC()
    }
}
