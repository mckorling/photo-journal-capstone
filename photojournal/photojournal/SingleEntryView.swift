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
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 5.0)
                    Text("\(entry.location ?? "Location"), \(entry.date!, style: .date)")
                        .padding(.bottom, 15.0)
                    Image(uiImage: UIImage(data: entry.image1!) ?? UIImage()) //force unwrapped two different things
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.all, 7.0)
                       // .cornerRadius(8)
                    Spacer()
                    Image(uiImage: UIImage(data: entry.image2!) ?? UIImage())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.all, 7.0)
                    Spacer()
                    Image(uiImage: UIImage(data: entry.image3!) ?? UIImage())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.all, 7.0)
                    Text(entry.entryText ?? "Default text")
                        .lineSpacing(10)
                        .padding(6)
                }
            }
        }
    }
}

//struct SingleEntryView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        SingleEntryView()
//    }
//}
