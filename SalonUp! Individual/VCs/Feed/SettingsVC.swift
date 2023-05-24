//
//  SettingsVC.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 24.05.2023.
//

import SwiftUI

struct SettingsVC: View {
    
    var titles: [String] = ["Profil", "Hesap Ayarları", "Bildirim Tercihleri", "Gizlilik", "Bize Ulaşın", "SalonUp! Business İndirin", "Sıkça Sorulan Sorular (SSS)", "Çıkış Yap"]
    
    var body: some View {
        
        List {
            Section(header: Text("Ayarlar")) {
                ForEach(titles, id: \.self) { title in
                    Text(title)
                    
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
