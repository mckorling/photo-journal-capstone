//
//  EntryListView.swift
//  photojournal
//
//  Created by Megan Korling on 7/29/22.
//

import SwiftUI

struct EntryListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var entries: FetchedResults<Entry>
    
    var body: some View {
        NavigationView {
            List(entries) { entry in
                NavigationLink {
                    SingleEntryView(entry: entry)
                } label: {
                    EntryRowView(entry: entry)
                }
            }
        }
    }
}

struct EntryListView_Previews: PreviewProvider {
    static var previews: some View {
        EntryListView()
    }
}
