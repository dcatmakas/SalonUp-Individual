//
//  SettingsVC.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 24.05.2023.
//

import SwiftUI

struct SettingsVC: View {
    
    var accountTitles: [String] = ["Profil", "Hesap Ayarları"]
    var privacyTitles: [String] = ["Gizlilik", "Bildirim Tercihleri"]
    var otherTitles: [String] = ["Bize Ulaşın", "SalonUp! Business İndirin", "Sıkça Sorulan Sorular (SSS)"]
    var logOutTitle: [String] = ["Çıkış Yap"]
    
    var body: some View {
        
        List {
            Section(header: Text("HESABIM")) {
                ForEach(accountTitles, id: \.self) { title in
                    if title == "Profil" {
                        HStack {
                            Image(systemName: "person.crop.circle.fill")
                            
                            Text(title)
                        }
                    } else if title == "Hesap Ayarları" {
                        HStack {
                            Image(systemName: "gearshape.fill")
                            
                            Text(title)
                        }
                    }
                }
            }
            
            Section(header: Text("Gizlilik ve Güvenlik")) {
                ForEach(privacyTitles, id: \.self) { title in
                    if title == "Gizlilik" {
                        HStack {
                            Image(systemName: "hand.raised.fill")
                            
                            Text(title)
                        }
                    } else if title == "Bildirim Tercihleri" {
                        HStack {
                            Image(systemName: "bell.badge.fill")
                            
                            Text(title)
                        }
                    }
                }
            }
            
            Section(header: Text("Diğer")) {
                ForEach(otherTitles, id: \.self) { title in
                    if title == "Bize Ulaşın" {
                        HStack {
                            Image(systemName: "message.fill")
                            
                            Text(title)
                        }
                    } else if title == "SalonUp! Business İndirin" {
                        HStack {
                            Image("SalonUp! Logo")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 22, height: 22)
                                .cornerRadius(5)
                            
                            Text(title)
                        }
                    } else if title == "Sıkça Sorulan Sorular (SSS)" {
                        HStack {
                            Image(systemName: "questionmark.app.fill")
                            
                            Text(title)
                        }
                    }
                }
            }
            
            Section(header: Text("Çıkış")) {
                ForEach(logOutTitle, id: \.self) { title in
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
}

struct SettingsVC_Previews: PreviewProvider {
    static var previews: some View {
        SettingsVC()
    }
}
