//
//  SendCommentVC.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 21.06.2023.
//

import SwiftUI

struct SendRatingVC: View {
    
    // Dark Mode
    @Environment(\.colorScheme) var colorScheme
    
    // Dismiss
    @Environment(\.presentationMode) var presentationMode
    
    // Comment
    @State var comment: String = ""
    
    // Slider
    @State var professionalRating: Double = 3.0
    @State var hygieneRating: Double = 3.0
    @State var personalBehaviorRating: Double = 3.0
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                VStack(alignment: .center) {
                    Text("Deneyimini Değerlendir,")
                        .font(.title)
                        .fontWeight(.heavy)
                    
                    Text("Herkes Görsün!😋")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Text("Ziyaretin ve aldığın hizmetler hakkında değerlendirme yaparak diğer kullanıcılara yardımcı olabilirsin.")
                        .padding(.horizontal)
                        .padding(.top, 1)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                    
                }
                .padding(.bottom, 10)
                
                Rectangle()
                    .frame(width: .infinity, height: 0.5)
                    .foregroundColor(.gray)
                    .padding([.top, .horizontal],10)
                    .padding(.horizontal)
                
                VStack {
                    RatingSlider(rating: professionalRating, sliderName: "Profesyonellik😎:")
                        .padding([.horizontal, .top])
                    
                    RatingSlider(rating: hygieneRating, sliderName: "Hijyen🫧:")
                        .padding(.horizontal)
                    
                    RatingSlider(rating: personalBehaviorRating, sliderName: "Personel Davranışları🙂:")
                        .padding([.bottom, .horizontal])
                    
                }
                
                VStack {
                    
                    NavigationLink {
                        SendCommentVC()
                    } label: {
                        Text("Devam Et")
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
        
        .background(colorScheme == .dark ? Color("DarkModeColor") : .white)
        
    }
    
    func roundedValue(_ value: Double) -> Int {
        let roundedNumber = Int(value.rounded())
        return roundedNumber
    }
    
}

struct SendRatingVC_Previews: PreviewProvider {
    static var previews: some View {
        SendRatingVC()
    }
}

struct RatingSlider: View {
    
    @State var rating: Double
    @State var sliderName: String
    
    var body: some View {
        VStack {
            HStack {
                Text(sliderName)
                    .font(.title3)
                    .foregroundColor(.gray)
                    .bold()
                    .padding([.horizontal, .top])
                
                Spacer()
            }
            
            
            Slider(value: $rating, in: 1...5, step: 1) {
                Image(systemName: "star.fill")
            } minimumValueLabel: {
                Text("🥲")
                    .font(.title)
            } maximumValueLabel: {
                Text("😍")
                    .font(.title)
            }
            
            Text(roundedValue(rating))
                .font(.title)
                .fontWeight(.heavy)
            
        }
    }
}

func roundedValue(_ value: Double) -> String {
    let formatter = NumberFormatter()
    formatter.maximumFractionDigits = 1
    formatter.minimumFractionDigits = 0
    return formatter.string(from: NSNumber(value: value)) ?? ""
}
