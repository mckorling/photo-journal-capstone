//
//  SingleEntryDetail.swift
//  photo-journal
//
//  Created by Megan Korling on 7/26/22.
//

import SwiftUI

struct SingleEntryDetail: View {
    var entry: Entry
    
    var body: some View {
        ScrollView {
            Text(entry.title)
            HStack {
                Text(entry.date)
                Text(entry.location)
            }
            Text("Photos go here")
            Divider()
            Text(entry.text)
        }
    }
}

struct SingleEntryDetail_Previews: PreviewProvider {
    static var previews: some View {
        SingleEntryDetail()
    }
}
