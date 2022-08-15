//
//  SingleEntryView.swift
//  photojournal
//
//  Created by Megan Korling on 7/29/22.
//

import SwiftUI
import CoreData

struct SingleEntryView: View {
    var entry: Entry
    
    var body: some View {
        let gradient = LinearGradient(colors: [.mint, .pink, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing)
        
        ZStack {
            gradient
                .opacity(0.30)
                .ignoresSafeArea()
            ScrollView {
                // Display all properties of an Entry: title, location, date, 3 images, and the journal text
                VStack {
                    Text(entry.title ?? "Title")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 5.0)
                        .padding(.leading, 7.0)
                    Text("\(entry.location ?? "Unknown"), \(entry.date!, style: .date)") // Show date without time
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 15.0)
                        .padding(.leading, 7.0)
                    Image(uiImage: UIImage(data: entry.image1!) ?? UIImage())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.all, 7.0)
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
                    Text(entry.entryText ?? "")
                        .lineSpacing(10)
                        .padding(7.0)
                    Spacer()
                }
            }
        }
    }
}

// Wasn't able to set up preview to take a property Entry
//struct SingleEntryView_Previews: PreviewProvider {
//    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//
//    static var previews: some View {
//        let entry = Entry(context: moc)
//        entry.title = "Preview title"
//        entry.location = "Seattle"
//        entry.date = Date()
//        entry.entryText = "this is the day I did stuff"
//
//        return ZStack {
//            SingleEntryView(entry: entry)
//        }
//      //  return SingleEntryView(entry: entry)
//    }
//}
