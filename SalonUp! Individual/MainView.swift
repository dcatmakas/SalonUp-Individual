//
//  MainView.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 24.05.2023.
//

import SwiftUI

struct MainView: View {
    
    @State var animate = false
    @State var endSplash = false
    
    var body: some View {
        ZStack {
            
            LoginVC()
            
            ZStack {
                Color("MainColor")
                
                Image("Logo Without Background")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: animate ? .fill : .fit)
                    .frame(width: animate ? nil : 85, height: animate ? nil : 85)
                // Scaling Effect
                    .scaleEffect(animate ? 3 : 1)
                // Setting Width To Avoid Over Size
                    .frame(width: UIScreen.main.bounds.width)
            }
            .ignoresSafeArea()
            .onAppear(perform: animateSplash)
            // Hiding View After Finished.
            .opacity(endSplash ? 0 : 1)
        }
    }
    
    func animateSplash() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            
            withAnimation(Animation.easeInOut(duration: 0.45)) {
                
                animate.toggle()
            }
            
            withAnimation(Animation.easeInOut(duration: 0.35)) {
                
                endSplash.toggle()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
