//
//  SingleEntryView.swift
//  photojournal
//
//  Created by Megan Korling on 7/29/22.
//

import SwiftUI

struct SingleEntryView: View {
    var entry: Entry
    
    
    
    var body: some View {
        ScrollView {
            VStack {
                Text(entry.title ?? "Title")
                Spacer()
                Text(entry.location ?? "Location")
                Spacer()
               // Text(entry.date ?? "Date")
                
                // force unwrapped. change to default?
                List(entry.photosByteData!, id: \.self) { imageJpeg in
                    //UIImage(data: image)
                    Image(uiImage: UIImage(data: imageJpeg)!) // force unwrap. change to default image?
                }
                Text(entry.entryText ?? "No journal text was entered")
                
            }
        }
    }
}

//struct SingleEntryView_Previews: PreviewProvider {
//    static var previews: some View {
//        SingleEntryView()
//    }
//}
