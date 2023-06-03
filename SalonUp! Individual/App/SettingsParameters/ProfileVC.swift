//
//  ProfileVC.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 30.05.2023.
//

import SwiftUI

struct ProfileVC: View {
    var body: some View {
        
        VStack {
            HStack {
                Image("dogukan")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            }
            
            HStack {
                Text("Doğukan Çatmakaş")
                    .fontWeight(.bold)
                    .font(.title)
                    .padding()
            }
            
        }
    }
}

struct ProfileVC_Previews: PreviewProvider {
    static var previews: some View {
        ProfileVC()
    }
}
