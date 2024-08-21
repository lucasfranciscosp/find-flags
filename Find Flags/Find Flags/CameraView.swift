//
//  CameraView.swift
//  Find Flags
//
//  Created by Lucas Francisco on 01/08/24.
//

import SwiftUI
import PhotosUI

struct CameraView: View {
    
    @State private var image: UIImage?
    @State private var isConfirmationDialogPresented: Bool = false
    @State private var isImagePickerPresented: Bool = false
    @State private var sourceType: SourceType = .camera
    
    @ObservedObject var classifier: ImageClassifier
    
    enum SourceType {
        case camera
        case photoLibrary
    }
    
    var body: some View {
        VStack {
            ZStack {
                if let image = image {
                    CircularImageView(image: image)
                } else {
                    PlaceholderView()
                }
            }
            .onTapGesture{
                isConfirmationDialogPresented = true
            }
            .confirmationDialog("Choose an option", isPresented: $isConfirmationDialogPresented) {
                Button("Camera") {
                    sourceType = .camera
                    isImagePickerPresented = true
                }
                Button("Photo Library") {
                    sourceType = .photoLibrary
                    isImagePickerPresented = true
                }
            }
            .sheet(isPresented: $isImagePickerPresented) {
                if sourceType == .camera {
                    ImagePicker(isPresented: $isImagePickerPresented, image: $image, sourceType: .camera)
                } else {
                    PhotoPicker(selectedImage: $image)
                }
            }
            VStack{
                Button(action: {
                    if image != nil {
                        classifier.detect(uiImage: image!)
                    }
                }) {
                    Image(systemName: "bolt.fill")
                        .foregroundColor(.orange)
                        .font(.title)
                }
                
                Group {
                    if let imageClass = classifier.imageClass {
                        HStack{
                            Text("Image categories:")
                                .font(.caption)
                            Text(imageClass)
                                .bold()
                        }
                    } else {
                        HStack{
                            Text("Image categories: NA")
                                .font(.caption)
                        }
                    }
                }
                .font(.subheadline)
                .padding()
            }
        }
    }
}

//#Preview {
//    CameraView()
//}

struct CircularImageView: View {
    var image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable().scaledToFill()
            .frame(width: 200, height: 200)
            .clipShape(Circle())
    }
}

struct PlaceholderView: View {
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 5)
                .foregroundColor(.gray)
                .frame(width: 200, height: 200)
            Image(systemName: "plus")
                .font(.system(size: 50))
                .foregroundColor(.gray)
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    @Binding var image: UIImage?
    var sourceType: UIImagePickerController.SourceType
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        var parent:ImagePicker
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.isPresented = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }
    }
}

struct PhotoPicker: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    }
    
    @Binding var selectedImage: UIImage?
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent:PhotoPicker
        
        
        init(parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            if let result = results.first {
                result .itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                    if let uiImage = object as? UIImage {
                        DispatchQueue.main.async {
                            self.parent.selectedImage = uiImage
                        }
                    }
                    
                }
            }
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        
        configuration.selectionLimit = 1
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
}
