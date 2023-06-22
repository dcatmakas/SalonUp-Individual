//
//  SalonPostsVC.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 19.06.2023.
//

import SwiftUI

struct SalonPostsVC: View {
    var body: some View {
        
        VStack {
            SalonPostModel(currentPostImage: UIImage(named: "catmakas")!, currentPostLikes: 34)
        }
        
    }
}

struct SalonPostsVC_Previews: PreviewProvider {
    static var previews: some View {
        SalonPostsVC()
    }
}

struct SalonPostModel: View {
    
    @Environment(\.colorScheme) var colorScheme
    // Post Details
    @State var currentPostImage: UIImage
    @State var currentPostLikes: Int
    
    // Details From User
    @State private var isLiked: Bool = false

    
    var body: some View {
        VStack {
            HStack {
                
                Image(systemName: "scissors.circle.fill")
                    .foregroundColor(Color("MainColor"))
                
                Text("Saç Kesimi")
                    .fontWeight(.bold)
                    .font(Font.system(size: 21))
                
                Spacer()
                
                Button {
                    // Post işlemleri
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .font(.title2)
                }
            }
            .padding(.horizontal)
            
            VStack {
                Image(uiImage: currentPostImage)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(5)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 10)
                    .padding(.horizontal, 10)
            }
            
            HStack {
                Button {
                    // Like Actions
                    if isLiked == false { isLiked = true } else { isLiked = false }
                } label: {
                    if isLiked == false {
                        Image(systemName: "heart")
                            .font(.title2)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        
                    } else {
                        Image(systemName: "suit.heart.fill")
                            .font(.title2)
                            .foregroundColor(.red)
                    }
                }
                
                Text("\(isLiked == true ? currentPostLikes + 1 : currentPostLikes)")
                    .foregroundColor(.gray)
                    .fontWeight(.semibold)
                    .animation(.default)
                
                Spacer()
                
                Text("29 Dakika Önce")
                    .font(Font.system(size: 15))
                    .foregroundColor(.gray)
                    .fontWeight(.light)
                
            }
            .padding(.horizontal)
            
        }
        .background(colorScheme == .dark ? Color("DarkModeColor") : .white)
    }
}
