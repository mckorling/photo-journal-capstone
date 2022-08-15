//
//  MapView.swift
//  photojournal
//
//  Created by Megan Korling on 8/11/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    // entries doesn't need to be sorted because they'll be displayed by location
    @FetchRequest(sortDescriptors: []) var entries: FetchedResults<Entry>
    // Map default loads to view over Seattle
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 47.6062, longitude: -122.3321), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    var body: some View {
        // Use NavigationView to create tappable dots on map that send user to new View
        NavigationView {
            // 1: Set where map loads
            // 2: Provide array of things to be put on map
            // 3: Provide the content for each element in #2
            Map(coordinateRegion: $mapRegion, annotationItems: entries, annotationContent: { entry in
                // If more than one entry has the same location, they overlap with no option to decluster
                // Ideally that feature will be added in later
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: entry.latitude, longitude: entry.longitude)) {
                    NavigationLink {
                        // When user taps the Circle label representing an entry, they can view that specific entry
                        SingleEntryView(entry: entry)
                    } label: {
                        // Ideally would add some type of entry preview somewhere, or some Text to identify more about the entry other than the general location
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 25, height: 25)
                    }
                }
            })
            // Map will not overlap tab bar (ignore safe area and only the top edge)
            .ignoresSafeArea(.all, edges: .top)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
