//
//  ProfilePhotoVC.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 6.06.2023.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage


struct ProfilePhotoVC: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    
    // Segues
    @State private var goUserInformationsVC: Bool = false
    @State private var goFeedVC: Bool = false
    
    // Image Picker
    @State private var showImagePicker: Bool = false
    
    // Profile Datas
    @State private var profilePhoto: UIImage?
    
    // Datas From Previus VCs
    @Binding var username: String
    @Binding var email: String
    @Binding var name: String
    @Binding var surname : String
    @Binding var gender: String
    @Binding var userUUID: UUID
    
    // Defaults
    @State private var defaultName: String = "Name"
    
    var body: some View {
        VStack {
            HStack {
                
                Button {
                    // Go Back
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .font(.title3)
                }

                
                Spacer()
                
                Button {
                    // Go Next View.
                    goFeedVC = true
                    
                } label: {
                    Text("Şimdilik Atla")
                        .foregroundColor(colorScheme == .dark ? .white : .blue)
                }
            }
            .padding(.horizontal)
            .padding(.top, 5)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(name == defaultName ? "Selam Gizli Kişilik 👀" : "Memnun Oldum, \(name.capitalized) 🤩")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
//                        .foregroundColor(Color("MainColor"))
                        .padding(.top)
                        .padding(.bottom, 5)
                    
                    Text("Buradan Profil Fotoğrafını Belirleyebilirsin.")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .padding(.bottom)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding(.horizontal)
            
            
            VStack {
                Text("👇")
                    .font(.largeTitle)
                
                ZStack {
                    if profilePhoto != nil {
                        if colorScheme == .light {
                            Image(uiImage: profilePhoto!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 220, height: 220)
                                .foregroundColor(.gray)
                                .background(Color.white)
                                .clipShape(Circle())
                            
                        } else {
                            Image(uiImage: profilePhoto!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 220, height: 220)
                                .foregroundColor(.gray)
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                        
                    } else {
                        if colorScheme == .light {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 220, height: 220)
                                .foregroundColor(.gray)
                                .background(Color.white)
                                .colorMultiply(.black.opacity(0.5))
                                .clipShape(Circle())
                            
                            Image(systemName: "photo.fill")
                                .font(Font.system(size: 40))
                                .foregroundColor(.white)
                            
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 220, height: 220)
                                .foregroundColor(Color.gray)
                                .background(Color.black)
                                .colorMultiply(.white.opacity(0.5))
                                .clipShape(Circle())
                            
                            Image(systemName: "photo.fill")
                                .font(Font.system(size: 40))
                                .foregroundColor(.white)
                        }
                    }
                }
                .onTapGesture {
                    showImagePicker = true
                }
                .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                    ImagePickerModel(selectedImage: $profilePhoto)
                }
                
            }
            .padding(.horizontal)
            
            Spacer()
            
            HStack {
                Button {
                    finishSignUp()
                } label: {
                    Text("Bitir")
                        .padding(.vertical)
                        .padding(.horizontal, 60)
                        .foregroundColor(.white)
                        .background(Color("LoginButtonColor"))
                        .clipShape(Capsule())
                }

            }
            
            Spacer()
        }
        
        .fullScreenCover(isPresented: $goFeedVC) {
            FeedVC()
        }
        
        .background(colorScheme == .dark ? Color("DarkModeColor") : .white)
    }
    
    private func finishSignUp() {
        
        // Database References
        let database = Firestore.firestore()
        
        // Storage Database Reference
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let profilePhotosFolder = storageReference.child("userProfilePhotos")
        let imageReference = profilePhotosFolder.child("\(username).\(userUUID).jpg")
        
        if let imageData = profilePhoto?.jpegData(compressionQuality: 0.5) {
            imageReference.putData(imageData) { metadata, error in
                if error != nil {
                    // Make Error
                } else {
                    imageReference.downloadURL { url, error in
                        if let imageUrl = url?.absoluteString {
                            let user = Auth.auth().currentUser
                            
                            if let user = user {
                                let userRef = database.collection("users").document(user.uid)
                                userRef.updateData(["profilePhoto" : imageUrl]) { error in
                                    if error != nil {
                                        print("Bir Hata Oluştu.")
                                    } else {
                                        print("Upload Başarılı")
                                        
                                        let currentUser = User(username: username, firstName: name.capitalized, lastName: surname.capitalized, email: email, profileImageData: imageData, userUUID: userUUID)
                                        
                                        UserManager.shared.saveUser(currentUser)
                                        
                                        print("Data Kaydı Başarılı.")
                                        
                                        goFeedVC = true
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        goFeedVC = true
    }
    
    private func loadImage() {
        guard profilePhoto != nil else { return }
    }

    
}

struct ProfilePhotoVC_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoVC(username: .constant("Username"), email: .constant("Email"), name: .constant("Name"), surname: .constant("Surname"), gender: .constant("Cinsiyet"), userUUID: .constant(UUID()))
    }
}
