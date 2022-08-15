//
//  photojournalApp.swift
//  photojournal
//
//  Created by Megan Korling on 7/26/22.
//  Tutorial followed: https://www.youtube.com/watch?v=bvm3ZLmwOdU&t=1s

import SwiftUI

@main
struct photojournalApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                // 3 Parts of loading/creating/saving data:
                //  1. def of entities and attributes are in data models (photojournalModels)
                //  2. NSPersistentContainer- actual data being loaded and saved to device (DataController)
                //  3. Managed Object Context: live versions of data. viewContext works with data in memory bc when data is loaded and changed it only exists in memory until it's stored on disc.
        }
    }
}
