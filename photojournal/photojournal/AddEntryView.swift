//
//  AddEntryView.swift
//  photojournal
//
//  Created by Megan Korling on 7/28/22.
//

import SwiftUI

struct AddEntryView: View {
    @Environment(\.managedObjectContext) var moc
    // use @State properties to store all data to make a book
    // id will get created dynamically
    @State private var title = ""
    @State private var location = ""
    @State private var date = Date()
    @State private var photosByteData = [Data]()
    @State private var entryText = ""
    
    @State private var showSheet = false
    @ObservedObject var mediaItems = PickedMediaItems()
    // PickedMediaItems is a class in PhotoPickerModel
    // mediaItems is an instance of PickedMediaItems class
    // property wrapper ObservedObject means the view can observe and react to changes that happpen in the items array that uses the property wrapper @Published in the PickedMediaItems class.
    func convertImageToBytes(items: [PhotoPickerModel]) -> [Data] {
        var convertedPhotosToBytes = [Data]()
        items.forEach({ (image) in
            let imageBytes = image.photo?.jpegData(compressionQuality: 1.0)
            convertedPhotosToBytes.append(imageBytes!)
        })
        return convertedPhotosToBytes
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title for new entry", text: $title)
                    TextField("Location for new entry", text: $location)
                }
                Section {
                    DatePicker("Choose date for new entry", selection: $date, in: ...Date())
                        .datePickerStyle(GraphicalDatePickerStyle())
                }
                Section {
                    TextEditor(text: $entryText)
                } header: {
                    Text("What did you do on this day?")
                }
                Section {
                    
                    Button(action: {
                        showSheet = true
                    }, label: {
                        Text("Select Photos")
                    })
                    List(mediaItems.items, id: \.id) { item in
                        Image(uiImage: item.photo ?? UIImage())
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }.onAppear {
                        photosByteData = convertImageToBytes(items: mediaItems.items)
                    }
                }
                Section {
                    Button("Save") {
                        // add the book
                    }
                }
            }
        }.sheet(isPresented: $showSheet, content: {
            PhotoPicker(mediaItems: mediaItems) { didSelectItems in
                showSheet = false
                
            }
        })
    }
    // outside of view
}

struct AddEntryView_Previews: PreviewProvider {
    static var previews: some View {
        AddEntryView()
    }
}
