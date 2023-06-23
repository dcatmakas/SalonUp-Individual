//
//  StaffVC.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 23.06.2023.
//

import SwiftUI

struct StaffVC: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            StaffModel()
        }
    }
}

struct StaffVC_Previews: PreviewProvider {
    static var previews: some View {
        StaffVC()
    }
}

struct StaffModel: View {
    var body: some View {
        VStack {
            HStack {
                Image("dogukan")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .cornerRadius(10)
                
                VStack(alignment: .leading) {
                    Text("Doğukan Çatmakaş")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text("Saç Stilisti")
                        .font(.callout)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 4)
                
                Spacer()
                
                Button {
                    //
                } label: {
                    Image(systemName: "paperplane.circle.fill")
                        .font(.title)
                        .foregroundColor(Color("MainColor"))
                }
                
            }
            .padding(.horizontal)
        }
    }
}
