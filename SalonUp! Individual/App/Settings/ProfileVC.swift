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
    
    // Gender
    enum Gender: String, CaseIterable {
        case male = "Erkek"
        case female = "Kadın"
        case unspecified = "Belirtmek İstemiyorum"
        case pleaseSelect = "Lütfen Seçiniz"
    }
    @State private var selectedGender: String = UserManager.shared.getUser()!.gender
    
    // Environments
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    
    // User Infos
    @State var name: String = ""
    @State var surname: String = ""
    @State var email: String = ""
    
    // User Infos From Other Screens
    
    // Image
    @State private var selectedImage: UIImage?
    @State private var isShowingImagePicker: Bool = false
    
    // Alerts
    @State private var showUploadError: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var alertDismissButton: String = ""
    
    // User
    let currentUser = UserManager.shared.getUser()
    
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            VStack {
                VStack {
                    VStack {
                        if let currentUser = UserManager.shared.getUser() {
                            if let profileImage = currentUser.profileImageData, let image = UIImage(data: profileImage) {
                                // If User Has A Profile Photo
                                if selectedImage == nil {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 160, height: 160)
                                        .clipShape(Circle())
                                        .padding(.bottom)
                                } else {
                                    Image(uiImage: selectedImage!)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 160, height: 160)
                                        .clipShape(Circle())
                                        .padding(.bottom)
                                }
                            } else {
                                // If User Does Not Have A Profile Photo
                                if colorScheme == .light {
                                    ZStack {
                                        if selectedImage != nil {
                                            Image(uiImage: selectedImage!)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 160, height: 160)
                                                .clipShape(Circle())
                                            
                                        } else {
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
                                    }
                                    .padding(.bottom)
                                } else {
                                    ZStack {
                                        if selectedImage != nil {
                                            Image(uiImage: selectedImage!)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 160, height: 160)
                                                .clipShape(Circle())
                                            
                                        } else {
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
                                    }
                                    .padding(.bottom)
                                }
                            }
                        }
                    }
                    .onTapGesture {
                        isShowingImagePicker = true
                    }
                    .sheet(isPresented: $isShowingImagePicker) {
                        ImagePickerModel(selectedImage: $selectedImage)
                    }
                }
                
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Ad:")
                                .bold()
                                .foregroundColor(.gray)
                            
                            TextField(currentUser!.firstName == "" ? "Adınız" : currentUser!.firstName.capitalized, text: $name)
                                .padding()
                                .cornerRadius(16)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: 1)
                                )
                        }
                        Spacer()
                    }
                    .padding()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Soyad:")
                                .bold()
                                .foregroundColor(.gray)
                            
                            TextField(currentUser!.lastName == "" ? "Soyadınız" : currentUser!.lastName.capitalized, text: $surname)
                                .padding()
                                .cornerRadius(16)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: 1)
                                )
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Cinsiyet:")
                                .bold()
                                .foregroundColor(.gray)
                            
                            Menu {
                                Button(action: {
                                    selectedGender = Gender.unspecified.rawValue
                                }) {
                                    Label(Gender.unspecified.rawValue, systemImage: selectedGender == Gender.unspecified.rawValue ? "checkmark" : "")
                                }
                                
                                Button(action: {
                                    selectedGender = Gender.female.rawValue
                                }) {
                                    Label(Gender.female.rawValue, systemImage: selectedGender == Gender.female.rawValue ? "checkmark" : "")
                                }
                                
                                Button(action: {
                                    selectedGender = Gender.male.rawValue
                                }) {
                                    Label(Gender.male.rawValue, systemImage: selectedGender == Gender.male.rawValue ? "checkmark" : "")
                                }
                            } label: {
                                HStack {
                                    Text(selectedGender)
                                        .foregroundColor(selectedGender == Gender.pleaseSelect.rawValue ? .gray : colorScheme == .dark ? .white : .black)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                }
                                .padding()
                                .cornerRadius(16)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: 1)
                                )
                            }
                        }
                        Spacer()
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
                
                    .alert(isPresented: $showUploadError) {
                        Alert(title: Text(alertTitle),
                              message: Text(alertMessage),
                              dismissButton: .default(Text("Tamam"))
                        )
                    }
                                
            }
        }
        .background(colorScheme == .dark ? Color("DarkModeColor") : .white)
        .toolbarBackground(colorScheme == .dark ? Color("DarkModeColor") : .clear, for: .navigationBar)
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
            let imageReference = profilePhotosFolder.child("\(currentUser.username).jpg")
            
            if let imageData = (selectedImage != nil ? selectedImage : UIImage(data: currentUser.profileImageData ?? Data()))?.jpegData(compressionQuality: 0.5) {
                imageReference.putData(imageData) { metadata, error in
                    if error != nil {
                        showAlert(title: "Hata!", message: "Bilgilerin Kaydedilmesi Esnasında Hata Oluştu. Lütfen Tekrar Deneyiniz.")
                    } else {
                        imageReference.downloadURL { url, error in
                            if let imageUrl = url?.absoluteString {
                                let user = Auth.auth().currentUser
                                
                                if let user = user {
                                    let userRef = database.collection("users").document(user.uid)
                                    userRef.updateData(["profilePhoto" : imageUrl,
                                                        "name" : name != "" ? name.capitalized : currentUser.firstName.capitalized,
                                                        "surname" : surname != "" ? surname.capitalized : currentUser.lastName.capitalized,
                                                        "gender" : selectedGender]) { error in
                                        
                                        if error != nil {
                                            print("Bir Hata Oluştu.")
                                        } else {
                                            print("Upload Başarılı")
                                                                                        
                                            let currentUser = User(username: currentUser.username, firstName: name != "" ? name.capitalized : currentUser.firstName.capitalized, lastName: surname != "" ? surname.capitalized : currentUser.lastName.capitalized, email: currentUser.email, gender: selectedGender, profileImageData: imageData, userUUID: currentUser.userUUID ?? nil)
                                                                                        
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
            } else {
                
                let user = Auth.auth().currentUser
                
                if let user = user {
                    let userRef = database.collection("users").document(user.uid)
                    userRef.updateData(["name" : name != "" ? name.capitalized : currentUser.firstName.capitalized,
                                        "surname" : surname != "" ? surname.capitalized : currentUser.lastName.capitalized,
                                        "gender" : selectedGender]) { error in
                        
                        if error != nil {
                            print("Bir Hata Oluştu.")
                        } else {
                            print("Upload Başarılı")
                                                                                                    
                            let currentUser = User(username: currentUser.username, firstName: name != "" ? name.capitalized : currentUser.firstName.capitalized != "" ? name.capitalized : currentUser.firstName.capitalized, lastName: surname != "" ? surname.capitalized : currentUser.lastName.capitalized, email: currentUser.email, gender: selectedGender, profileImageData: nil, userUUID: currentUser.userUUID ?? nil)
                                                        
                            UserManager.shared.saveUser(currentUser)
                            
                            print("Data Kaydı Başarılı.")
                            
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
        }
    }

    
    private func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showUploadError = true
    }
    
}


struct ProfileVC_Previews: PreviewProvider {
    static var previews: some View {
        ProfileVC()
    }
}

