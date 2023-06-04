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
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        
        TabView {
            NavigationView {
                ScrollView(showsIndicators: false) {
                    ForEach(0 ..< 5) { item in
                        SalonModel()
                        
                        Divider()
                    }
                }
                .navigationTitle("Salonlar")
                .navigationBarItems(trailing: HStack {
                    Button {
                        // Salon Filters
                    } label: {
                        Image(systemName: "slider.vertical.3")
                    }

                })
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Image(systemName: "scissors")
            }
            .tag(0)
            
            NavigationView {
                MapVC()
                    .navigationTitle("Harita")
                    .toolbarBackground(Color("DarkModeColor"), for: .navigationBar)
                    .navigationBarTitleDisplayMode(.inline)
            }
            .navigationViewStyle(StackNavigationViewStyle())
                .tabItem {
                    Image(systemName: "map.fill")
                }
                .tag(1)
            
            NavigationView {
                ScrollView(showsIndicators: false) {
                    ForEach(0 ..< 20) { item in
                        MessagesVC()
                            .navigationTitle("Mesajlar")
                    }
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .toolbarBackground(Color("DarkModeColor"), for: .navigationBar)
            }
            .tabItem {
                Image(systemName: "message.fill")
            }
            .tag(2)
            
            SettingsVC()
                .navigationTitle("Ayarlar")
            
            .navigationViewStyle(StackNavigationViewStyle())
            .toolbarBackground(Color("DarkModeColor"), for: .navigationBar)
                .tabItem {
                    Image(systemName: "gearshape.fill")
                }
                .tag(3)
        }
        .background(Color("DarkModeColor"))
        .accentColor(colorScheme == .dark ? .white : .black)
    }
}

struct FeedVC_Previews: PreviewProvider {
    static var previews: some View {
        FeedVC()
    }
}

struct SalonModel: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        NavigationLink {
             SalonDetailsVC()
                .toolbarBackground(.hidden, for: .navigationBar)
                .toolbar(.hidden, for: .navigationBar)
        } label: {
                
            LazyVStack {
                VStack {
                    ZStack {
                        Image("catmakas")
                            .resizable()
                            .frame(width: .infinity, height: .infinity)
                            .scaledToFill()
                        
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
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .font(.title)
                        
                        Spacer()
                        
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(colorScheme == .dark ? .gray : Color("MainColor"))
                        
                        Text("Nilüfer")
                            .foregroundColor(.gray)
                        
                    }
                    .padding(.bottom, 1)
                }
                
                HStack {
                    Image(systemName: "arrow.forward.square.fill")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    
                    Text("İstediğin gibi görünmek bir randevu kadar uzak")
                        .font(Font.system(size: 15))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .fontWeight(.light)
                    
                    Spacer()
                }
                
                HStack {
                    Image(systemName: "scissors.circle.fill")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    
                    Text("Saç Kesimi, Renklendirme, Lazer, Erkek Tıraş")
                        .font(Font.system(size: 15))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .fontWeight(.light)
                    
                    Spacer()
                }
                .padding(.top, 1)
            }
            .padding()
            
        }
        .background(colorScheme == .dark ? Color("DarkModeColor") : .white)
        .toolbarBackground(Color("DarkModeColor"), for: .navigationBar)
    }
}
