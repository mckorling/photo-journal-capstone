//
//  EntryList.swift
//  photo-journal
//
//  Created by Megan Korling on 7/26/22.
//

import SwiftUI

struct EntryList: View {
    var body: some View {
        NavigationView {
            List(entries) { entry in
                NavigationLink {
                    SingleEntryDetail(entry: entry)
                } label: {
                    EntryRow(entry: entry)
                }
            }
            .navigationTitle("Journal Entries")
        }
    }
}

struct EntryList_Previews: PreviewProvider {
    static var previews: some View {
        EntryList()
    }
}
