//
//  photojournalApp.swift
//  photojournal
//
//  Created by Megan Korling on 7/26/22.
//

import SwiftUI

@main
struct photojournalApp: App {
    // make an instance of data controller and send it into swift environment
    // once app launches, store in swiftui environ, so everywhere in app can use it
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                // put it into swiftui environ
                .environment(\.managedObjectContext, dataController.container.viewContext)
                //  1. def of entities and attributes are in data models
                //  2. NSPersistentContainer- actual data being loaded and saved to device
                //  3. managed object context: live versions of data. when data is loaded and changed it only exists in memory until it's stored on disc. viewContext lets us work with data in memory. It is quicker to do it this way. load once, modify, work with memory, then save when ready.
        }
    }
}
