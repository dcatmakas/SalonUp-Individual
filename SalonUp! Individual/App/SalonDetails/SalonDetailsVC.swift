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
    @State var titleOffset: CGFloat = 0
    
    // Post Details
    @State var currentPostImage: UIImage = UIImage(named: "catmakas")!
    @State var currentPostImage2: UIImage = UIImage(named: "dogukan")!
    @State var currentPostLikes: Int = 34
    
    // Details From User
    @State private var isLiked: Bool = false
    @State var isFollowing: Bool = false
    
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
                                    Text("Çatmakas Salon")
                                        .font(Font.system(size: 18))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }
                                // To Slide From Bottom Added Extra 60.
                                .offset(y: 105)
                                .offset(y: titleOffset > 100 ? 0 : -getTitleTextOffset())
                                .opacity(titleOffset < 100 ? 1 : 0)
                            }
                                .clipped()
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
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .padding(8)
                                .background(colorScheme == .dark ? Color("DarkModeColor") : Color.white)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(colorScheme == .dark ? .clear : .gray, lineWidth: 1.5)
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
                        .padding(.horizontal)
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
                                
                                HStack {
                                    Image(systemName: "star.fill")
                                        .font(.title2)
                                        .foregroundColor(.yellow)
                                    
                                    Text("4.8/5")
                                        .fontWeight(.semibold)
                                        .font(.title2)
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                }
                            }
                            .padding(.bottom)
                            
                            HStack(alignment: .top) {
                                Image(systemName: "mappin.circle.fill")
                                    .foregroundColor(.gray)
                                
                                Text("Özlüce")
                                    .foregroundColor(.gray)
                            }
                            
                            HStack(alignment: .top) {
                                Image(systemName: "scissors.circle.fill")
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                
                                Text("İyi Görünmek Bir Randevu Kadar Uzak.✨")
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                    .font(Font.system(size: 15))
                            }
                            
                            HStack(alignment: .top) {
                                Image(systemName: "arrow.forward.square.fill")
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                
                                Text("Profesyonel Ekibimizle Birlikte 300 Metre Karelik Geniş Salonumuzda Misafirimize En iyi Hizmeti Sunuyoruz.")
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                    .font(Font.system(size: 15))
                            }
                            
                        })
                        .padding(.horizontal)
                        .overlay(
                            GeometryReader { proxy -> Color in
                                
                                let minY = proxy.frame(in: .global).minY
                                
                                DispatchQueue.main.async {
                                    self.titleOffset = minY
                                }
                                return Color.clear
                            }
                            .frame(width: 0, height: 0)
                            ,alignment: .top
                        )
                                                
                        // Custom Segmented Menu
                        VStack(spacing: 0) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    
                                    TabButton(title: "Ana Sayfa", currentTab: $currentTab, animation: animation)
                                    
                                    TabButton(title: "Yorumlar", currentTab: $currentTab, animation: animation)
                                    
                                    TabButton(title: "Fotoğraflar", currentTab: $currentTab, animation: animation)
                                    
                                    TabButton(title: "Hizmetler", currentTab: $currentTab, animation: animation)
                                    
                                    TabButton(title: "Personel", currentTab: $currentTab, animation: animation)
                                }
                            }
                            
                            Divider()
                        }
                        .padding(.top, 15)
                        .background(colorScheme == .dark ? Color("DarkModeColor") : Color.white)
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
                            
                            if currentTab == "Ana Sayfa" {
                                ForEach(0..<10) { i in
                                    if i % 2 == 0 {
                                        SalonPostModel(currentPostImage: currentPostImage, currentPostLikes: currentPostLikes)
                                    } else {
                                        SalonPostModel(currentPostImage: currentPostImage2, currentPostLikes: currentPostLikes)
                                    }
                                    
                                    Divider()
                                }
                                
                            } else if currentTab == "Yorumlar" {
                                SalonCommentsVC(currentUserUsername: "dogukan")
                                
                            } else if currentTab == "Personel" {
                                ForEach(0..<10) { _ in
                                    StaffModel()
                                    
                                    Divider()
                                }
                                
                            } else {
                                MessagesVC()
                            }
                            
                        }
                        .padding(.top)
                        .zIndex(0)
                        
                    }
//                    .padding(.horizontal)
                    
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
                            .font(Font.system(size: 23))
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
        .background(colorScheme == .dark ? Color("DarkModeColor") : .white)

        
        .gesture(DragGesture().onChanged { gesture in
                if gesture.translation.width > 100 { // Minimum kaydırma mesafesi
                    // Geri dönme işlemi
                    self.presentationMode.wrappedValue.dismiss()
                }
            })
    }
    
    func getTitleTextOffset() -> CGFloat {
        
        // Some Amount For Progress For Slide Effect.
        let progress = 20 / titleOffset
        
        let offSet = 33 * (progress > 0 && progress <= 1 ? progress : 1)
        
        return offSet
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
        SalonDetailsVC(currentPostImage: UIImage(named: "catmakas")!, currentPostLikes: 34)
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
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        Button {
            withAnimation {
                currentTab = title
            }
        } label: {
            LazyVStack(spacing: 12) {
                Text(title)
                    .fontWeight(.semibold)
                    .foregroundColor(currentTab == title ? (colorScheme == .dark ? .white : .black) : .gray)
                    .padding(.horizontal)
                
                if currentTab == title {
                    Capsule()
                        .fill(colorScheme == .dark ? Color.white : Color.black)
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
