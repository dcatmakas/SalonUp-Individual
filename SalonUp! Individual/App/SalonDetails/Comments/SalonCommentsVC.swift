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
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                
                SalonAverageModel()
                
                Divider()
                
                NavigationLink {
                    SendRatingVC()
                        .navigationTitle("")
                } label: {
                    Text("Deneyimini Değerlendir")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("LoginButtonColor"))
                        .foregroundColor(.white)
                        .cornerRadius(16)
                        .padding()
                }

                
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
        
        .onTapGesture {
            hideKeyboard()
        }
        
        .navigationTitle("")
        
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
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
    
    // Comment
    @State var isCommentLiked: Bool = false
    @State var isCommentDisliked: Bool = false
    
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
                        .font(.title)
                        .foregroundColor(.yellow)
                    
                    Text("4/5")
                        .font(.title2)
                        .bold()
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                    
                    Text("Profesyonellik")
                        .font(Font.system(size: 14))
                    
                }
                .padding()
                
                VStack(alignment: .center) {
                    Image(systemName: "star.fill")
                        .font(.title)
                        .foregroundColor(.yellow)
                    
                    Text("5/5")
                        .font(.title2)
                        .bold()
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                    
                    Text("Hijyen")
                        .font(Font.system(size: 14))
                    
                }
                .padding()
                
                VStack {
                    Image(systemName: "star.fill")
                        .font(.title)
                        .foregroundColor(.yellow)
                    
                    Text("4/5")
                        .font(.title2)
                        .bold()
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                    
                    Text("Personel")
                        .font(Font.system(size: 14))
                    
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
                    Button {
                        if isCommentLiked == false && isCommentDisliked == false {
                            isCommentLiked = true
                        } else if isCommentLiked == false && isCommentDisliked == true {
                            isCommentLiked = true
                            isCommentDisliked = false
                        } else if isCommentLiked == true && isCommentDisliked == false {
                            isCommentLiked = false
                        } else {
                            isCommentLiked = false
                            isCommentDisliked = false
                        }
                    } label: {
                        if isCommentLiked == true {
                            Image(systemName: "hand.thumbsup.fill")
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                .font(.title2)
                            
                        } else {
                            Image(systemName: "hand.thumbsup")
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                .font(.title2)
                        }
                    }
                    .padding(.leading)
                    
                    Button {
                        if isCommentLiked == false && isCommentDisliked == false {
                            isCommentDisliked = true
                        } else if isCommentLiked == false && isCommentDisliked == true {
                            isCommentDisliked = false
                        } else if isCommentLiked == true && isCommentDisliked == false {
                            isCommentLiked = false
                            isCommentDisliked = true
                        } else {
                            isCommentLiked = false
                            isCommentDisliked = false
                        }
                    } label: {
                        if isCommentDisliked == true {
                            Image(systemName: "hand.thumbsdown.fill")
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                .font(.title2)
                            
                        } else {
                            Image(systemName: "hand.thumbsdown")
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                .font(.title2)
                        }
                    }
                    .padding(.horizontal)


                    
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
                        .font(.title)
                        .foregroundColor(.yellow)
                    
                    Text("4.2/5")
                        .font(.title2)
                        .bold()
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                    
                    Text("Profesyonellik")
                        .font(Font.system(size: 14))
                    
                }
                .padding()
                
                VStack(alignment: .center) {
                    Image(systemName: "star.fill")
                        .font(.title)
                        .foregroundColor(.yellow)
                    
                    Text("3.9/5")
                        .font(.title2)
                        .bold()
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                    
                    Text("Hijyen")
                        .font(Font.system(size: 14))
                    
                }
                .padding(.vertical)
                
                VStack {
                    Image(systemName: "star.fill")
                        .font(.title)
                        .foregroundColor(.yellow)
                    
                    Text("4.7/5")
                        .font(.title2)
                        .bold()
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                    
                    Text("Personel")
                        .font(Font.system(size: 14))
                    
                }
                .padding()
                
            }
        }
    }
}
