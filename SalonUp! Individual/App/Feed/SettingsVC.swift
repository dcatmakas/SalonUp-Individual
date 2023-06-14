//
//  SettingsVC.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 24.05.2023.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct SettingsVC: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var goLoginVC: Bool = false
    @State var logoutError: Bool = false
    
    var accountTitles: [String] = ["Profil", "Hesap Ayarları"]
    var privacyTitles: [String] = ["Gizlilik", "Bildirim Tercihleri"]
    var otherTitles: [String] = ["Bize Ulaşın", "SalonUp! Business İndirin", "Sıkça Sorulan Sorular (SSS)"]
    var logOutTitle: [String] = ["Çıkış Yap"]
    
    var body: some View {
        
        NavigationView {
            List {
                Section(header: Text("HESABIM")) {
                    ForEach(accountTitles, id: \.self) { title in
                        if title == "Profil" {
                            NavigationLink {
                                ProfileVC()
                            } label: {
                                HStack {
                                    Image(systemName: "person.crop.circle.fill")
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                    
                                    Text(title)
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                }
                            }
                            
                        } else if title == "Hesap Ayarları" {
                            NavigationLink {
                                AccountSettingsVC()
                            } label: {
                                HStack {
                                    Image(systemName: "gearshape.fill")
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                    
                                    Text(title)
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                }
                            }
                        }
                    }
                }
                
                Section(header: Text("Gizlilik ve Güvenlik")) {
                    ForEach(privacyTitles, id: \.self) { title in
                        if title == "Gizlilik" {
                            NavigationLink {
                                PrivacySettingsVC()
                            } label: {
                                HStack {
                                    Image(systemName: "hand.raised.fill")
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                    
                                    Text(title)
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                }
                            }

                        } else if title == "Bildirim Tercihleri" {
                            NavigationLink {
                                NotificationSettingsVC()
                            } label: {
                                HStack {
                                    Image(systemName: "bell.badge.fill")
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                    
                                    Text(title)
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                }
                            }
                        }
                    }
                }
                
                Section(header: Text("Diğer")) {
                    ForEach(otherTitles, id: \.self) { title in
                        if title == "Bize Ulaşın" {
                            NavigationLink {
                                ContactUsVC()
                            } label: {
                                HStack {
                                    Image(systemName: "message.fill")
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                    
                                    Text(title)
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                }
                            }

                        } else if title == "SalonUp! Business İndirin" {
                            Button {
                                // Go SalonUp! Business Page
                            } label: {
                                HStack {
                                    Image("SalonUp! Logo")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 22, height: 22)
                                        .cornerRadius(5)
                                    
                                    Text(title)
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                }
                            }

                        } else if title == "Sıkça Sorulan Sorular (SSS)" {
                            NavigationLink {
                                SSS_VC()
                            } label: {
                                HStack {
                                    Image(systemName: "questionmark.app.fill")
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                    
                                    Text(title)
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                }
                            }

                        }
                    }
                }
                
                Section(header: Text("Çıkış")) {
                    ForEach(logOutTitle, id: \.self) { title in
                        Button(action: {
                            SignOut()
                        }) {
                            HStack {
                                Image(systemName: "arrowshape.turn.up.left.fill")
                                    .foregroundColor(.red)
                                
                                Text(title)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
            }
            .fullScreenCover(isPresented: $goLoginVC) {
                LoginVC()
            }
            
            .alert(isPresented: $logoutError) {
                Alert(title: Text("Hata!"), message: Text("Çıkış Yaparken Bir Hata İle Karşılaşıldı. Lütfen Tekrar Deneyiniz."))
            }
            .navigationTitle("Ayarlar")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func SignOut() {
        do {
            try Auth.auth().signOut()
            
            UserManager.shared.deleteUser()
            
            goLoginVC = true
            
        } catch _ as NSError {
            logoutError = true
        }
    }
    
}

struct SettingsVC_Previews: PreviewProvider {
    static var previews: some View {
        SettingsVC()
    }
}
