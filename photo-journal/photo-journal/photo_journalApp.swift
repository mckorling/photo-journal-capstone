//
//  photo_journalApp.swift
//  photo-journal
//
//  Created by Megan Korling on 7/26/22.
//

import SwiftUI

@main
struct photo_journalApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
