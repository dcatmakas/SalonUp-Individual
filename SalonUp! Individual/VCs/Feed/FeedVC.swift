//
//  FeedVC.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 21.05.2023.
//

import SwiftUI
import MapKit
import CoreLocation


struct FeedVC: View {
    var body: some View {
        
        TabView {
            ScrollView {
                ForEach(0 ..< 5) { item in
                    SalonModel()
                }
            }
            .tabItem {
                Image(systemName: "scissors")
            }
            .tag(0)
            
            MapVC()
                .tabItem {
                    Image(systemName: "map.fill")
                }
                .tag(1)
            
            ScrollView {
                ForEach(0 ..< 20) { item in
                    MessagesVC()
                }
            }
                .tabItem {
                    Image(systemName: "message.fill")
                }
                .tag(2)
            
            SettingsVC()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                }
                .tag(3)
        }
        .accentColor(.black)
    }
}

struct FeedVC_Previews: PreviewProvider {
    static var previews: some View {
        FeedVC()
    }
}

struct SalonModel: View {
    var body: some View {
        
        ZStack {
            Rectangle()
                .frame(width: .infinity, height: 350)
                .foregroundColor(Color("CellColor"))
            
            VStack {
                VStack {
                    ZStack {
                        Image("catmakas")
                            .resizable()
                            .frame(width: .infinity, height: .infinity)
                        .scaledToFit()
                        
                        VStack {
                            HStack {
                                ZStack {
                                    Rectangle()
                                        .frame(width: 150, height: 30)
                                        .foregroundColor(.white)
                                    .cornerRadius(16)
                                    
                                    HStack {
                                        Image(systemName: "star.circle.fill")
                                            .foregroundColor(Color("MainColor"))
                                        
                                        Text("Premium Salon")
                                            .foregroundColor(Color("MainColor"))
                                            .fontWeight(.semibold)
                                            .font(Font.system(size: 14))
                                    }
                                }
                                Spacer()
                            }
                            Spacer()
                        }
                        .padding(.vertical)
                        .padding(.horizontal, 5)
                    }
                    
                    HStack {
                        Text("Çatmakas Salon")
                            .fontWeight(.bold)
                            .font(.title)
                        
                        Spacer()
                        
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(Color("MainColor"))
                        
                        Text("Nilüfer")
                            .foregroundColor(.gray)
                        
                    }
                    .padding(.bottom, 1)
                }
                
                HStack {
                    Image(systemName: "arrow.forward.square.fill")
                        .foregroundColor(.black)
                    
                    Text("İstediğin gibi görünmek bir randevu kadar uzak")
                        .font(Font.system(size: 15))
                        .fontWeight(.light)
                    
                    Spacer()
                }
                
                HStack {
                    Image(systemName: "scissors.circle.fill")
                        .foregroundColor(.black)
                    
                    Text("Saç Kesimi, Renklendirme, Lazer, Erkek Tıraş")
                        .font(Font.system(size: 15))
                        .fontWeight(.light)
                    
                    Spacer()
                }
                .padding(.top, 1)
            }
            .padding()
        }
    }
}
