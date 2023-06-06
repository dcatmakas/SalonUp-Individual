//
//  ProfilePhotoVC.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 6.06.2023.
//

import SwiftUI

struct ProfilePhotoVC: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var goUserInformationsVC: Bool = false
    
    @State private var isShowingImagePicker: Bool = false
    
    // Profile Datas
    @State var profilePhoto: UIImage?
    
    var body: some View {
        VStack {
            HStack {
                
                Spacer()
                
                Button {
                    // Go Next View.
                    goUserInformationsVC = true
                    
                } label: {
                    Text("Şimdilik Atla")
                        .foregroundColor(colorScheme == .dark ? .white : .blue)
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Hey 👋")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(Color("MainColor"))
                        .padding(.top)
                        .padding(.bottom, 5)
                    
                    Text("Buradan Profil Fotoğrafını Belirleyebilirsin.")
                        .font(.title)
                        .fontWeight(.heavy)
                        .padding(.bottom)
                }
                Spacer()
            }
            .padding()
            
            
            VStack {
                Text("👇")
                    .font(.largeTitle)
                
                ZStack {
                    if colorScheme == .light {
                        Image("ProfilePhotoIconLight")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 180, height: 180)
                        
                     } else {
                        Image("ProfilePhotoIconDark")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 180, height: 180)
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
                    // Save And Next
                } label: {
                    Text("Devam")
                        .padding(.vertical)
                        .padding(.horizontal, 60)
                        .foregroundColor(.white)
                        .background(Color("LoginButtonColor"))
                        .clipShape(Capsule())
                }

            }
            
            Spacer()
        }
        
        .fullScreenCover(isPresented: $goUserInformationsVC) {
            UserInformationsVC()
        }
        
    }
}

struct ProfilePhotoVC_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoVC()
    }
}
