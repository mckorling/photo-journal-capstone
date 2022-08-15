//
//  PhotoPickerModel.swift
//  photojournal
//
//  Created by Megan Korling on 7/28/22.
//  Tutorial: https://www.appcoda.com/phpicker/

// NOT USING THIS FILE, BUT KEEPING IT BECAUSE IT CAN BE USED TO EXPAND PROJECT LATER
// IF I WANT TO STORE VIDEOS OR LIVEPHOTOS

import SwiftUI
import Photos

struct PhotoPickerModel: Identifiable {
    // enumeration with cases that will be indicating the type of media that an instance is holding
    enum MediaType {
        case photo, video, livePhoto
    }

    // A List (and other types) need each item to be uniquely identifiable
    // Tell the Model to conform to protocol: Identifiable
    // Identifiable requires an id, can be any type
    var id: String
    var photo: UIImage? // Normal photos
    var url: URL? // Video can't be fetched as a single object. Store the url to the file containing a picked video
    var livePhoto: PHLivePhoto?
    var mediaType: MediaType = .photo // default initial value of photo
    // Optional properties have a '?'
    // Just one of these properties will get an actual value
    
    // Custom initializer in the case of photos
    init(with photo: UIImage) {
        id = UUID().uuidString
        self.photo = photo // Keep photo to the photo property
        mediaType = .photo // Specifically define the mediaType
    }
    
    // Do the same for videos and livePhotos too (follow tutorial for missing code related to videos and live photos)
    
//    init(with videoURL: URL) {
//        id = UUID().uuidString
//        url = videoURL
//        mediaType = .video
//    }
//
//    init(with livePhoto: PHLivePhoto) {
//        id = UUID().uuidString
//        self.livePhoto = livePhoto
//        mediaType = .livePhoto
//    }
}

// ObservableObject makes it possible to tell SwiftUI views about changes happening to the array: items
class PickedMediaItems: ObservableObject {
    @Published var items = [PhotoPickerModel]()
    
    func append(item: PhotoPickerModel) {
        items.append(item)
    }
}
