//
//  AccountSettingsVC.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 30.05.2023.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth


struct AccountSettingsVC: View {
    
    @State private var goLoginVC: Bool = false
    
    var body: some View {
        Button {
            deleteUserData()
            deleteUsernameData()
            deleteProfileImage()
            deleteAccount()
            UserManager.shared.deleteUser()
            
            goLoginVC = true
            
        } label: {
            Text("Hesabımı Sil")
                .font(.largeTitle)
        }
        
        .fullScreenCover(isPresented: $goLoginVC) {
            LoginVC()
        }

    }
    
    func deleteUserData() {
        guard let currentUser = Auth.auth().currentUser else { return }
        let userRef = Firestore.firestore().collection("users").document(currentUser.uid)
        
        userRef.delete { error in
            if let error = error {
                print("Firestore veri silme hatası: \(error)")
            } else {
                print("Firestore veri başarıyla silindi.")
            }
        }
    }
    
    func deleteUsernameData() {
        guard let currentUser = Auth.auth().currentUser else { return }
        let usernamaRef = Firestore.firestore().collection("usernames").document(currentUser.uid)
        
        usernamaRef.delete { error in
            if let error = error {
                print("Firestore veri silme hatası: \(error)")
            } else {
                print("Firestore veri başarıyla silindi.")
            }
        }
    }
    
    func deleteProfileImage() {
        guard let currentLocalUser = UserManager.shared.getUser() else { return }
        guard let currentUser = Auth.auth().currentUser else { return }
        let storageRef = Storage.storage().reference().child("userProfilePhotos").child("\(currentLocalUser.username).jpg")
        
        // Kullanıcının profil resmini silme
        storageRef.delete { error in
            if let error = error {
                print("Storage resim silme hatası: \(error)")
            } else {
                print("Storage resim başarıyla silindi.")
            }
        }
    }
    
    func deleteAccount() {
        guard let currentUser = Auth.auth().currentUser else { return }
        
        // Kullanıcının hesabını silme
        currentUser.delete { error in
            if let error = error {
                print("Hesap silme hatası: \(error)")
            } else {
                print("Hesap başarıyla silindi.")
            }
        }
    }
    
}

struct AccountSettingsVC_Previews: PreviewProvider {
    static var previews: some View {
        AccountSettingsVC()
    }
}
