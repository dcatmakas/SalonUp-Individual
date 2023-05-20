//
//  ContentView.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 16.05.2023.
//

import SwiftUI

struct LoginVC: View {
    
    private let backgroundColor = UIColor(hex: "#7557D6")
    
    var body: some View {
        
        GeometryReader { geo in
            
            Color(backgroundColor).ignoresSafeArea()

            ZStack {
                
                Image("SalonUp! Simge")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .opacity(0.11)
                
                VStack {
                    HStack {
                        Text("SalonUp!")
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                            .font(Font.system(size: 60))
                    }
                    
                    HStack {
                        Text("Individual")
                            .foregroundColor(.white)
                            .font(Font.system(size: 30))
                    }
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginVC()
    }
}
