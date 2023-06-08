//
//  ProfilePhotoVC.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 6.06.2023.
//

import SwiftUI


struct ProfilePhotoVC: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    // Segues
    @State private var goUserInformationsVC: Bool = false
    @State private var goFeedVC: Bool = false
    
    // Image Picker
    @State private var isShowingImagePicker: Bool = false
    
    // Profile Datas
    @State var profilePhoto: UIImage?
    
    // Datas From Previus VCs
    @Binding var username: String
    @Binding var email: String
    @Binding var name: String
    @Binding var surname : String
    @Binding var gender: String
    
    var body: some View {
        VStack {
            HStack {
                
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
                    Text("Memnun Oldum, \(username) 🤩")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(Color("MainColor"))
                        .padding(.top)
                        .padding(.bottom, 5)
                    
                    Text("Buradan Profil Fotoğrafını Belirleyebilirsin.")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .padding(.bottom)
                }
                Spacer()
            }
            .padding(.horizontal)
            
            
            VStack {
                Text("👇")
                    .font(.largeTitle)
                
                ZStack {
                    if colorScheme == .light {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 180, height: 180)
                            .foregroundColor(.gray)
                        
                     } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 180, height: 180)
                            .foregroundColor(Color.gray)
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                }
                .onTapGesture {
                    // Open Gallery And Pick A Profile Photo
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
        // Update Data
        
        goFeedVC = true
    }
    
}

struct ProfilePhotoVC_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoVC(username: .constant("Username"), email: .constant("Email"), name: .constant("Name"), surname: .constant("Surname"), gender: .constant("Cinsiyet"))
    }
}
