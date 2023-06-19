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
    private var currentUser = UserManager.shared.getUser()
    
    var body: some View {
        Button {
            deleteAcoountAcception(title: "Uyarı!", message: "Hesabınızı kalıcı olarak silmek üzeresiniz. Eğer onaylıyorsanız kutucuğa delete/\(currentUser!.username) yazın.", hintText: "delete/\(currentUser!.username)", primaryTitle: "Onayla", secondaryTitle: "Vazgeç") { text in
                if text == "delete/\(currentUser!.username)" {
                    deleteUserData()
                    deleteUsernameData()
                    deleteProfileImage()
                    deleteAccount()
                    SignOut()
                }
                
            } secondaryAction: {
                print("Cancelled.")
            }
            
        } label: {
            Text("Hesabımı Sil")
                .font(.title)
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
    
    private func SignOut() {
        do {
            try Auth.auth().signOut()
            
            UserManager.shared.deleteUser()
            
            goLoginVC = true
            
        } catch _ as NSError {
            print("Çıkış yaparken bir hata oluştu.")
        }
    }
    
}

struct AccountSettingsVC_Previews: PreviewProvider {
    static var previews: some View {
        AccountSettingsVC()
    }
}

extension View {
    
    func deleteAcoountAcception(title: String, message: String, hintText: String, primaryTitle: String, secondaryTitle: String, primaryAction: @escaping (String) -> (), secondaryAction: @escaping () -> ()) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = hintText
        }
        
        alert.addAction(.init(title: secondaryTitle, style: .cancel, handler: { _ in
            secondaryAction()
        }))
        
        alert.addAction(.init(title: primaryTitle, style: .default, handler: { _ in
            if let text = alert.textFields?[0].text {
                primaryAction(text)
                
            } else {
                primaryAction("")
            }
        }))
        
        rootController().present(alert, animated: true)
    }
    
    func rootController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}
