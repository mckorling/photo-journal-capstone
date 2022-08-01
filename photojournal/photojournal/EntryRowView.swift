//
//  EntryRowView.swift
//  photojournal
//
//  Created by Megan Korling on 7/29/22.
//

import SwiftUI

struct EntryRowView: View {
    var entry: Entry
    
    var body: some View {
        HStack {
            VStack {
                Text(entry.location ?? "Location")
                Text(entry.date!, style: .date)
            }
            Text(entry.title ?? "Title")
        }
    }
}

//struct EntryRowView_Previews: PreviewProvider {
//    var entry: Entry
//    static var previews: some View {
//        EntryRowView(entry: entry)
//    }
//}
