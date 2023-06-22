//
//  SalonCommentsVC.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 21.06.2023.
//

import SwiftUI

struct SalonCommentsVC: View {
    
    // User Informations
    let currentUser = UserManager.shared.getUser()
    @State var currentUserUsername: String
    
    // Dark / Light Mode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView {
            VStack {
                SalonAverageModel()
                
                Divider()
                
                VStack {
                    HStack {
                        Text("Sırala:")
                            .padding(.horizontal, 5)
                            .foregroundColor(.gray)
                        
                        HStack {
                            Text("Yeniden Eskiye")
                            
                            Image(systemName: "chevron.down")
                        }
                        
                        Spacer()
                    }
                }
                .padding(10)
                
                Divider()
                
                ForEach(0..<10) { _ in
                    CommentModel(currentUserUsername: "dogukan")
                    
                    Divider()
                }
            }
        }
        .background(colorScheme == .dark ? Color("DarkModeColor") : .white)
    }
}

struct SalonCommentsVC_Previews: PreviewProvider {
    static var previews: some View {
        SalonCommentsVC(currentUserUsername: "dogukan")
    }
}

struct CommentModel: View {
    
    // User Informations
    let currentUser = UserManager.shared.getUser()
    @State var currentUserUsername: String
    
    // Dark / Light Mode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            HStack {
                Image("dogukan")
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 45, height: 45)
                    .padding(.leading)
                
                Text(currentUserUsername)
                    .fontWeight(.semibold)
                    .font(.title3)
                    .padding(.horizontal, 10)
                
                Spacer()
                
                Button {
                    // Comment Settings
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.title2)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
                .padding(.trailing, 25)
                
            }
            .padding(.vertical, 8)
            
            Rectangle()
                .frame(width: .infinity, height: 0.5)
                .padding(.horizontal, 30)
                .opacity(0.5)
            
            HStack(alignment: .top) {
                VStack {
                    Image(systemName: "star.fill")
                        .font(.largeTitle)
                        .foregroundColor(.yellow)
                    
                    Text("4/5")
                        .font(.title)
                        .bold()
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                    
                }
                .padding()
                
                VStack(alignment: .center) {
                    Image(systemName: "star.fill")
                        .font(.largeTitle)
                        .foregroundColor(.yellow)
                    
                    Text("5/5")
                        .font(.title)
                        .bold()
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                    
                }
                .padding()
                
                VStack {
                    Image(systemName: "star.fill")
                        .font(.largeTitle)
                        .foregroundColor(.yellow)
                    
                    Text("4/5")
                        .font(.title)
                        .bold()
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                    
                }
                .padding()
                
            }
            
            VStack {
                HStack {
                    Text("Mükemmel!")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                    
                    Spacer()
                }
                
                Text("Bu salonu SalonUp! sayesinde keşfettim ve oldukça memnun kaldım. Saç kesimim tam istediğim gibi oldu, bu konuda çok memnun kaldım. Salon hijyen kurallarına dikkat ediyordu ve personeller oldukça güler yüzlüydü. Mutlaka tekrar işlem yaptıracağım.👍🏻")
                    .padding([.horizontal, .bottom])
                
                HStack {
                    Spacer()
                    
                    Text("14 dakika önce")
                        .fontWeight(.light)
                        .padding(.horizontal)
                        .padding(.bottom)
                        .foregroundColor(.gray)
                }
                
            }
            
        }
    }
}

struct SalonAverageModel: View {
    var body: some View {
        VStack {
            
            Text("Salon Yorumları")
                .font(.title)
                .fontWeight(.semibold)
            
            Rectangle()
                .frame(width: .infinity, height: 0.5)
                .foregroundColor(.gray)
                .padding(.horizontal, 60)
            
            
            HStack(alignment: .top) {
                VStack {
                    Image(systemName: "star.fill")
                        .font(.largeTitle)
                        .foregroundColor(.yellow)
                    
                    Text("4.2/5")
                        .font(.title)
                        .bold()
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                    
                    Text("Profesyonellik")
                        .font(.callout)
                    
                }
                .padding(.vertical)
                
                VStack(alignment: .center) {
                    Image(systemName: "star.fill")
                        .font(.largeTitle)
                        .foregroundColor(.yellow)
                    
                    Text("3.9/5")
                        .font(.title)
                        .bold()
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                    
                    Text("Hijyen")
                        .font(.callout)
                    
                }
                .padding(.vertical)
                
                VStack {
                    Image(systemName: "star.fill")
                        .font(.largeTitle)
                        .foregroundColor(.yellow)
                    
                    Text("4.7/5")
                        .font(.title)
                        .bold()
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                    
                    Text("Personel")
                        .font(.callout)
                    
                }
                .padding(.vertical)
                
            }
        }
    }
}
