//
//  MessagesVC.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 24.05.2023.
//

import SwiftUI

struct MessagesVC: View {
    var body: some View {
        
        MessageModel()
    }
}

struct MessagesVC_Previews: PreviewProvider {
    static var previews: some View {
        MessagesVC()
    }
}

struct MessageModel: View {
    var body: some View {
        ZStack {
//            Rectangle()
//                .frame(width: .infinity, height: 90)
//                .foregroundColor(Color("CellColor"))
            Color("CellColor")

            
            HStack {
                Image("catmakas.logo")
                    .resizable()
                    .frame(width: 70,height: 70)
                    .scaledToFit()
                    .clipShape(Circle())
                    .padding()
                
                VStack {
                    HStack {
                        Text("Çatmakas Salon")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.bottom, 1)
                        
                        Spacer()
                        
                        Text("15:05")
                            .foregroundColor(.gray)
                            .padding(.trailing, 5)
                    }

                    HStack {
                        Text("Siz:")
                            .font(.headline)
                            .fontWeight(.regular)
                            .foregroundColor(Color("MainColor"))
                        
                        Text("Merhaba!")
                            .font(.headline)
                            .fontWeight(.regular)
                        
                        Spacer()
                    }
                }
                Spacer()
            }
        }
    }
}
