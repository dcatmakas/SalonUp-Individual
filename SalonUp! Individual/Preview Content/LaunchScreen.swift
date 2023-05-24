//
//  LaunchScreen.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 24.05.2023.
//

import SwiftUI

struct LaunchScreen: View {
    var body: some View {
        
        GeometryReader { geo in
            
            Color("MainColor").ignoresSafeArea()
            
            VStack {
                Image("SalonUp! Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()
                    .opacity(0.11)
            
            }
        }
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
