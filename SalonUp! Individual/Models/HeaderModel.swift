//
//  HeaderModel.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 24.05.2023.
//

import SwiftUI

struct HeaderModel: View {
    var body: some View {
        
        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: .infinity, height: 50)
                Spacer()
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

struct HeaderModel_Previews: PreviewProvider {
    static var previews: some View {
        HeaderModel()
    }
}
