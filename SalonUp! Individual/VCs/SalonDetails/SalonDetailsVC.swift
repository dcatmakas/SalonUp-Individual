//
//  SalonDetailsVC.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 25.05.2023.
//

import SwiftUI

struct SalonDetailsVC: View {
    
    @State var isPremiumSalon: Bool = true
    @State var offset: CGFloat = 0
    @State var currentTab = "Ana Sayfa"
    @State var tabBarOffset: CGFloat = 0
    
    @Environment(\.presentationMode) var presentationMode
        
    // Dark Mode
    @Environment(\.colorScheme) var colorScheme
    
    // For Smooth Slide Animation
    @Namespace var animation
    
    var body: some View {
        
        ZStack {
            
            ScrollView(.vertical, showsIndicators: false, content: {
                
                VStack(spacing: 15) {
                    
                    // Header View
                    GeometryReader { geo -> AnyView in
                        
                        // Sticky Header
                        let minY = geo.frame(in: .global).minY
                        
                        DispatchQueue.main.async {
                            self.offset = minY
                        }
                        
                        return AnyView(
                            ZStack {
                                //Banner
                                Image("catmakas")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: getRect().width, height: minY > 0 ? 180 + minY : 180)
                                    .cornerRadius(0)
                                
                                BlurViewModel()
                                    .opacity(blurViewOpacity())
                                
                                //Title View
                                VStack(spacing: 5) {
                                    
                                }
                                .offset(y: 60)
                            }
                            // Stretchy Header
                                .frame(height: minY > 0 ? 180 + minY : nil)
                                .offset(y: minY > 0 ? -minY : -minY < 80 ? 0 : -minY - 80)
                                .offset(y: -20)
                            
                        )
                    }
                    .frame(height: 180)
                    .zIndex(1)
                    
                    // Salon Logo
                    VStack {
                        HStack {
                            Image("catmakas.logo")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 95, height: 95)
                                .clipShape(Circle())
                                .padding(8)
                                .background(colorScheme == .dark ? Color.black : Color.white)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.gray, lineWidth: 1.5)
                                )
                                .offset(y: offset < 0 ? getOffset() - 20 : -20)
                                .scaleEffect(getScale())
                            
                            
                            Spacer()
                            
                            HStack {
                                Image(systemName: "star.circle.fill")
                                    .foregroundColor(Color("MainColor"))
                                
                                Text("Premium Salon")
                                    .foregroundColor(Color("MainColor"))
                                    .fontWeight(.semibold)
                                    .font(Font.system(size: 13))
                                    .padding(.vertical, 10)
                            }
                            .padding(.horizontal)
                            .background(
                                Capsule()
                                    .strokeBorder(Color("MainColor"), lineWidth: 1.5)
                            )
                            
                            
                        }
                        .padding(.top, -40)
                        .padding(.bottom, -15)
                        
                        // Profile Data
                        VStack(alignment: .leading, spacing: 8, content: {
                            HStack {
                                Text("Çatmakas Salon")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                Image(systemName: "mappin.circle.fill")
                                    .foregroundColor(.gray)
                                
                                Text("Özlüce")
                                    .foregroundColor(.gray)
                            }
                            .padding(.bottom)
                            
                            HStack(alignment: .top) {
                                Image(systemName: "scissors.circle.fill")
                                    .foregroundColor(.black)
                                
                                Text("İyi Görünmek Bir Randevu Kadar Uzak.✨")
                                    .foregroundColor(.black)
                                    .font(Font.system(size: 15))
                            }
                            
                            HStack(alignment: .top) {
                                Image(systemName: "arrow.forward.square.fill")
                                    .foregroundColor(.black)
                                
                                Text("Profesyonel Ekibimizle Birlikte 300 Metre Karelik Geniş Salonumuzda Misafirimize En iyi Hizmeti Sunuyoruz.")
                                    .foregroundColor(.black)
                                    .font(Font.system(size: 15))
                            }
                            
                        })
                        // Custom Segmented Menu
                        VStack(spacing: 0) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 0) {
                                    
                                    TabButton(title: "Ana Sayfa", currentTab: $currentTab, animation: animation)
                                    
                                    TabButton(title: "Hizmetler", currentTab: $currentTab, animation: animation)
                                    
                                    TabButton(title: "Yorumlar", currentTab: $currentTab, animation: animation)
                                    
                                    TabButton(title: "Fotoğraflar", currentTab: $currentTab, animation: animation)
                                }
                            }
                            
                            Divider()
                        }
                        .padding(.top, 15)
                        .background(Color.white)
                        .offset(y: tabBarOffset < 80 ? -tabBarOffset + 80 : 0)
                        .overlay(
                            
                            GeometryReader { reader -> Color in
                                
                                let minY = reader.frame(in: .global).minY
                                
                                DispatchQueue.main.async {
                                    self.tabBarOffset = minY
                                }
                                
                                return Color.clear
                                
                            }
                                .frame(width: 0, height: 0)
                            
                            ,alignment: .top
                            
                        )
                        .zIndex(1)
                        
                        VStack(spacing: 18) {
                            
                            // Posts
                            
                            ForEach(0..<10) { _ in
                                MessagesVC()
                            }
                        }
                        .padding(.top)
                        .zIndex(0)
                        
                    }
                    .padding(.horizontal)
                    
                    // Return The View Back If It Goes > 80
                    .zIndex(-offset > 80 ? 0 : 1)
                }
            })
            
            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .padding(10)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .opacity(0.9)
                            .font(Font.system(size: 18))
                }
                    Spacer()
                }
                Spacer()
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 40)
        }
        .ignoresSafeArea(.all, edges: .top)

    }
    
    // Profile Shrinking Effect
    func getOffset() -> CGFloat {
        
        let progress = (-offset / 80) * 20
        
        return progress <= 20 ? progress : 20
    }
    
    func getScale() -> CGFloat {
        
        let progress = -offset / 80
        
        let scale = 1.8 - (progress < 1.0 ? progress : 1)
        
        // Since Were Scaling The View To 0.8
        // 1.8 - 1 = 0.8
        return scale < 1 ? scale : 1
    }
    
    func blurViewOpacity() -> Double {
        
        let progress = -(offset + 80) / 150
        
        return Double(-offset > 80 ? progress : 0)
    }
    
}

struct SalonDetailsVC_Previews: PreviewProvider {
    static var previews: some View {
        SalonDetailsVC()
    }
}

// Get Screen Size
extension View {
    
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}

struct TabButton: View {
    
    var title : String
    @Binding var currentTab: String
    var animation: Namespace.ID
    
    var body: some View {
        
        Button {
            withAnimation {
                currentTab = title
            }
        } label: {
            LazyVStack(spacing: 12) {
                Text(title)
                    .fontWeight(.semibold)
                    .foregroundColor(currentTab == title ? .black : .gray)
                    .padding(.horizontal)
                
                if currentTab == title {
                    Capsule()
                        .fill(Color.black)
                        .frame(height: 1.2)
                        .matchedGeometryEffect(id: "TAB", in: animation)
                    
                } else {
                    Capsule()
                        .fill(Color.clear)
                        .frame(height: 1.2)
                }
            }
        }
    }
}
