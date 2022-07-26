//
//  NewEntry.swift
//  photo-journal
//
//  Created by Megan Korling on 7/26/22.
//

import SwiftUI

struct NewEntry: View {
    var body: some View {
        VStack {
            HStack {
                // input title
            }
            HStack {
                DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/, label: { /*@START_MENU_TOKEN@*/Text("Date")/*@END_MENU_TOKEN@*/ })
            }
            HStack {
                // input location
            }
            // select photos
            HStack {
                // enter journal text
            }
            // submit button
        }
    }
}

struct NewEntry_Previews: PreviewProvider {
    static var previews: some View {
        NewEntry()
    }
}
