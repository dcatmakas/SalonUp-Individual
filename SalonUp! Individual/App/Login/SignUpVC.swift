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
    
    @Environment(\.colorScheme) var colorScheme
    
    // Texts
    @State var emailText: String = ""
    @State var usernameText: String = ""
    @State var passwordText: String = ""
    @State var passwordAgainText: String = ""
    
    // Password Visible
    @State var isPasswordVisible: Bool = false
    
    // Navigations
    @State var goFeedVC: Bool = false
    @State var goLoginVC: Bool = false
    
    // Alerts
    @State var showAlert: Bool = false
    @State var alertTitle: String = ""
    @State var alertMessage: String = ""
    @State var alertDismissButton: String = ""
    
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
                                .foregroundColor(colorScheme == .dark ? .black : .white)
                                .cornerRadius(16)
                            
                            HStack {
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(colorScheme == .dark ? Color.white : Color("MainColor"))
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
                                .foregroundColor(colorScheme == .dark ? .black : .white)
                                .cornerRadius(16)
                            
                            HStack {
                                Image(systemName: "person.fill")
                                    .foregroundColor(colorScheme == .dark ? Color.white : Color("MainColor"))
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
                                .foregroundColor(colorScheme == .dark ? .black : .white)
                                .cornerRadius(16)
                            
                            HStack {
                                Image(systemName: "lock.fill")
                                    .foregroundColor(colorScheme == .dark ? Color.white : Color("MainColor"))
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
                                .foregroundColor(colorScheme == .dark ? .black : .white)
                                .cornerRadius(16)
                            
                            HStack {
                                Image(systemName: "lock.fill")
                                    .foregroundColor(colorScheme == .dark ? Color.white : Color("MainColor"))
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
                            // Kayıt olma işlemleri
                            SignUp(email: emailText, username: usernameText, password: passwordText, passwordAgain: passwordAgainText)
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
            
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(alertTitle),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("Tamam"))
                )
            }
            
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    private func SignUp(email: String, username: String, password: String, passwordAgain: String) {
        
        if email != "" && username != "" && password != "" && passwordAgain != "" {
            if isValidEmail(email: emailText) {
                if isValidUsername(username: usernameText) {
                    if isValidPassword(password: passwordText) {
                        if password == passwordAgain {
                            
                            let database = Firestore.firestore()
                            let usernamesRef = database.collection("usernames")
                            let usernameQuery = usernamesRef.whereField("username", isEqualTo: self.usernameText)
                            
                            usernameQuery.getDocuments { QuerySnapshot, error in
                                if let error = error {
                                    showAlert(title: "Hata!", message: "Bir Hata Oluştu.")
                                } else if let snapshot = QuerySnapshot {
                                    if snapshot.documents.count > 0 {
                                        showAlert(title: "Hata!", message: "Bu Kullanıcı Adı Kullanılmaktadır.")
                                    } else {
                                        
                                        Auth.auth().createUser(withEmail: email, password: password) { authdata, error in
                                            if error != nil {
                                                showAlert(title: "Hata!", message: "Kayıt Sırasında Bir Hata Oluştu.")
                                            } else {
                                                guard let userID = authdata?.user.uid else {
                                                    return
                                                }
                                                
                                                let userData = [
                                                    "username": username,
                                                    "userID": userID,
                                                    "email": email
                                                ]
                                                
                                                let usernameData = [
                                                    "username": username,
                                                    "userID": userID
                                                ]
                                                
                                                let usersRef = database.collection("users")
                                                usersRef.document(userID).setData(userData) { error in
                                                    if let error = error {
                                                        showAlert(title: "Hata!", message: "Bir Sorunla Karşılaşıldı.")
                                                    }
                                                    
                                                    database.collection("usernames")
                                                    usernamesRef.document(userID).setData(usernameData) { error in
                                                        if let error = error {
                                                            showAlert(title: "Hata!", message: "Bir Sorunla Karşılaşıldı.")
                                                        }
                                                        
                                                        // Save User Datas On Phone
//                                                        User(username: <#T##String#>, firstName: <#T##String#>, lastName: <#T##String#>, email: <#T##String#>, profileImage: <#T##UIImage#>, userUUID: <#T##UUID#>)
                                                        
                                                        // Sign Up And Log In To The App
                                                        goFeedVC = true
                                                        
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            
                        } else { showAlert(title: "Hata!", message: "Şifreleriniz Uyuşmamaktadır.") }
                    } else { showAlert(title: "Hata!", message: "Şifre En Az 6 Karakterden Oluşmalıdır.") }
                } else { showAlert(title: "Hata!", message: "Kullanıcı Adı Türkçe Karakter İçermemeli ve En Az 3, En Çok 16 Harften Oluşmalıdır.") }
            } else { showAlert(title: "Hata!", message: "Lütfen Geçerli Bir Mail Adresi Giriniz.") }
        } else { showAlert(title: "Hata!", message: "Lütfen Tüm Bilgileri Eksiksiz Bir Şekilde Doldurunuz.") }
        
    }
    
    private func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
    
    private func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isValidUsername(username: String) -> Bool {
        let usernameRegex = "^[a-zA-Z0-9_-]{3,16}$"
        let usernamePredicate = NSPredicate(format:"SELF MATCHES %@", usernameRegex)
        return usernamePredicate.evaluate(with: username)
    }
    
    private func isValidPassword(password: String) -> Bool {
        return password.count >= 6
    }

    
}

struct SignUpVC_Previews: PreviewProvider {
    static var previews: some View {
        SignUpVC()
    }
}
