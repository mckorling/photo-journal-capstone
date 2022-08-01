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
        let gradient = LinearGradient(colors: [.mint, .pink, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing)
        
        ZStack {
            gradient
                .opacity(0.30)
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    Text(entry.title ?? "Title")
                    Text(entry.location ?? "Location")
                    Text(entry.date!, style: .date)
                    Image(uiImage: UIImage(data: entry.image1!) ?? UIImage()) //force unwrapped two different things
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Spacer()
                    Image(uiImage: UIImage(data: entry.image2!) ?? UIImage())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Spacer()
                    Image(uiImage: UIImage(data: entry.image3!) ?? UIImage())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Spacer()
                    Text(entry.entryText ?? "Default text")
                }
            }
        }
    }
}

//struct SingleEntryView_Previews: PreviewProvider {
//    static var previews: some View {
//        SingleEntryView()
//    }
//}
