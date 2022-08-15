//
//  EntryListView.swift
//  photojournal
//
//  Created by Megan Korling on 7/29/22.
//

import SwiftUI

struct EntryListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var entries: FetchedResults<Entry>
    
    func deleteEntry(at offsets: IndexSet) {
        for offset in offsets {
            let entry = entries[offset]
            moc.delete(entry)
        }
        try? moc.save() // Save changes with deleted entry
    }
    
    var body: some View {
        let gradient = LinearGradient(colors: [.mint, .pink, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing)
        
        ZStack {
            gradient
                .opacity(0.30)
                .ignoresSafeArea()
            List {
                // One row is one entry. Tap to go to said Entry's View.
                // Entries are displayed by most recent Date
                // ForEach is needed in order to perform delete action
                ForEach(entries) { entry in
                    NavigationLink {
                        SingleEntryView(entry: entry)
                    } label: {
                        EntryRowView(entry: entry)
                    }
                }
                .onDelete(perform: deleteEntry)
                // Swipe to delete- swipe a little and click delete or full swipe to auto delete
            }
        }
    }
}

struct EntryListView_Previews: PreviewProvider {
    static var previews: some View {
        EntryListView()
    }
}
