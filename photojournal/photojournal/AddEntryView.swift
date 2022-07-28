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
    
    @ObservedObject var mediaItems = PickedMediaItems()
    // PickedMediaItems is a class in PhotoPickerModel
    // mediaItems is an instance of PickedMediaItems class
    // property wrapper ObservedObject means the view can observe and react to changes that happpen in the items array that uses the property wrapper @Published in the PickedMediaItems class.
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title for new entry", text: $title)
                    TextField("Location for new entry", text: $location)
                    DatePicker("Choose date for new entry", selection: $date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                }
                Section {
                    TextEditor(text: $entryText)
                } header: {
                    Text("What did you do on this day?")
                }
                Section {
                    
                    Button("Select Photos") {
                        // insert photo picker
                    }
                }
                Section {
                    Button("Save") {
                        // add the book
                    }
                }
            }
        }
    }
}

struct AddEntryView_Previews: PreviewProvider {
    static var previews: some View {
        AddEntryView()
    }
}
