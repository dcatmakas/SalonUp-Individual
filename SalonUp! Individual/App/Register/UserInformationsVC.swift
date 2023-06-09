//
//  UserInformationsVC.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 6.06.2023.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct UserInformationsVC: View {
    
    // Gender
    enum Gender: String, CaseIterable {
        case male = "Erkek"
        case female = "Kadın"
        case unspecified = "Belirtmek İstemiyorum"
        case pleaseSelect = "Lütfen Seçiniz"
    }
    @State private var selectedGender: String = Gender.pleaseSelect.rawValue
    
    // Color Scheme
    @Environment(\.colorScheme) var colorScheme
    
    // Datas From Previus Screens
    @Binding var username: String
    @Binding var email: String
    @Binding var userUUID: UUID
    
    // Texts
    @State var name: String = "".capitalized
    @State var surname: String = "".capitalized
    
    // Segues
    @State private var goProfilePhotoVC: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                
                Spacer()
                
                Button {
                    // Go Next View.
                    goProfilePhotoVC = true
                    
                } label: {
                    Text("Şimdilik Atla")
                        .foregroundColor(colorScheme == .dark ? .white : .blue)
                }
            }
            .padding(.horizontal)
            .padding(.top, 5)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Hoş Geldin 👋")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .padding(.bottom, 5)
                    
                    Text("Aşağıdaki Bilgileri Doldurarak Seni Daha İyi Tanımamıza Yardımcı Olabilirsin!")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                Spacer()
            }
            .padding()
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Ad:")
                            .bold()
                            .foregroundColor(.gray)
                        
                        TextField("Adınız", text: $name)
                            .padding()
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: 1)
                            )
                    }
                    Spacer()
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Soyad:")
                            .bold()
                            .foregroundColor(.gray)
                        
                        TextField("Soyadınız", text: $surname)
                            .padding()
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: 1)
                            )
                    }
                    Spacer()
                }
                .padding(.vertical)
                
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
                
                Spacer()
                
                Button {
                    nextButtonClicked()
                } label: {
                    Text("Devam Et")
                        .padding(.vertical)
                        .padding(.horizontal, 60)
                        .foregroundColor(.white)
                        .background(Color("LoginButtonColor"))
                        .clipShape(Capsule())
                }
                .padding()

                Spacer()
                
            }
            .padding(.horizontal)
            
            
            Spacer()
            
        }
        .background(Color(colorScheme == .dark ? UIColor(Color("DarkModeColor")) : .white))
        
        .fullScreenCover(isPresented: $goProfilePhotoVC) {
            ProfilePhotoVC(username: $username, email: $email, name: $name, surname: $surname, gender: $selectedGender, userUUID: $userUUID)
        }
        
        .onTapGesture {
            hideKeyboard()
        }
        
    }
    
    private func nextButtonClicked() {
        // Upload Datas
        let database = Firestore.firestore()
        let user = Auth.auth().currentUser
        
        if let user = user {
            let userReference = database.collection("users").document(user.uid)
            userReference.updateData(["name" : name.capitalized,
                                      "surname" : surname.capitalized,
                                      "gender" : selectedGender]) { error in
                if error != nil {
                    print("Update Esnasında Bir Sorun Oluştu.")
                } else {
                    print("Update Başarılı.")
                    
                    // Update Succesfull and Go Next View.
                    goProfilePhotoVC = true
                }
            }
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

struct UserInformationsVC_Previews: PreviewProvider {
    static var previews: some View {
        UserInformationsVC(username: .constant("Username"), email: .constant("Email"), userUUID: .constant(UUID()))
    }
}
