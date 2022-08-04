//
//  AddEntryView.swift
//  photojournal
//
//  Created by Megan Korling on 7/28/22.
//

import SwiftUI

struct AddEntryView: View {
    @Environment(\.managedObjectContext) var moc
    
    // use @State properties to store all data to make an entry (all model properties)
    // id will get created dynamically
    @State private var title = ""
    @State private var location = ""
    @State private var date = Date()
    @State private var image1 = Data()
    @State private var image2 = Data()
    @State private var image3 = Data()
    @State private var entryText = ""
    
 //   @State private var saveButtonSelected = false
    @State private var showSheet = false
   // @ObservedObject var mediaItems = PickedMediaItems()
    @State private var mediaItems = [UIImage]()
    // PickedMediaItems is a class in PhotoPickerModel
    // mediaItems is an instance of PickedMediaItems class
    // property wrapper ObservedObject means the view can observe and react to changes that happpen in the items array that uses the property wrapper @Published in the PickedMediaItems class.

    
    func getRandomImage() -> String {
        let photos = ["bird", "kangaroo", "bird", "daschund", "koala", "lambs", "orangutan", "monkey", "polarbear", "buffalo"]
        return photos.randomElement()!
        
    }
    // random images in assets collection are from Unsplash
    func setImages(entry: Entry) {
        if mediaItems.count == 3 {
            entry.image1 = mediaItems[0].jpegData(compressionQuality: 1.0)
            entry.image2 = mediaItems[1].jpegData(compressionQuality: 1.0)
            entry.image3 = mediaItems[2].jpegData(compressionQuality: 1.0)
        } else if mediaItems.count == 2 {
            entry.image1 = mediaItems[0].jpegData(compressionQuality: 1.0)
            entry.image2 = mediaItems[1].jpegData(compressionQuality: 1.0)
            entry.image3 = UIImage(named: getRandomImage())?.jpegData(compressionQuality: 1.0)
        } else if mediaItems.count == 1 {
            entry.image1 = mediaItems[0].jpegData(compressionQuality: 1.0)
            entry.image2 = UIImage(named: getRandomImage())?.jpegData(compressionQuality: 1.0)
            entry.image3 = UIImage(named: getRandomImage())?.jpegData(compressionQuality: 1.0)
        } else {
            entry.image1 = UIImage(named: getRandomImage())?.jpegData(compressionQuality: 1.0)
            entry.image2 = UIImage(named: getRandomImage())?.jpegData(compressionQuality: 1.0)
            entry.image3 = UIImage(named: getRandomImage())?.jpegData(compressionQuality: 1.0)
        }
    }
    
    func resetFields() {
        self.title = ""
        self.location = ""
        self.date = Date()
        self.image3 = Data()
        self.image2 = Data()
        self.image1 = Data()
        self.entryText = ""
      //  mediaItems.items.removeAll()
        self.mediaItems.removeAll()
    }
    
    var body: some View {
        let gradient = LinearGradient(colors: [.mint, .pink, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing)
        
        
        ZStack {
            gradient
                .opacity(0.30)
                .ignoresSafeArea()
       //     NavigationView {
            VStack {
                Form {
                    Section(header: Text("Start a new journal entry")) {
                        TextField("Title", text: $title)
                        TextField("Location", text: $location)
                    }
                    Section(header: Text("Select the date")) {
                        DatePicker("Select date", selection: $date, in: ...Date())
                            .datePickerStyle(GraphicalDatePickerStyle())
                    }
                    Section {
                        TextEditor(text: $entryText)
                    } header: {
                        Text("What did you do on this day?")
                    }
                    Section (footer: Text("Up to 3 photos allowed")){
                        
                        Button(action: {
                            showSheet = true
                        }, label: {
                            Text("Select Photos")
                                .frame(maxWidth: .infinity, alignment: .center)
                        })
                        // removed photopickermodel
                        List(mediaItems, id: \.self) { item in
                            Image(uiImage: item)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        
                        }
                    }
                    Section {
                        
                        Button(action: {
                            let newEntry = Entry(context: moc)
                            newEntry.id = UUID()
                            newEntry.title = title
                            newEntry.location = location
                            newEntry.date = date
                            newEntry.entryText = entryText
                            setImages(entry: newEntry)
    //                        newEntry.image1 = mediaItems.items[0].photo!.jpegData(compressionQuality: 1.0)
    //                        newEntry.image2 = mediaItems.items[1].photo!.jpegData(compressionQuality: 1.0)
    //                        newEntry.image3 = mediaItems.items[2].photo!.jpegData(compressionQuality: 1.0)
                            
                            // managed object context to save itself, writes changes to persistant store.
                            // a throwing function call
                            // use try? in case it fails, not catching errors
                            try? moc.save()
                            // clear out form, should be able to select photos from scratch
                            resetFields()
                           // saveButtonSelected = true
                        }) { // button label
                            Text("Save")
                                .frame(maxWidth: .infinity, alignment: .center)
                        } // end of button label
                        
                    } //end of button section
                    
                    
                }
                .onAppear{
                    UITableView.appearance().backgroundColor = .clear
                }
            }
        //    }// end of nav view
            
        }.sheet(isPresented: $showSheet, content: {
            // shouldn't need to change
            PhotoPicker(mediaItems: $mediaItems) { didSelectItems in
                showSheet = false
            }
        }) // end of sheet
    }
    // outside of view
} // end of struct

struct AddEntryView_Previews: PreviewProvider {
    static var previews: some View {
        AddEntryView()
    }
}
