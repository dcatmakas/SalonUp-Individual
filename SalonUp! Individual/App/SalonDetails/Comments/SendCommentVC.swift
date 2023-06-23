//
//  SendCommentVC.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 22.06.2023.
//

import SwiftUI

struct SendCommentVC: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var comment : String = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Dilersen Aşağıdaki Boşlukta Düşüncelerini Paylaşabilirsin!✂️")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                Text("Yaptığın yorumlar sayesinde diğer kullanıcılara yardımcı olabilir ve aldığın hizmetin iyileştirilmesini sağlayabilirsin.")
                    .font(.title3)
                    .foregroundColor(.gray)
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 1)
            .padding(.bottom, 70)
            
            TextEditor(text: $comment)
                .frame(width: .infinity, height: 200)
                .font(Font.system(size: 18))
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1)
                )
                .padding()
            
            Spacer()
            
            Button {
                // Save The Comment
                
                
            } label: {
                Text("Yorumu Yayınla")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("LoginButtonColor"))
                    .foregroundColor(.white)
                    .cornerRadius(16)
                    .padding()
            }
            
        }
    }
}

struct SendCommentVC_Previews: PreviewProvider {
    static var previews: some View {
        SendCommentVC()
    }
}
