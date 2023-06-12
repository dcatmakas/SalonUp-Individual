//
//  ProfileVC.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 30.05.2023.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore

struct ProfileVC: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    
    @State var name: String = ""
    @State var surname: String = ""
    @State var email: String = ""
    
    @State private var selectedImage: UIImage?
    @State private var isShowingImagePicker: Bool = false
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            VStack {
                VStack {
                    VStack {
                        if let currentUser = UserManager.shared.getUser() {
                            if let profileImage = UIImage(data: currentUser.profileImageData ?? Data()) {
                                // Kullanıcının profil fotoğrafı varsa
                                if selectedImage == nil {
                                    Image(uiImage: profileImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 160, height: 160)
                                        .clipShape(Circle())
                                        .padding(.bottom)
                                } else {
                                    // Eğer kullanıcı başka bir fotoğraf seçtiyse
                                    Image(uiImage: selectedImage!)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 160, height: 160)
                                        .clipShape(Circle())
                                        .padding(.bottom)
                                }
                            } else {
                                // Kullanıcının profil fotoğrafı yoksa
                                if colorScheme == .light {
                                    ZStack {
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 160, height: 160)
                                            .foregroundColor(.gray)
                                            .background(Color.white)
                                            .colorMultiply(.black.opacity(0.5))
                                            .clipShape(Circle())
                                        
                                        Image(systemName: "photo.fill")
                                            .font(Font.system(size: 35))
                                            .foregroundColor(.white)
                                    }
                                    .padding(.bottom)
                                } else {
                                    ZStack {
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 160, height: 160)
                                            .foregroundColor(Color.gray)
                                            .background(Color.black)
                                            .colorMultiply(.white.opacity(0.5))
                                            .clipShape(Circle())
                                        
                                        Image(systemName: "photo.fill")
                                            .font(Font.system(size: 35))
                                            .foregroundColor(.white)
                                    }
                                    .padding(.bottom)
                                }
                            }
                        }
                    }
                    .onTapGesture {
                        isShowingImagePicker = true
                    }
                }
                .sheet(isPresented: $isShowingImagePicker) {
                    ImagePickerModel(selectedImage: $selectedImage)
                }


                
                VStack {
                    ZStack {
                        Rectangle()
                            .frame(width: .infinity, height: 50)
                            .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(colorScheme == .dark ? Color.white : Color.black)
                            )
                            .cornerRadius(16)
                        
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                .padding(.leading)
                            
                            if let currentUser = UserManager.shared.getUser() {
                                TextField(currentUser.firstName, text: $name)
                                    .textContentType(.name)
                                    .padding(.trailing)
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                            } else {
                                TextField("Adınız", text: $name)
                                    .textContentType(.familyName)
                                    .padding(.trailing)
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                            }
                            
                            Spacer()
                        }
                        
                    }
                    .padding()
                    
                    ZStack {
                        Rectangle()
                            .frame(width: .infinity, height: 50)
                            .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(colorScheme == .dark ? Color.white : Color.black)
                            )
                            .cornerRadius(16)
                        
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                .padding(.leading)
                            
                            if let currentUser = UserManager.shared.getUser() {
                                TextField(currentUser.lastName, text: $surname)
                                    .textContentType(.familyName)
                                    .padding(.trailing)
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                            } else {
                                TextField("Soyadınız", text: $surname)
                                    .textContentType(.familyName)
                                    .padding(.trailing)
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                            }
                            
                            Spacer()
                        }
                        
                    }
                    .padding(.horizontal)
                    
                    ZStack {
                        Rectangle()
                            .frame(width: .infinity, height: 50)
                            .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(colorScheme == .dark ? Color.white : Color.black)
                            )
                            .cornerRadius(16)
                        
                        HStack {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                .padding(.leading)
                            
                            if let currentUser = UserManager.shared.getUser() {
                                TextField(currentUser.email, text: $email)
                                    .textContentType(.emailAddress)
                                    .padding(.trailing)
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                            } else {
                                TextField("Mail Adresi", text: $email)
                                    .textContentType(.familyName)
                                    .padding(.trailing)
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                            }
                            
                            Spacer()
                        }
                        
                    }
                    .padding()
                }
                
                Button(action: {
                    // Upload Changes To Firebase
                    saveChanges()
                }, label: {
                    Text("Kaydet")
                        .padding(.vertical)
                        .padding(.horizontal, 80)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(16)
                })
                .padding()
                
                Spacer()
                
                    .sheet(isPresented: $isShowingImagePicker) {
                        ImagePickerModel(selectedImage: $selectedImage)
                    }
                
                    .onTapGesture {
                        hideKeyboard()
                    }
                
            }
            .background(colorScheme == .dark ? Color("DarkModeColor") : .white)
            .toolbarBackground(colorScheme == .dark ? Color("DarkModeColor") : .clear, for: .navigationBar)
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    private func saveChanges() {
        // Firestore Database Reference
        let database = Firestore.firestore()
        
        // Storage Database Reference
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let profilePhotosFolder = storageReference.child("userProfilePhotos")
        if let currentUser = UserManager.shared.getUser() {
            let imageReference = profilePhotosFolder.child("\(currentUser.username).\(currentUser.userUUID).jpg")
            
            if let imageData = (selectedImage != nil ? selectedImage : UIImage(data: currentUser.profileImageData!))?.jpegData(compressionQuality: 0.5) {
                imageReference.putData(imageData) { metadata, error in
                    if error != nil {
                        // Make Error
                    } else {
                        imageReference.downloadURL { url, error in
                            if let imageUrl = url?.absoluteString {
                                let user = Auth.auth().currentUser
                                
                                if let user = user {
                                    let userRef = database.collection("users").document(user.uid)
                                    userRef.updateData(["profilePhoto" : imageUrl,
                                                        "name" : name != "" ? name : currentUser.firstName.capitalized,
                                                        "surname" : surname != "" ? surname : currentUser.lastName.capitalized]) { error in
                                        
                                        if error != nil {
                                            print("Bir Hata Oluştu.")
                                        } else {
                                            print("Upload Başarılı")
                                            
                                            let currentUser = User(username: currentUser.username, firstName: name != "" ? name.capitalized : currentUser.firstName.capitalized, lastName: surname != "" ? surname.capitalized : currentUser.lastName.capitalized, email: currentUser.email, gender: currentUser.gender, profileImageData: imageData, userUUID: currentUser.userUUID)
                                            
                                            UserManager.shared.saveUser(currentUser)
                                            
                                            print("Data Kaydı Başarılı.")
                                            
                                            presentationMode.wrappedValue.dismiss()
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}


struct ProfileVC_Previews: PreviewProvider {
    static var previews: some View {
        ProfileVC()
    }
}

