//
//  ImagePickerModel.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 6.06.2023.
//

import SwiftUI
import UIKit


struct ImagePickerModel: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedImage: UIImage?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var presentationMode: PresentationMode
        @Binding var selectedImage: UIImage?

        init(presentationMode: Binding<PresentationMode>, selectedImage: Binding<UIImage?>) {
            _presentationMode = presentationMode
            _selectedImage = selectedImage
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            var selectedImage: UIImage?
            
            if let editedImage = info[.editedImage] as? UIImage { // Kırpılmış resmi al
                selectedImage = editedImage
            } else if let originalImage = info[.originalImage] as? UIImage { // Kırpılmamış resmi al
                selectedImage = originalImage
            }
            
            self.selectedImage = selectedImage
            $presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            $presentationMode.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(presentationMode: presentationMode, selectedImage: $selectedImage)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerModel>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.allowsEditing = true
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerModel>) {
        // Leave this empty
    }
}
