//
//  BlurViewModel.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 26.05.2023.
//

import SwiftUI

struct BlurViewModel: UIViewRepresentable {
    
    func makeUIView(context: Context) -> some UIView {
        
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialDark))
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
}

