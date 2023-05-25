//
//  SalonViewModel.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 25.05.2023.
//

import SwiftUI

struct SalonViewModel: View {
    
    @State var isPremiumSalon: Bool = true
    
    var body: some View {
                
        HStack {
            VStack {
                Image("catmakas.logo")
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 50)
            }
            
            VStack {
                
                if isPremiumSalon {
                    HStack {
                        Image(systemName: "star.circle.fill")
                            .foregroundColor(Color("MainColor"))
                        
                        Text("Premium Salon")
                            .foregroundColor(Color("MainColor"))
                            .fontWeight(.semibold)
                            .font(.subheadline)
                        
                        Spacer()
                    }
                    
                }
                
                HStack {
                    Text("Çatmakas Salon")
                        .bold()
                        .font(.title2)
                    
                    Spacer()
                }
                .padding(.bottom, 10)
                
                HStack {
                    Spacer()
                    
                    Image(systemName: "mappin.circle.fill")
                    
                    Text("Nilüfer")
                }
                
            }
            Spacer()
        }
        
    }
}

struct SalonViewModel_Previews: PreviewProvider {
    static var previews: some View {
        SalonViewModel()
    }
}
