//
//  PhotoPickerModel.swift
//  photojournal
//
//  Created by Megan Korling on 7/28/22.
//

import SwiftUI
import Photos

struct PhotoPickerModel: Identifiable {
    // enumeration with cases that will be indicating the type of media that an instance is holding
    enum MediaType {
        case photo, video, livePhoto
    }
    
    // a later task: present a collection of PhotoPickerModel items in a SwiftUI List view
    // a List (and other types) need each item to be uniquely identifiable
    // we tell the Model to conform to a specific protocol: Identifiable
    // Identifiable has requirement that there is a property called id, can be any type
    // UUID = universaly unique value that can be used to identify types, interfaces, and other items
    // declare properties:
    var id: String
    var photo: UIImage? //normal photos
    var url: URL? // video can't be fetched as a single object. store the url to the file containing a picked video
    var livePhoto: PHLivePhoto?
    var mediaType: MediaType = .photo // default initial value of photo
    // optional properties have a '?'
    // their default value is nil
    // in this model, just one of these properties will get an actual value
    
    // custom initializer in the case of photos
    init(with photo: UIImage) {
        id = UUID().uuidString // unique identifier for current item
        self.photo = photo // keep photo to the photo property
        mediaType = .photo // being specfic and defining the mediaType (even though default is photo)
    }
    
    // do the same for videos and livePhotos now too
    
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
    // need one more custom type that actually keeps an array of such objects
    // will store media items once extraceted from picker results
    // also is datasource for List view in ItemsView
    
    @Published var items = [PhotoPickerModel]()
 
    // items is an array of PhotoPickerModel objects.
    // when something is added or removed, ItemsView will be notified. The entire view will get rerendered.
    
    func append(item: PhotoPickerModel) {
        items.append(item)
        
    }
}

