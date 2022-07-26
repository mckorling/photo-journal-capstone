//
//  EntryRow.swift
//  photo-journal
//
//  Created by Megan Korling on 7/26/22.
//

import SwiftUI

struct EntryRow: View {
    var entry: Entry
    
    var body: some View {
        HStack {
            VStack {
                Text(entry.date)
                Text(entry.location)
            }
            Text(entry.title)
        }
    }
}

struct EntryRow_Previews: PreviewProvider {
    static var previews: some View {
        EntryRow()
    }
}
