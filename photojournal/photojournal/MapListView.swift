//
//  MapListView.swift
//  photojournal
//
//  Created by Megan Korling on 8/8/22.
//

import SwiftUI
import MapKit

struct EntryAnnotation: Identifiable {
    let id = UUID()
    let entry: Entry
    let coordinates: CLLocationCoordinate2D
}

struct MapListView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var entries: FetchedResults<Entry>
    
    func setNewArr(entriesArr: FetchedResults<Entry>) -> [EntryAnnotation] {
        var entryAnnotationArr = [EntryAnnotation]()
        for entry in entriesArr {
            let newAnnotation = EntryAnnotation(entry: entry, coordinates: CLLocationCoordinate2D(latitude: entry.latitude, longitude: entry.longitude))
            entryAnnotationArr.append(newAnnotation)
        }
        return entryAnnotationArr
    }
    
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 47.6062, longitude: -122.3321), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    var body: some View {
        let formattedEntries = setNewArr(entriesArr: entries)
        NavigationView {
            Map(coordinateRegion: $mapRegion, annotationItems: formattedEntries) { entry in
                MapAnnotation(coordinate: entry.coordinates) {
                    NavigationLink {
                        SingleEntryView(entry: entry.entry)
                    } label: {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 25, height: 25)
                    }
                }
            }
            .ignoresSafeArea()
        }
        
    }
}

struct MapListView_Previews: PreviewProvider {
    static var previews: some View {
        MapListView()
    }
}
