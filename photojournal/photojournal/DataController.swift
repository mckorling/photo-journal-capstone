//
//  DataController.swift
//  photojournal
//
//  Created by Megan Korling on 7/28/22.
//  Tutorial followed: https://www.youtube.com/watch?v=bvm3ZLmwOdU&t=1s 

import Foundation
import CoreData
// Only need to import CoreData in this file

// Created when app launches and stays alive while it's running
class DataController: ObservableObject {
    // Responsible for loading a model and giving the data inside
    let container = NSPersistentContainer(name: "photojournalModels") // points to xcdatamodeld file
    
    // Load said data and catch error if loading fails
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("core data failed to load: \(error.localizedDescription)")
            }
            // See photojournalApp file for instantiation of DataController object
        }
    }
}
