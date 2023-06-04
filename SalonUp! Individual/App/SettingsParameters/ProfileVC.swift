//
//  ProfileVC.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 30.05.2023.
//

import SwiftUI

struct ProfileVC: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var name: String = ""
    @State var surname: String = ""
    @State var email: String = ""
    
    @State private var selectedImage: UIImage?
    @State private var isShowingImagePicker: Bool = false
    
    var body: some View {
        
        VStack {
            VStack {
                HStack {
                    Image("dogukan")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 160, height: 160)
                        .clipShape(Circle())
                    
                        .onTapGesture {
                            isShowingImagePicker = true
                        }
                }
                
                HStack {
                    Text("Doğukan Çatmakaş")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .fontWeight(.bold)
                        .font(.title)
                        .padding()
                }
            }
            
            VStack {
                ZStack {
                    Rectangle()
                        .frame(width: .infinity, height: 50)
                        .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(colorScheme == .dark ? Color.white : Color.black)
                        )
                        .cornerRadius(16)
                    
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                            .padding(.leading)
                        
                        TextField("Doğukan", text: $name)
                            .textContentType(.name)
                            .padding(.trailing)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }

                }
                .padding()
                
                ZStack {
                    Rectangle()
                        .frame(width: .infinity, height: 50)
                        .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(colorScheme == .dark ? Color.white : Color.black)
                        )
                        .cornerRadius(16)
                    
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                            .padding(.leading)
                        
                        TextField("Çatmakaş", text: $surname)
                            .textContentType(.familyName)
                            .padding(.trailing)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }

                }
                .padding(.horizontal)
                
                ZStack {
                    Rectangle()
                        .frame(width: .infinity, height: 50)
                        .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(colorScheme == .dark ? Color.white : Color.black)
                        )
                        .cornerRadius(16)
                    
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                            .padding(.leading)
                        
                        TextField("dcatmakas@gmail.com", text: $email)
                            .textContentType(.emailAddress)
                            .padding(.trailing)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }

                }
                .padding()
            }
            
            Button(action: {
                // Upload Changes To Firebase
            }, label: {
                Text("Kaydet")
                    .padding(.vertical)
                    .padding(.horizontal, 80)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(16)
            })
            .padding()
            
            Spacer()
        
            .sheet(isPresented: $isShowingImagePicker) {
                        ImagePicker(selectedImage: $selectedImage)
            }
            
            .onTapGesture {
                hideKeyboard()
            }
            
        }
        .background(colorScheme == .dark ? Color("DarkModeColor") : .white)
        .toolbarBackground(Color("DarkModeColor"), for: .navigationBar)
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}


struct ProfileVC_Previews: PreviewProvider {
    static var previews: some View {
        ProfileVC()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                parent.selectedImage = selectedImage
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
