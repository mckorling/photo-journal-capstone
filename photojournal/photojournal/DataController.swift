//
//  DataController.swift
//  photojournal
//
//  Created by Megan Korling on 7/28/22.
//

import Foundation
import CoreData


// conform to ObservableObject protocol so that we can use @state object with it
// created when app launches and stay alive as long as it's running
class DataController: ObservableObject {
    // responsible for loading a model and giving us data inside
    let container = NSPersistentContainer(name: "photojournalModels") // points to xcdatamodeld file
    // tells core data to use model in name
    // doesn't acutally load it yet
    // data models just contain the model - not the data
    
    // to load data, which might fail
    init() {
        // load persistant stores when ?? is created
        container.loadPersistentStores { description, error in
            if let error = error {
                print("core data failed to load: \(error.localizedDescription)")
            }
            // make an instance of data controller and send it into swift environment
            // once app launches, store in swiftui environ, so everywhere in app can use it
            // see photojournalApp file
        }
    }
}
