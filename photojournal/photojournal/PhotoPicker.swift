//
//  PhotoPicker.swift
//  photojournal
//
//  Created by Megan Korling on 7/28/22.
//  Tutorial: https://www.appcoda.com/phpicker/

import Foundation
import PhotosUI // --accessing PHPickerViewController class
import SwiftUI // --use UIViewControllerRepresentable protocol

// Create a new custom type (structure) that conforms to UIViewControllerRepresentable protocol and can bridge between UIKit view controller -- SwiftUI view

struct PhotoPicker: UIViewControllerRepresentable {
    // Binding makes this compatible in AddEntryView
    @Binding var mediaItems: [UIImage]
    
    var didFinishPicking: (_ didSelectItems: Bool) -> Void // actionhandler to be called in delegate method, then will be implemented as a closure in AddEntryView. This helps us know when the user is done, because how long that takes depends on the user
    
    // UIViewControllerRepresentable type must do 3 things
    // 1: Speciy the view controller type it's dealing with
    typealias UIViewControllerType = PHPickerViewController
    
    // 2: Implement a method that creates, configures, & returns view controller instance
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images // Can change this to include videos too
        config.selectionLimit = 3 // 0 = unlimited, (adjust delegate method for handling result)
        
        // Set standard configurations
        config.preferredAssetRepresentationMode = .current
        let controller = PHPickerViewController(configuration: config)
        controller.delegate = context.coordinator
        
        return controller
    }
    
    // 3: Perform updates to the view controller when they originate from the SwiftUI environment
    // It can remain empty (still has to be defined) if there's no reason to update view controller
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    // Initializes and returns Coordinator obj, passing PhotoPicker instance as an arg
    func makeCoordinator() -> Coordinator {
        Coordinator(with: self)
    }
    
    // Coordinator Class: acts as a delegate for view controllers that send messages through delegate methods, and pass received data to SwiftUI
    // Must be implemented inside a UIViewControllerRepresentale type
    class Coordinator: PHPickerViewControllerDelegate {
        var photoPicker: PhotoPicker // property that keeps the PhotoPicker instance
        
        // custom initializer method
        init(with photoPicker: PhotoPicker) {
            self.photoPicker = photoPicker
        }
        
        // MARK: Delegate method
        // Called when media items are selected or when it's canceled and picker is dismissed
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            // Selected items are contained in results

            photoPicker.didFinishPicking(!results.isEmpty)
            
            // If user dismissed the picker, then there's nothing to do, just return from method
            guard !results.isEmpty else {
                return
            }
            
            // For loop handles if more than one item selected (max is currently set at 3)
            for result in results {
                let itemProvider = result.itemProvider
                // Use the itemProvider to get the photo (instance of NSItemProvider class)
                // It will later be converted to Data to be stored via Core Data
                self.getPhoto(from: itemProvider)
            }
        }
        
        private func getPhoto(from itemProvider: NSItemProvider) {
            // Extract photo from given itemProvider
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                // Asynchronous method
                    if let error = error {
                        print(error.localizedDescription) // optimize this for maybe some type of message to appear in app
                    }
                    if let image = object as? UIImage {
                        // Need to get image which is the object, and cast to UIImage type.
                        DispatchQueue.main.async {
                            // Append selected photo as UIImage to PhotoPicker property: mediaItems
                            self.photoPicker.mediaItems.append(image)
                        }
                    }
                }
            }
        }
    }
}
