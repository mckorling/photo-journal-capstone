//
//  PhotoPicker.swift
//  photojournal
//
//  Created by Megan Korling on 7/28/22.
//

import Foundation
import PhotosUI // --accessing PHPickerViewController class
import SwiftUI // --use UIViewControllerRepresentable protocol

// PHPicker controller is a UIKit view controller: PHPickerViewController class (need to mix SwiftUI and UIKit together)
// need to create a new custom type (structure) that conforms to UIViewControllerRepresentable protocol
// this will be bridge between UIKit view controller -- SwiftUI view

// keeping code clean by using this file

// conform it to the right protocol UIView....
struct PhotoPicker: UIViewControllerRepresentable {
    // property here (gets passed in in PhotoPicker instance in ItemsView)
    @ObservedObject var mediaItems: PickedMediaItems // could have used a different name from mediaItems
    // (above) it is not initialzed here like in ItemsView!
    // will pass the mediaItems object from ItemsView upon initialization of the PhotoPicker object
    
    // MARK: Can i add a property here that is observedstate? or something like that. Set it at what I want my max to be and somehow talk to AddEntryView? OR have two variables, one that tracks photos added to quit when it matches the selection limit?
    
    var didFinishPicking: (_ didSelectItems: Bool) -> Void // actionhandler to be called in delegate method, then will be implemented as a closure in SwiftUI view. This helps us know when the user is done, because how long that takes depends on the user
    
    // every UIViewCR type must do 3 things
    // 1: speciy the view controller type it's dealing with
    typealias UIViewControllerType = PHPickerViewController
    
    // 2: implement a method that creates, configures, & returns view controller instance
    func makeUIViewController(context: Context) -> PHPickerViewController {
        // when it's initialized (PHPVC) the configuration must be provided (given as a PHPickerConfiguration object)
        var config = PHPickerConfiguration()
        config.filter = .images // can change this to include videos too
        config.selectionLimit = 4 // can change this to more (0 = unlimited) have to adjust delegate method
        config.preferredAssetRepresentationMode = .current // helps lessen import time?
        
        // configuration object is ready
        // next, initialize a PHPickerVC instance, this is what will be returned
        let controller = PHPickerViewController(configuration: config)
        
        // set delegate here
        // Coordinator instance is accessible through the context parameter value of the method
        controller.delegate = context.coordinator
        
        return controller
    }
    
    // 3: perform updates to the view controller when they originate from teh SwiftUI environ. It can remain empty (still has to be defined) if there's no reason to update view controller. It is left empy here
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    // create instance of Coordinator (below below) in PhotoPicker structure.
    // initializes and returns Coordinator obj, passing PhotoPicker instance as an arg
    func makeCoordinator() -> Coordinator {
        Coordinator(with: self)
    }
    
    // Coordinator Class: acts as a delegate for view controllers that send messages through delegate methods, and pass received data to SwiftUI
    // needs to be implemented inside a UIViewControllerRepresentale type
    // it will be an object that will be set as the picker's delegate
    class Coordinator: PHPickerViewControllerDelegate {
        var photoPicker: PhotoPicker // property that keeps the PhotoPicker instance
        
        // custom initializer method
        init(with photoPicker: PhotoPicker) {
            self.photoPicker = photoPicker
        }
        
        // DELEGATE method
        // two actions can take place in picker view controller after it's presented: pick or cancel
        // however only one delegate method needs to be applied
        // it is called when media items are selected or when it's canceled and picker is dismissed
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            // selected items are contained in results (a collection of PHPickerResult objs)
            // each obj has a property called itemProvider, it's an instance of NSItemProvider class.
            // now how to let SwiftUI know that the picker is closed and whether there are selected items or not????
            // but the actual items themselves if selected are handled differently and asynchronously
            
            // calling callback of var didFinishPicking
            photoPicker.didFinishPicking(!results.isEmpty)
            // if the results array is not empty and the user selected some pics and results is true.
            // true.isempty is false, and the opposite of that is true
            // it's accessed via photoPicker property of Coordinates (it was declared to access PhotoPicker properties like we just did
            
            // if user dismissed the picker, then there's nothing to do, just return from method
            // will only proceed if the user picked something
            guard !results.isEmpty else {
                return
            }
            // currently can only select one photo - add for loop to handle more than one item selected
            // there is only one item in results. get that item's itemProvider
            // use the itemProvider to get the photo
            // CONVERT PHOTOS HERE TO SAVE???? because results is an array of images
            // var saveImageData: [Data]
            // MARK: Or can I get length of results here and only convert the ones needed to not go over max?
            for result in results {
                let itemProvider = result.itemProvider
                self.getPhoto(from: itemProvider)
                // print(result) = PHPickerResult(itemProvider: <PUPhotosFileProviderItemProvider: 0x600002290500> {types = ("public.jpeg")}, assetIdentifier: nil)
            }
        }
        
        // selected items are contained in results (a collection of PHPickerResult objs)
        // each obj has a property called itemProvider, it's an instance of NSItemProvider class.
        // NSItemProvider: (apple docs) an item provider for conveying data or a file between processes during drag and drop or copy/paste activities, or from a host app to an app extension
        // private means that is used in Coordiantor class only
        // WILL GET CALLED IN METHOD ABOVE (delegate method)
        private func getPhoto(from itemProvider: NSItemProvider) {
            // extract photo from given item provider
            // if successful, stores it in a new PhotoPickerModel obj, which will be appended to the items array
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
               // itemProvider.loadFileRepresentation(forTypeIdentifier: <#T##String#>, completionHandler: <#T##(URL?, Error?) -> Void#>)
                // returns true:
                itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                // asynchronous method. when completed it brings back a loaded object or an error
                    if let error = error {
                        print(error.localizedDescription) // optimize this for maybe some type of message to appear in app
                    }
                    if let image = object as? UIImage {
                        // need to get image which should be the object. To get it, need to cast UIImage type.
                        // object is a NSItemProviderReading value
                        
                        // CONVERT
//                        let imageData = image.pngData()
//                        let image = UIImage(data: imageData!)
                        
                        DispatchQueue.main.async {
                            self.photoPicker.mediaItems.append(item: PhotoPickerModel(with: image))
                            // if casting and unwrapping the optional object to image succeeds
                            // store the loaded image to a new PhotoPickerModel instance
                            // it's appended to mediaItem property (happens in main thread?)
                            // this triggers a change to @Published property (items array) (happens in main thread?)
                           
                        }
                    }
                }
            }
        }
    }
}
