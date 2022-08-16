//
//  AddEntryView.swift
//  photojournal
//
//  Created by Megan Korling on 7/28/22.
//

import SwiftUI

struct AddEntryView: View {
    // Cases where the keyboard is used, so that it can be dismissed with focusedField and toolbar
    private enum Field {
        case title, location, entryText
    }
    @FocusState private var focusedField: Field?
    @Environment(\.managedObjectContext) var moc
    
    let apiKey = "pk.1f00c7cb204323568c51950910d520e8"
    // Unsuccessfully tried to make api key secret (next line)
    // let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String
    
    // Use @State for properties to store all data whose value can change to make an Entry
    // id property will get created dynamically
    @State private var title = ""
    @State private var location = ""
    @State private var date = Date() // Current date is default if user doesn't enter one
    @State private var image1 = Data()
    @State private var image2 = Data()
    @State private var image3 = Data()
    @State private var entryText = ""
    @State private var latitude = Double()
    @State private var longitude = Double()
    
    @State private var showSheet = false // toggle value to show Photo Picker or not
    @State private var mediaItems = [UIImage]() // will hold selected photos, is not saved directly to Core Data

    
    // MARK: Helper functions related to photos
    // I had difficulty storing a list of images converted to Data
    // I opted to instead store three images, converted to Data
    // If a user doesn't select three images from their photo library, a default random image is selected
    // This function returns the name of the image that can be loaded from Assets
    // All images are from Unsplash
    func getRandomImage() -> String {
        let photos = ["bird", "kangaroo", "bird", "daschund", "koala", "lambs", "orangutan", "monkey", "polarbear", "buffalo"]
        return photos.randomElement()!
    }
    
    // Explicitely set the value for each image property depending on how many the user selected (the count of mediaItems)
    // jpegData method is better than pngData method, for camera images
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
    
    // MARK: Helper functions related to API call
    // Format the user entered location to replace " " with "+"
    // This way the call will not fail because of ill-formated query param
    func formatLocString(location: String) -> String {
        let locArray = location.components(separatedBy: " ")
        let formatted = locArray.joined(separator: "+")
        return formatted
    }
    
    // Call LocationIQ API to get the latitude and longitude of a location
    // It will also set an entry's latitude and longitude properties to avoid issues with it being an aysnchronous call
    func fetchAPI(entry: Entry) async {
        // Provide query params directly into the url
        // Set the limit to 1 to only get back 1 object in response body: [{}]
        let url = URL(string: "https://us1.locationiq.com/v1/search.php?key=\(String(describing: apiKey))&q=\(formatLocString(location: location))&format=json&limit=1")
        URLSession.shared.dataTask(with: url!) { data, response, error in
                if let data = data {
                    if let decodedLocation = try?
                        // Decode data using a custom designed structure called Result (MARKed at bottom of file)
                        // It expects the data to be a list of Result objects, which contain only the values I need from LocationIQ
                        JSONDecoder().decode([Result].self, from: data) {
                        // The limit was set to 1 as a query param, so only the first element needs to be accessed in decodedLocation
                        // Convert JSON's String values to Double to match Entry entity
                        latitude = Double(decodedLocation[0].lat)!
                        longitude = Double(decodedLocation[0].lon)!
                        entry.latitude = latitude
                        entry.longitude = longitude
                    }
                    else { // Error occurred, couldn't set a value to decodedLocation
                        // Use default values for latitude and longitude
                        latitude = 0
                        longitude = 0
                        entry.latitude = latitude
                        entry.longitude = longitude
                    }
                }
        }.resume()
    }
    
    // MARK: Helper function after "save"
    // Reset all form fields to default values so user can start another Entry
    func resetFields() {
        self.title = ""
        self.location = ""
        self.date = Date()
        self.image3 = Data()
        self.image2 = Data()
        self.image1 = Data()
        self.entryText = ""
        self.mediaItems.removeAll()
        self.latitude = Double()
        self.longitude = Double()
    }
    
    // MARK: Start of View
    var body: some View {
        let gradient = LinearGradient(colors: [.mint, .pink, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing)
        
        ZStack {
            gradient
                .opacity(0.30)
                .ignoresSafeArea()
            VStack {
                Form {
                    Section(header: Text("Start a new journal entry")) {
                        TextField("Title", text: $title)
                            // Modifier focused: matches to an enumeration field
                            // Works with toolbar modifier on Form container
                            // Lets the user dismiss the keyboard by tapping "DONE"
                            .focused($focusedField, equals: .title)
                        TextField("Location", text: $location)
                            .focused($focusedField, equals: .location)
                    }
                    Section(header: Text("Select the date")) {
                        DatePicker("Select date", selection: $date, in: ...Date())
                            .datePickerStyle(GraphicalDatePickerStyle())
                        // Time shows in this style, but is not used later
                    }
                    Section {
                        TextEditor(text: $entryText)
                            .focused($focusedField, equals: .entryText)
                    } header: {
                        Text("What did you do on this day?")
                    }
                    Section (footer: Text("Up to 3 photos allowed")){
                        Button(action: {
                            // Shows Photo Picker if true
                            showSheet = true
                        }, label: {
                            Text("Select Photos")
                                .frame(maxWidth: .infinity, alignment: .center)
                        })
                        // Displays any selected photos (which have not been saved and converted to Data yet)
                        List(mediaItems, id: \.self) { item in
                            Image(uiImage: item)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                    Section {
                        // MARK: Save Button Action
                        Button(action: {
                            // create new Entry for user
                            let newEntry = Entry(context: moc)
                            newEntry.id = UUID() // No user interaction for ID
                            // Set default values for title and location properties if user declines
                            if title == "" {
                                newEntry.title = "Title"
                            } else {
                                newEntry.title = title
                            }
                            if location == "" {
                                newEntry.location = "Unknown"
                            } else {
                                newEntry.location = location
                            }
                            // await fetchAPI to finish running (it also sets newEntry's latitude and longitude properties)
                            Task {
                                await fetchAPI(entry: newEntry)
                            }
                            newEntry.date = date
                            newEntry.entryText = entryText
                            setImages(entry: newEntry) // will convert each selected image to data and any remaining images to default image data
                            
                            // managed object context to save entry, writes changes to persistant store.
                            try? moc.save()
                            
                            resetFields()
                        }) { // Button label
                            Text("Save")
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    } // End of save button section
                }
                .toolbar {
                    // Dismiss keyboard if done typing
                    ToolbarItem(placement: .keyboard) {
                        Button("Done") {
                            focusedField = nil
                        }
                    }
                }
                // Background gradient on ZStack can overwrite default background
                .onAppear{
                    UITableView.appearance().backgroundColor = .clear
                }
            }
        }.sheet(isPresented: $showSheet, content: {
            // Photo Picker will appear over full View when showSheet is true
            PhotoPicker(mediaItems: $mediaItems) { didSelectItems in
                showSheet = false // Toggle to not show when user dismisses it
            }
        }) // end of sheet
    }
}

// MARK: Result Structure
// The only two values needed from the LocationIQ API call response are lat and lon
// lat and lon match the naming in the actual API call response
struct Result: Decodable {
    var lat: String
    var lon: String
}

struct AddEntryView_Previews: PreviewProvider {
    static var previews: some View {
        AddEntryView()
    }
}
