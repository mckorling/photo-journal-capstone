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
            VStack (alignment: .leading) {
                Text(entry.location ?? "Location")
                Text(entry.date!, style: .date)
            }
            .padding(.trailing, 5.0)
            Text(entry.title ?? "Title")
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .trailing)
                
        }
    }
}

//struct EntryRowView_Previews: PreviewProvider {
//    var entry: Entry
//    static var previews: some View {
//        EntryRowView(entry: entry)
//    }
//}